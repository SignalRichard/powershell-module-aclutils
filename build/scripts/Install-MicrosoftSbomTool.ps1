param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('-linux-x64', '-osx-x64', '-win-x64.exe')]
    [string] $OSArch,
    [string] $InstallPath
)

$LatestRelease = Invoke-RestMethod -Uri 'https://api.github.com/repos/microsoft/sbom-tool/releases/latest' -Method 'Get'
$Url = ($LatestRelease.assets | Where-Object { $_.name -match "sbom-tool$OSArch" } | Select-Object -First 1).browser_download_url
$InstallFilePath = (Join-Path -Path $InstallPath -ChildPath "sbom-tool$(if($OSArch -match 'win') { '.exe' } else { '' })")
Invoke-WebRequest -Uri $Url -OutFile $InstallFilePath

if(-not ($OSArch -match 'win')) {
    chmod +x $InstallFilePath
}

Write-Output $InstallPath >> $env:GITHUB_PATH
