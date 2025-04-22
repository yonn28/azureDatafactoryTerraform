BeforeAll {
    $rgName = $env:ACC_TEST_RESOURCE_GROUP
    $location = $env:ACC_TEST_LOCATION
}

Describe "Resource Group" -Tag "Acceptance" {
    BeforeAll {
        $rg = Get-AzResourceGroup -Name $rgName
    }
    Context "Resource" {
        It "Exists" {
            $rg | Should -Not -BeNullOrEmpty
        }
        It "ProvisioningState Is Succeeded" {
            $rg.ProvisioningState | Should -Be "Succeeded"
        }
        It "Is In Expected Location" {
            $rg.Location | Should -Be $location
        }
    }
}
