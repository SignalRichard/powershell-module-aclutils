./Use-Module -Name 'Pester'
Set-Location -Path $env:GITHUB_WORKSPACE
Invoke-Pester
