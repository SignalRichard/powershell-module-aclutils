param(
    [Parameter(Mandatory = $True)] [String] $GitHubWorkspace
)

Set-Location -Path $GitHubWorkspace
Import-Module -Name 'Pester'
Get-Module -Name 'Pester'
Invoke-Pester
