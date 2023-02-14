param(
    [Parameter(Mandatory = $True)] [String] $PSModuleManifestFilePath,
    [Parameter(Mandatory = $True)] [string] $SemanticVersion
)

if(Test-Path -Path $PSModuleManifestFilePath) {
    Update-ModuleManifest -Path $PSModuleManifestFilePath -ModuleVersion $SemanticVersion
}
else {
    throw "$PSModuleManifestFilePath does not exist."
}
