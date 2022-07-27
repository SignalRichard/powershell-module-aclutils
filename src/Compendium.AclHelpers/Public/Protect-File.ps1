function Protect-File {
<#
.SYNOPSIS

Protects the specified file by updating the permissions so that only the current user has access.

.DESCRIPTION

Updates the access control list (ACL) permissions on the specified file by disabling inheritance
and removing all permissions except for the current user which is granted full control.

.PARAMETER Path
Specifies the file name.

.INPUTS
None.

.OUTPUTS
None.

.EXAMPLE

PS> Protect-File -Path './ssh_key.pem'
#>
    param(
        [Parameter(Mandatory = $True)] [String] $Path
    )

    $File = Resolve-Path -Path $Path

    if(-not(Test-Path -Path "$File" -PathType 'Leaf')) {
        throw "File $File does not exist."
    }

    $Acl = Get-Acl -Path $Path
    $Acl.SetAccessRuleProtection($True, $False)
    $Owner = New-Object System.Security.Principal.NTAccount($env:USERDOMAIN, $env:USERNAME)
    $Acl.SetOwner($Owner)
    $Acl.AddAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule($Owner, [System.Security.AccessControl.FileSystemRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow)))
    Set-Acl -Path $Path -AclObject $Acl
}
