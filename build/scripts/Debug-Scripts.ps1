param (
    [Parameter(Mandatory = $True)] [String] $Path
)

./Use-Module -Name 'PSScriptAnalyzer'

Invoke-Scriptanalyzer -Path $Path -Recurse -OutVariable 'Issues'

$Pass = ($Issues | Where-Object { $_.Severity -eq 'Error' }).Count -eq 0

if(-not($Pass)) {
    Write-Error -Message "Script errors detected." -ErrorAction 'Stop'
}