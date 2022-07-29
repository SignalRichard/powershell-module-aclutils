param(
    [Parameter(Mandatory = $True)] [String] $Name
)

if ($Null -eq (Get-InstalledModule -Name $Name -ErrorAction 'SilentlyContinue')) {
    Write-Host "Installing $Name"
    Install-Module -Name $Name -Repository 'PSGallery' -AllowClobber -Force
}
