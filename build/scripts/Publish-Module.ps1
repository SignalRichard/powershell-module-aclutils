param(
    [string] $ModulePath,
    [string] $ReleaseNotesFilePath
)

if(Test-Path -Path $ReleaseNotesFilePath) {
    Publish-Module -Name $ModulePath -Repository 'PSGallery' -NuGetApiKey $env:NUGETAPIKEY -ReleaseNotes (Get-Content -Path $ReleaseNotesFilePath)
}
else {
    throw "$ReleaseNotesFilePath not found."
}