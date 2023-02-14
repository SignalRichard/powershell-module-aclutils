param(
    [switch] $DryRun
)

if($env:GH_REF -eq 'refs/heads/main') {
    if($DryRun) {
        npx semantic-release --dry-run
    }
    else {
        npx semantic-release
    }
    
    Write-Output "SEMANTIC_VERSION=$(Get-Content -Path 'SEMANTIC-VERSION.txt')" >> $env:GITHUB_OUTPUT
}
else {
    Write-Output "SEMANTIC_VERSION=0.0.1" >> $env:GITHUB_OUTPUT
}