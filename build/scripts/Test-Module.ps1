./Use-Module -Name 'Pester'
Set-Location -Path $env:GITHUB_WORKSPACE
Import-Module -Name 'Pester'
Get-Module -Name 'Pester'
Invoke-Pester
