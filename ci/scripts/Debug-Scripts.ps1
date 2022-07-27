param (
    [Parameter(Mandatory = $True)] [String] $Path
)

$RequiredModule = 'PSScriptAnalyzer'
if($Null -eq (Get-InstalledModule -Name $RequiredModule -ErrorAction 'SilentlyContinue')) {
    Write-Host "Installing $RequiredModule"
    Install-Module -Name $RequiredModule -Repository 'PSGallery' -AllowClobber -Force
}

Write-Host "Importing $RequiredModule"
Import-Module -Name $RequiredModule -Force

$Result = Invoke-Scriptanalyzer -Path $Path -Recurse
$Result | Format-Table

if($Null -ne $Result) {
    throw "$RequiredModule returned issues."
}
