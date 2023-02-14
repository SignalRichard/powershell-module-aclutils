param(
    [string] $ArtifactPath,
    [string] $ReleasePackageFilePath
)

if(Test-Path -Path $ArtifactPath) {
    if(-not (Test-Path -Path (Split-Path -Path $ReleasePackageFilePath -Parent))) {
        New-Item -ItemType Directory -Path (Split-Path -Path $ReleasePackageFilePath -Parent) -Force
    }

    Compress-Archive -Path $ArtifactPath -DestinationPath $ReleasePackageFilePath
}
else {
    throw "$ArtifactPath not found."
}
