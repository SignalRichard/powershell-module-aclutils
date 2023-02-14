param(
    [string] $ReleasePath,
    [string] $SourcePath,
    [string] $PackageName,
    [string] $Version,
    [string] $Owner = "$env:GITHUB_REPOSITORY_OWNER",
    [string] $Namespace = "$env:GITHUB_SERVER_URL/$env:GITHUB_REPOSITORY"
)

sbom-tool generate -b "$ReleasePath" -bc "$SourcePath" -pn "$PackageName" -pv "$Version" -ps "$Owner" -nsb "$Namespace"
