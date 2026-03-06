Start-Transcript -path 'C:\Temp\lev_automation.log' -Append -Force -ErrorAction SilentlyContinue

Write-host "########################################################################"
Write-host "            Adding autologon to registry for BOPC"
Write-host "########################################################################"
Write-host " "

#region Registry Path

$compname = $env:COMPUTERNAME

#endregion

#region BOPC
if($compname -like 'B*')
{

#region Registry Path

$regPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"

#endregion

#region Registry Values

$getLogon = Get-ItemProperty -Path $regPath -Name "AutoAdminLogon" -Verbose -ErrorAction SilentlyContinue
$getUser  = Get-ItemProperty -Path $regPath -Name "DefaultUserName" -Verbose  -ErrorAction SilentlyContinue
$getPass  = Get-ItemProperty -Path $regPath -Name "DefaultPassword" -Verbose -ErrorAction SilentlyContinue
$getCount = Get-ItemProperty -Path $regPath -Name "AutoLogonCount" -Verbose -ErrorAction SilentlyContinue

#endregion

#region AutoLogon

if($getLogon -eq $null)
{
    New-ItemProperty -Path $regPath -Name "AutoAdminLogon" -Value "1" -PropertyType "String" -Force -Verbose
}
elseif($getLogon.AutoAdminLogon -ne "1")
{
    Set-ItemProperty -Path $regPath -Name "AutoAdminLogon" -Value "1" -Force -Verbose
}
else
{
    Write-Host "AutoAdminLogon is correct!"
}

#endregion

#region DefaultUser

if($getUser -eq $null)
{
    New-ItemProperty -Path $regPath -Name "DefaultUserName" -Value "xstore_user" -PropertyType "String" -Force -Verbose
}
elseif($getUser.DefaultUserName -ne "xstore_user")
{
    Set-ItemProperty -Path $regPath -Name "DefaultUserName" -Value "xstore_user" -Force -Verbose
}
else
{
    Write-Host "Username is correct!"
}

#endregion

#region DefaultPassword

if($getPass -eq $null)
{
    New-ItemProperty -Path $regPath -Name "DefaultPassword" -Value "P05u5er" -PropertyType "String" -Force -Verbose
}
elseif($getPass.DefaultPassword -ne "P05u5er")
{
    Set-ItemProperty -Path $regPath -Name "DefaultPassword" -Value "P05u5er" -Force -Verbose
}
else
{
    Write-Host "Password is correct!."
}

#endregion

#region AutoLogonCount
    if($getCount -eq $null)
    {
        New-ItemProperty -Path $regPath -Name "AutoLogonCount" -Value "1" -PropertyType "DWord" -Force -Verbose
    }
    elseif($getCount.AutoLogonCount -ne "1")
    {
        Set-ItemProperty -Path $regPath -Name "AutoLogonCount" -Value "1" -Force -Verbose
    }
    else
    {
        Write-Host "Autologon completed"
    }
}
else
{
        Write-Host "Not applicable to lead and non-lead"
}
#endregion

Stop-Transcript