param (
    [Parameter(Mandatory = $True)] [String] $Path
)

. $PSScriptRoot/Packages.ps1
Import-PowerShellModules

Invoke-Scriptanalyzer -Path $Path -Recurse -OutVariable 'Issues'

$Pass = ($Issues | Where-Object { $_.Severity -eq 'Error' }).Count -eq 0

if(-not($Pass)) {
    Write-Error -Message "Script errors detected." -ErrorAction 'Stop'
}