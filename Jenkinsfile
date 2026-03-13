pipeline {
  agent any

  parameters {
    string(name: 'GIT_BRANCH', defaultValue: 'master', description: 'Branch to build')

    // MULTI secret list:
    // One per line: KEY=SECRET_ID
    // Example:
    // MULE=15763
    // CENTIRO=12345
    text(name: 'DELINEA_SECRETS',
         defaultValue: 'MULE=15763',
         description: 'Multiple Delinea secrets: one per line as KEY=SECRET_ID. Placeholders must be @KEY_USER@ and @KEY_PASSWORD@')
  }

  tools {
    ant 'ANT_1.10'
    jdk 'JDK-11'
  }

  options {
    timestamps()
    disableConcurrentBuilds()
  }

  stages {

    stage('Checkout') {
      steps {
        checkout([$class: 'GitSCM',
          branches: [[name: "*/${params.GIT_BRANCH}"]],
          userRemoteConfigs: [[url: 'https://github.com/amol-gadhave/sb_microservice.git']]
        ])
        echo "Building branch: ${params.GIT_BRANCH}"
      }
    }

    stage('Inject credentials from Delinea into multiple properties') {
      steps {
        withCredentials([
          usernamePassword(
            credentialsId: 'py-delinea',
            usernameVariable: 'SS_USERNAME',
            passwordVariable: 'SS_PASSWORD'
          )
        ]) {
          // Pass the multi-line secret map into PowerShell safely
          withEnv(["DELINEA_SECRETS=${params.DELINEA_SECRETS}"]) {

            powershell(script: '''
              [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
              $ProgressPreference = 'SilentlyContinue'
              $ErrorActionPreference = 'Stop'

              # -------------------------------
              # Helpers to read values safely from different API shapes
              # -------------------------------
              function Get-ItemName($item) {
                if ($null -eq $item) { return $null }
                if ($item.PSObject.Properties.Name -contains 'fieldName') { return [string]$item.fieldName }
                if ($item.PSObject.Properties.Name -contains 'slug')      { return [string]$item.slug }
                if ($item.PSObject.Properties.Name -contains 'name')      { return [string]$item.name }
                return $null
              }

              function Get-ItemValue($item) {
                if ($null -eq $item) { return $null }
                if ($item.PSObject.Properties.Name -contains 'value')     { return [string]$item.value }
                if ($item.PSObject.Properties.Name -contains 'itemValue') { return [string]$item.itemValue }
                return $null
              }

              function Extract-UsernamePassword($secret) {
                $items = $secret.items
                if (-not $items) { return @{ user = $null; pwd = $null } }

                # Match common naming patterns (case-insensitive):
                $userItem = $items | Where-Object {
                  (Get-ItemName $_) -match '(?i)^(username|user|login|account|userid)$' -or (Get-ItemName $_) -match '(?i)user(name)?|login|account'
                } | Select-Object -First 1

                $pwdItem = $items | Where-Object {
                  (Get-ItemName $_) -match '(?i)^password$' -or (Get-ItemName $_) -match '(?i)password'
                } | Select-Object -First 1

                return @{
                  user = (Get-ItemValue $userItem)
                  pwd  = (Get-ItemValue $pwdItem)
                }
              }

              # -------------------------------
              # 1) Get OAuth token (password grant)
              # Token endpoint is documented internally under Levi Safe usage guides [1](https://levi-my.sharepoint.com/personal/psisodia_levi_com/_layouts/15/Doc.aspx?sourcedoc=%7BD76E1DB1-15D8-49D7-8943-7B62D236AD12%7D&file=Levi-Safe-Doc%20V1.1.docx&action=default&mobileredirect=true&DefaultItemOpen=1)[2](https://levi-my.sharepoint.com/personal/prkushwaha_levi_com/Documents/Microsoft%20Teams%20Chat%20Files/Secret_Management_Guide%201.pdf?web=1)
              # -------------------------------
              $tokenBody = @{
                username   = $env:SS_USERNAME
                password   = $env:SS_PASSWORD
                grant_type = 'password'
              }

              $token = Invoke-RestMethod `
                -Method Post `
                -Uri 'https://levisafe.secretservercloud.com/oauth2/token' `
                -Body $tokenBody `
                -ContentType 'application/x-www-form-urlencoded'

              if (-not $token.access_token) {
                throw 'No access_token returned from Delinea token endpoint.'
              }

              $headers = @{
                Authorization = ('Bearer {0}' -f $token.access_token)
                Accept        = 'application/json'
              }

              # -------------------------------
              # 2) Parse DELINEA_SECRETS parameter: KEY=SECRET_ID per line
              # -------------------------------
              $raw = $env:DELINEA_SECRETS
              if (-not $raw) { throw 'DELINEA_SECRETS parameter is empty.' }

              $secretMap = @{}
              $lines = $raw -split "(`r`n|`n|`r)"
              foreach ($line in $lines) {
                $t = $line.Trim()
                if (-not $t) { continue }
                if ($t.StartsWith('#')) { continue }

                $parts = $t.Split('=', 2)
                if ($parts.Count -ne 2) {
                  throw ("Invalid DELINEA_SECRETS line (expected KEY=SECRET_ID): {0}" -f $t)
                }

                $key = $parts[0].Trim().ToUpper()
                $id  = $parts[1].Trim()

                if (-not $key -or -not $id) {
                  throw ("Invalid DELINEA_SECRETS line (blank KEY or SECRET_ID): {0}" -f $t)
                }

                $secretMap[$key] = $id
              }

              if ($secretMap.Count -eq 0) { throw 'No valid KEY=SECRET_ID entries found in DELINEA_SECRETS.' }

              Write-Host ("Secrets requested: {0}" -f ($secretMap.Keys -join ', '))

              # -------------------------------
              # 3) Fetch each secret using API v2: GET /api/v2/secrets/SECRET_ID
              # Documented in internal Levi Safe guide [1](https://levi-my.sharepoint.com/personal/psisodia_levi_com/_layouts/15/Doc.aspx?sourcedoc=%7BD76E1DB1-15D8-49D7-8943-7B62D236AD12%7D&file=Levi-Safe-Doc%20V1.1.docx&action=default&mobileredirect=true&DefaultItemOpen=1)
              # -------------------------------
              $creds = @{}  # key -> @{ user=...; pwd=... }

              foreach ($k in $secretMap.Keys) {
                $sid = $secretMap[$k]

                $secret = Invoke-RestMethod `
                  -Method Get `
                  -Uri ("https://levisafe.secretservercloud.com/api/v2/secrets/{0}" -f $sid) `
                  -Headers $headers

                $up = Extract-UsernamePassword $secret

                if (-not $up.user) {
                  throw ("Secret {0} (ID {1}) returned no username field. Check template field names." -f $k, $sid)
                }
                if (-not $up.pwd) {
                  throw ("Secret {0} (ID {1}) returned no password field. Check template field names." -f $k, $sid)
                }

                # Store (do NOT print values)
                $creds[$k] = $up
              }

              # -------------------------------
              # 4) Replace placeholders in multiple properties files
              # Placeholders: @KEY_USER@ and @KEY_PASSWORD@
              # -------------------------------
              $rootDir = Join-Path $env:WORKSPACE 'tet_pos\\updates'
              if (-not (Test-Path $rootDir)) {
                throw ("Properties folder not found at: {0}" -f $rootDir)
              }

              $files = Get-ChildItem -Path $rootDir -Recurse -Filter '*.properties' -File
              if (-not $files -or $files.Count -eq 0) {
                throw ("No .properties files found under: {0}" -f $rootDir)
              }

              $scanned = 0
              $changed = 0

              foreach ($f in $files) {
                $scanned++
                $content = Get-Content -Path $f.FullName -Raw
                $updated = $content

                foreach ($k in $creds.Keys) {
                  $userPh = ('@{0}_USER@' -f $k)
                  $pwdPh  = ('@{0}_PASSWORD@' -f $k)

                  $updated = $updated.Replace($userPh, $creds[$k].user)
                  $updated = $updated.Replace($pwdPh,  $creds[$k].pwd)
                }

                if ($updated -ne $content) {
                  Set-Content -Path $f.FullName -Value $updated -Encoding UTF8
                  $changed++
                  Write-Host ("Updated: {0}" -f $f.FullName)
                } else {
                  Write-Host ("No change: {0}" -f $f.FullName)
                }
              }

              Write-Host ("Done. Scanned: {0} file(s), Updated: {1} file(s) under tet_pos\\updates." -f $scanned, $changed)
            ''')
          }
        }
      }
    }

    stage('Ant Make') {
      steps {
        bat 'ant -f tet\\jenkins-build.xml make'
      }
    }
  }
}