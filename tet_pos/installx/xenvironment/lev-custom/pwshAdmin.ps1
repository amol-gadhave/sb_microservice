$AnotherFilePath=$args[0]
$CompName  = $env:computername
$LocalUser = "$compName\suplevi"
$LocalPass = ConvertTo-SecureString -String "Trex5rz6" -AsPlainText -Force
$LocalCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $LocalUser,$LocalPass

Start-Process powershell.exe -ArgumentList "-executionpolicy bypass -File $AnotherFilePath" -Credential $LocalCred
