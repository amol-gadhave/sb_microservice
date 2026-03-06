
pipeline {
  agent any
  
  
  parameters {
    string(name: 'GIT_BRANCH', defaultValue: 'master', description: 'Branch to build')
  
  }
  
  tools {
    ant 'ANT_1.10'   // Jenkins → Manage Jenkins → Tools
    jdk 'JDK-11'     // Optional, if Ant build needs Java
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

      
  stage('Ant Make') {
      steps {
       // ant buildFile: 'tet/jenkins-build.xml',
       //    targets: 'make'
			
			
		bat 'ant -f tet\\jenkins-build.xml make'

      }
    }
    stage('Delinea: Token + Fetch Secret') {
      steps {
        withCredentials([
          usernamePassword(
            credentialsId: 'py-delinea',
            usernameVariable: 'SS_USERNAME',
            passwordVariable: 'SS_PASSWORD'
          )
        ]) {
          powershell '''
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            $ProgressPreference = 'SilentlyContinue'

            # 1) Get OAuth token (password grant) - LeviSafe documented pattern
            $tokenBody = @{
              username   = $env:SS_USERNAME
              password   = $env:SS_PASSWORD
              grant_type = "password"
            }

            $token = Invoke-RestMethod `
              -Method Post `
              -Uri "https://levisafe.secretservercloud.com/oauth2/token" `
              -Body $tokenBody `
              -ContentType "application/x-www-form-urlencoded"

            if (-not $token.access_token) {
              throw "No access_token returned from Delinea token endpoint."
            }

            # 2) Fetch secret (use API v1 for best compatibility with password-grant token)
            $headers = @{
              Authorization = "Bearer $($token.access_token)"
              Accept        = "application/json"
              "Content-Type"= "application/json"
            }

            $secret = Invoke-RestMethod `
              -Method Get `
              -Uri "https://levisafe.secretservercloud.com/api/v1/secrets/15763" `
              -Headers $headers

            # Extract password field (commonly 'password' slug)
            $pwd = ($secret.items | Where-Object { $_.slug -eq "password" } | Select-Object -First 1).itemValue

            if (-not $pwd) {
              throw "Secret retrieved but no 'password' item found (check template field slugs)."
            }

            Write-Host "$pwd ✅ Delinea secret retrieved successfully"
          '''
        }
      }
    }
  }
}
