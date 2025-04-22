Using module ../../modules/Common.psm1
Using module ../../modules/AzureDevOps.psm1

[cmdletbinding()]
param(
    [Parameter(Mandatory)] [string] $AzureDevOpsPAT,
    [Parameter(Mandatory)] [string] $AzureDevOpsOrganization,
    [Parameter(Mandatory)] [string] $AzureDevOpsProject,
    [Parameter(Mandatory)] [string] $GroupName,
    [Parameter(Mandatory)] [string] $DeploymentOutputFile
)

if (-NOT (Test-Path $DeploymentOutputFile)){
    Write-Error "Deployment output file '$DeploymentOutputFile' does not exists"
    exit -1
}

SetupAzureDevOps -AzureDevOpsPAT $AzureDevOpsPAT -AzureDevOpsProject $AzureDevOpsProject -AzureDevOpsOrganizationURI $AzureDevOpsOrganization -Verbose:$VerbosePreference

$GroupId = CreateAzureDevOpsVariableGroup -VariableGroupName $GroupName -Verbose:$VerbosePreference

CreateAzureDevopsVGVariablesFromDeployment -VariableGroupId $GroupId -DeploymentOutputFile $DeploymentOutputFile
