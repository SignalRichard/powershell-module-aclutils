BeforeAll {
    $ModuleRoot = $($PSCommandPath.Replace('.Tests.ps1', '').Replace('tests', 'src'))
    Import-Module -name $ModuleRoot
}

AfterAll {
    $ModuleRoot = $($PSCommandPath.Replace('.Tests.ps1', '').Replace('tests', 'src'))
    $ModuleName = Split-Path $ModuleRoot -Leaf
    Remove-Module -Name $ModuleName
}

Describe "Compendium.AclHelpers functions" {
    It "sould export Protect-File" {
        Get-Command -Name 'Protect-File' | Should -BeTrue
    }

    It "should export Enable-AclInheritance" {
        Get-Command -Name 'Enable-AclInheritance' | Should -BeTrue
    }
}

Describe "Compendium.AclHelpers Protect-File" {
    BeforeAll {
        $TestFile = 'TestDrive:\key.pem'
        New-Item -Path $TestFile -Value 'Pester Test' -ItemType 'File'
        Protect-File -Path $TestFile
        $Acl = Get-Acl -Path $TestFile
    }

    It "should disable inheritance" {
        $Acl.AreAccessRulesProtected | Should -BeTrue
    }

    It "should have one access rule" {
        $Acl.GetAccessRules($True, $True, [System.Security.Principal.NTAccount]).Count | Should -Be 1
    }

    it "should grant owner full control" {
        $Rule = $Acl.GetAccessRules($True, $True, [System.Security.Principal.NTAccount])[0]
        $Rule.IdentityReference | Should -Be $Acl.Owner
        $Rule.FileSystemRights | Should -Be 'FullControl'
    }
}

Describe "Compendium.AclHelpers Enable-AclInheritance" {
    Context "Compendium.AclHelpers Module" {
        BeforeAll {
            $ModuleRoot = $($PSCommandPath.Replace('.Tests.ps1', '').Replace('tests', 'src'))
            $ModuleName = Split-Path $ModuleRoot -Leaf
            Mock -ModuleName $ModuleName Set-Acl {} -Verifiable -ParameterFilter {
                $AclObject.AreAccessRulesProtected -eq $False
            }
            $TestPath = 'TestDrive:\keys\key.pem'
            $TestFile = 'key.pem'
            $FullFilePath = Join-Path -Path $TestPath -ChildPath $TestFile
            New-Item -Path $TestPath -ItemType 'Directory'
            New-Item -Path $TestPath -Name $TestFile -Value 'Pester Test' -ItemType 'File'
            Protect-File -Path $FullFilePath
            Enable-AclInheritance -Path $TestPath -Recurse
        }
    
        It "should enable inheritance" {
            Should -Invoke Set-Acl -ModuleName $ModuleName -Times 1 -Scope Context
        }
    }
}