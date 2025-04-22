Using module ../../modules/Common.psm1
Using module ../../modules/AzureDevOps.psm1

[cmdletbinding()]
param(
    [Parameter(Mandatory)] [string] $AzureDevOpsPAT,
    [Parameter(Mandatory)] [string] $AzureDevOpsOrganization,
    [Parameter(Mandatory)] [string] $AzureDevOpsProject,
    [Parameter(Mandatory)] [string] $DomainName,
    [Parameter(Mandatory)] [string] $Environment
)

Write-Verbose "Acceptance test $DomainName ($Environment) on $Location"

SetupAzureDevOps -AzureDevOpsPAT $AzureDevOpsPAT -AzureDevOpsProject $AzureDevOpsProject -AzureDevOpsOrganizationURI $AzureDevOpsOrganization -Verbose:$VerbosePreference

$variables = GetAzureDevOpsVariableGroup -VariableGroupName "iac-cd-output-$DomainName-$Environment" -Verbose:$VerbosePreference

CreateEnvironmentVariablesFromHashTable -Variables $variables -VariablePrefix "ACC_TEST_" -Verbose:$VerbosePreference

Write-Verbose "Filtering environments that should be excluded..."
$filtered = "dev", "qas", "prd" | Where-Object { $_ -ne $Environment }

Write-Verbose "Running acceptance tests..."

Invoke-Pester -CI -Output Detailed ./infrastructure-as-code/tests/ -ExcludeTagFilter $filtered