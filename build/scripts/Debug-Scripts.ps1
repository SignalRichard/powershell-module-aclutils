param (
    [Parameter(Mandatory = $True)] [String] $Path
)

./Use-Module -Name 'PSScriptAnalyzer'

$Result = Invoke-Scriptanalyzer -Path $Path -Recurse
$Result | Format-Table

if ($Null -ne $Result) {
    throw "$RequiredModule returned issues."
}
