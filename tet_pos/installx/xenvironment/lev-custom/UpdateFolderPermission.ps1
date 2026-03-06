Start-Transcript -path 'C:\Temp\lev_automation.log' -Append -Force -ErrorAction SilentlyContinue

Write-host "########################################################################"
Write-host "             Applying Permissions during Environment update"
Write-host "########################################################################"
Write-host " "

#region Set Users

    $identityDomain    = "levi\domain users"
    $identityLocalUser = "Users"
    $identityEveryone  = "Everyone"

#endregion

#region Set Permissions types

    $Permission  = [System.Security.AccessControl.FileSystemRights]::FullControl
    $inheritance = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit, [System.Security.AccessControl.InheritanceFlags]::ObjectInherit
    $propagation = [System.Security.AccessControl.PropagationFlags]::None
    $Type        = [System.Security.AccessControl.AccessControlType]::Allow

#region Set folders

    $ACE1 = New-Object System.Security.AccessControl.FileSystemAccessRule($identityDomain,$Permission,$inheritance,$Propagation,$Type)
    $ACE2 = New-Object System.Security.AccessControl.FileSystemAccessRule($identityLocalUser,$Permission,$inheritance,$Propagation,$Type)
    $ACE3 = New-Object System.Security.AccessControl.FileSystemAccessRule($identityEveryone,$Permission,$inheritance,$Propagation,$Type)

#endregion

#region Set ACL Paths

    $ACLPaths = "c:\app",
                "c:\backupxstore",
                "c:\eftlink",
                "c:\eftlink_mobile",
                "c:\environment",
                "c:\jre",
                "c:\oracle",
                "c:\xservices",
                "c:\xservices-config",
                "c:\xservices-log",
                "c:\xstore",
                "c:\xstoredata",
                "c:\xstoredb",
                "c:\xstoreInstallers",
                "c:\xstore-mobile",
                "c:\xstoreposinstall"

#endregion   

#region Set permissions

    foreach ($aclPath in $aclPaths)
    {
        $acl = Get-Acl -Path $aclpath -Verbose -ErrorAction SilentlyContinue
        $acl.AddAccessRule($ace1)
        $acl.AddAccessRule($ace2)
        $acl.AddAccessRule($ace3)
        $acl.SetAccessRuleProtection($false, $true)
        Set-Acl -Path $aclPath -AclObject $acl -Verbose -ErrorAction SilentlyContinue
    }

#endregion

Stop-Transcript