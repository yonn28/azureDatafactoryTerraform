Using module ./modules/KeyVault.psm1

BeforeAll {
    $rgName = $env:ACC_TEST_RESOURCE_GROUP
    $dataFactoryName = $env:ACC_TEST_DATA_FACTORY_NAME
    $sharedKvRgName = $env:ACC_TEST_SHARED_KEY_VAULT_RESOURCE_GROUP
    $sharedKeyVaultName = $env:ACC_TEST_SHARED_KEY_VAULT_NAME
    $location = $env:ACC_TEST_LOCATION
}

Describe "Shared Key Vault" -Tag "Acceptance" {
    BeforeAll {
        $keyVault = Get-AzKeyVault -ResourceGroupName $sharedKvRgName -Name $sharedKeyVaultName
        $dataFactory = Get-AzDataFactoryV2 -ResourceGroupName $rgName -Name $dataFactoryName
    }
    Context "Resource" {
        It "Exists" {
            $keyVault | Should -Not -BeNullOrEmpty
        }
        It "Is In Expected Location" {
            $keyVault.Location | Should -Be $location
        }
    }
    Context "Access Policy"{
        It "Azure Data Factory should list and get"{
            CheckKeyVaultAccessPolicy -KeyVault $keyVault -ObjectID $dataFactory.Identity.PrincipalId -SecretAccessList @("get", "list") | Should -BeTrue
        }
    }
}
