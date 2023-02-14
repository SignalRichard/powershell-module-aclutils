. $PSScriptRoot/Packages.ps1
Import-PowerShellModules
Set-Location -Path $env:GITHUB_WORKSPACE
Invoke-Pester
