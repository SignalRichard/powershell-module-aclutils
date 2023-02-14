$Modules = @(
    @{ Name = 'PSScriptAnalyzer'; Repository = 'PSGallery'; RequiredVersion = '1.21.0'; AllowClobber = $true; Force = $true }
    @{ Name = 'Pester'; Repository = 'PSGallery'; RequiredVersion = '5.4.0'; AllowClobber = $true; Force = $true }
)

function Install-PowerShellModules {
    foreach($Module in $Modules) {
        Install-Module @Module
    }
}

function Import-PowerShellModules {
    foreach($Module in $Modules) {
        $Module.Remove('Repository')
        $Module.Remove('AllowClobber')
        Import-Module @Module
    }
}
