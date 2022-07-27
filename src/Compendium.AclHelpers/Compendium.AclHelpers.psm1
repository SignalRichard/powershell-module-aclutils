#Requires -Version 3.0
[cmdletbinding()]
param()

Write-Verbose $PSScriptRoot

Write-Verbose 'Import everything in sub folders folder'
Get-ChildItem -Path $PSScriptRoot -Directory | ForEach-Object {
    $Root = $_.FullName
    $IsPublicModuleMember = $_.Name -eq 'Public'
    Write-Verbose "Processing folder: $Root"

    $Files = Get-ChildItem -Path $Root -Filter '*.ps1' -Recurse

    # dot source each file
    $Files | Where-Object {
        $_.Name -NotLike '*.Tests.ps1'
    } | ForEach-Object {
        Write-Verbose $_.BaseName
        . $PSItem.FullName
        if($IsPublicModuleMember) {
            Export-ModuleMember -Function $_.BaseName
        }
    }
}
