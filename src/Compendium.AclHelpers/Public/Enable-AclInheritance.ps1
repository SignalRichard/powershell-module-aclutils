function Enable-AclInheritance {
<#
.SYNOPSIS

Enables ACL inheritance.

.DESCRIPTION

Enabled ACL inheritance on the path specified and optionally recurses through all child objects
and ensures ACL inheritance is enabled on them as well.

.PARAMETER Path
The path to the directory or file to enable ACL inheritance.

.PARAMETER Recurse
Specifies whether to recurse over all children of the specified path.

.INPUTS
None.

.OUTPUTS
None.

.EXAMPLE

PS> Enable-AclInheritance -Path './Documents' -Recurse
#>
    param (
        [Parameter(Mandatory = $True)] [String] $Path,
        [Switch] $Recurse
    )

    $Root = Resolve-Path -Path $Path

    if($Null -ne $Root) {
        Write-Verbose "Testing: $Root"
        $Acl = Get-Acl -Path $Root

        if($Acl.AreAccessRulesProtected) {
            Write-Verbose "Enabling inheritance on: $Root"
            $Acl.SetAccessRuleProtection($false, $true)
            Set-Acl -Path $Root -AclObject $Acl
        }

        if($Recurse -and (Test-Path -Path $Root -PathType 'Container')) {
            Get-ChildItem -Path $Root | ForEach-Object {
                Enable-AclInheritance -Path $_.FullName -Recurse
            }
        }
    }
}
