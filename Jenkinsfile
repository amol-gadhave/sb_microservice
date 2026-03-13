
pipeline {
  agent any

  parameters {
    string(name: 'GIT_BRANCH', defaultValue: 'master', description: 'Branch to build')
    string(name: 'DELINEA_SECRET_ID', defaultValue: '15763', description: 'Delinea Secret ID containing Mule username/password')
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

    stage('Inject Mule credentials from Delinea into properties') {
      steps {
        withCredentials([
          usernamePassword(
            credentialsId: 'py-delinea',
            usernameVariable: 'SS_USERNAME',
            passwordVariable: 'SS_PASSWORD'
          )
        ]) {
          // pass secret id safely to PowerShell without Groovy string interpolation issues
          withEnv(["DELINEA_SECRET_ID=${params.DELINEA_SECRET_ID}"]) {

            powershell(script: '''
              [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
              $ProgressPreference = 'SilentlyContinue'
              $ErrorActionPreference = 'Stop'

              # --- 1) Get OAuth token (password grant) ---
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

              # --- 2) Fetch secret (API v2) ---
              # Internal doc shows GET uses /api/v2/secrets/SECRET_ID [1](https://levi.sharepoint.com/sites/MachineLearningEngineering/_layouts/15/Doc.aspx?sourcedoc=%7B6C8523BD-990A-4B49-A795-48341C8A7D41%7D&file=000__%20Mulesoft%20Endpoint%20Pass-Thru.doc&action=default&mobileredirect=true&DefaultItemOpen=1)
              $headers = @{
                Authorization = ('Bearer {0}' -f $token.access_token)
                Accept        = 'application/json'
              }

              $secretId = $env:DELINEA_SECRET_ID
              if (-not $secretId) { throw 'DELINEA_SECRET_ID is empty.' }

              $secret = Invoke-RestMethod `
                -Method Get `
                -Uri ("https://levisafe.secretservercloud.com/api/v1/secrets/{0}" -f $secretId) `
                -Headers $headers

              # --- 3) Extract Mule username + password (v2-style) ---
              # If your field names differ, adjust 'Username'/'Password' accordingly.
              $muleUser = ($secret.items | Where-Object { $_.fieldName -eq 'username' } | Select-Object -First 1).value
              $mulePwd  = ($secret.items | Where-Object { $_.fieldName -eq 'password' } | Select-Object -First 1).value

              if (-not $muleUser) { throw "Secret retrieved but no 'username' field found (check Delinea template field names)." }
              if (-not $mulePwd)  { throw "Secret retrieved but no 'password' field found (check Delinea template field names)." }

              # --- 4) Replace placeholders in multiple properties files ---
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

                if ($content -notmatch '@MULE_USER@' -and $content -notmatch '@MULE_PASSWORD@') {
                  Write-Host ("Placeholders not present in: {0}" -f $f.FullName)
                  continue
                }

                # literal replace (safe for special chars)
                $updated = $content.Replace('@MULE_USER@', $muleUser).Replace('@MULE_PASSWORD@', $mulePwd)

                if ($updated -ne $content) {
                  Set-Content -Path $f.FullName -Value $updated -Encoding UTF8
                  $changed++
                  Write-Host ("Updated: {0}" -f $f.FullName)
                } else {
                  Write-Host (" No change after replacement: {0}" -f $f.FullName)
                }
              }

              Write-Host (" Done. Scanned: {0} file(s), Updated: {1} file(s) under tet_pos\\updates." -f $scanned, $changed)
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
