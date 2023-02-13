param(
    [switch] $DryRun
)

if($DryRun) {
    npx semantic-release --dry-run
}
else {
    npx semantic-release
}

Write-Output "SEMANTIC_VERSION=$(Get-Content -Path 'SEMANTIC-VERSION.txt')" >> $env:GITHUB_OUTPUT
