
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

   
	
	  stage('Inject Mule credentials from Delinea into xstore.properties') {
      steps {
        withCredentials([
          usernamePassword(
            credentialsId: 'py-delinea',
            usernameVariable: 'SS_USERNAME',
            passwordVariable: 'SS_PASSWORD'
          )
        ]) {
          powershell """
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            \$ProgressPreference = 'SilentlyContinue'

            # --- 1) Get OAuth token (password grant) ---
            \$tokenBody = @{
              username   = \$env:SS_USERNAME
              password   = \$env:SS_PASSWORD
              grant_type = "password"
            }

            \$token = Invoke-RestMethod `
              -Method Post `
              -Uri "https://levisafe.secretservercloud.com/oauth2/token" `
              -Body \$tokenBody `
              -ContentType "application/x-www-form-urlencoded"

            if (-not \$token.access_token) {
              throw "No access_token returned from Delinea token endpoint."
            }

            # --- 2) Fetch secret (API v1) ---
            \$headers = @{
              Authorization = "Bearer \$((\$token.access_token))"
              Accept        = "application/json"
              "Content-Type"= "application/json"
            }

            \$secretId = "${params.DELINEA_SECRET_ID}"
            \$secret = Invoke-RestMethod `
              -Method Get `
              -Uri "https://levisafe.secretservercloud.com/api/v1/secrets/\$secretId" `
              -Headers \$headers

            # --- 3) Extract Mule username + password from secret fields ---
            # Adjust these slugs if your template uses different names
            \$muleUser = (\$secret.items | Where-Object { \$_.slug -eq "username" } | Select-Object -First 1).itemValue
            \$mulePwd  = (\$secret.items | Where-Object { \$_.slug -eq "password" } | Select-Object -First 1).itemValue

            if (-not \$muleUser) { throw "Secret retrieved but no 'username' field found (check template field slugs)." }
            if (-not \$mulePwd)  { throw "Secret retrieved but no 'password' field found (check template field slugs)." }

           

			// --- 4) Replace placeholders in multiple properties files ---
			powershell('''
			$ErrorActionPreference = 'Stop'
			
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
			
				# If neither placeholder exists, skip (no error)
				if ($content -notmatch '@MULE_USER@' -and $content -notmatch '@MULE_PASSWORD@') {
				Write-Host ("ℹ️ Placeholders not present in: {0}" -f $f.FullName)
				continue
				}
			
				# Literal replace (NOT regex) => safe for special chars in passwords
				$updated = $content.Replace('@MULE_USER@', $muleUser).Replace('@MULE_PASSWORD@', $mulePwd)
			
				if ($updated -ne $content) {
				Set-Content -Path $f.FullName -Value $updated -Encoding UTF8
				$changed++
				Write-Host ("✅ Updated: {0}" -f $f.FullName)
				} else {
				Write-Host ("ℹ️ No change after replacement: {0}" -f $f.FullName)
				}
			}
			
			Write-Host ("✅ Done. Scanned: {0} file(s), Updated: {1} file(s) under tet_pos\\updates." -f $scanned, $changed)
			''')

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
