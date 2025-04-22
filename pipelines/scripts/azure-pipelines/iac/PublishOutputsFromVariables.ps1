Using module ../../modules/Common.psm1
Using module ../../modules/AzureDevOps.psm1

[cmdletbinding()]
param(
    [Parameter(Mandatory)] [string] $AzureDevOpsPAT,
    [Parameter(Mandatory)] [string] $AzureDevOpsOrganization,
    [Parameter(Mandatory)] [string] $AzureDevOpsProject,
    [Parameter(Mandatory)] [string] $GroupName,
    [Parameter(Mandatory)] [string[]] $Variables
)

SetupAzureDevOps -AzureDevOpsPAT $AzureDevOpsPAT -AzureDevOpsProject $AzureDevOpsProject -AzureDevOpsOrganizationURI $AzureDevOpsOrganization -Verbose:$VerbosePreference

$GroupId = CreateAzureDevOpsVariableGroup -VariableGroupName $GroupName -Verbose:$VerbosePreference

CreateAzureDevopsVGVariablesFromVariables -VariableGroupId $GroupId -Variables $Variables
