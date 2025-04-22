Using module ../../modules/Common.psm1
Using module ../../modules/AzureDevOps.psm1

[cmdletbinding()]
param(
    [Parameter(Mandatory)] [string] [ValidateSet("dev", "qas", "prd", "sandbox")] $Environment,
    [Parameter(Mandatory)] [string] $Location,
    [Parameter(Mandatory)] [string] $DomainName,
    [Parameter(Mandatory)] [string] $OutputPlanFile,
    [boolean] $OutputSummary = $true,
    [string] $SolutionTemplateFile = "./infrastructure-as-code/azuredeploy.json",
    [string] $SolutionParametersFile = "./infrastructure-as-code/parameters/parameters.$Environment.json",
    [string] $VersionDescription = "",
    [string] $VersionBuildId = "",
    [string] $VersionAuthor = ""
)

if (-NOT (Test-Path $SolutionTemplateFile)){
    Write-Host "$SolutionTemplateFile does not exists" -ForegroundColor Red
    exit -1
}

if (-NOT (Test-Path $SolutionParametersFile)){
    Write-Host "$SolutionParametersFile does not exists" -ForegroundColor Red
    exit -1
}

if (!$VersionBuildId){
    $VersionBuildId = (git rev-parse HEAD).substring(0,7)
}

Write-Verbose "Start planning $DomainName on $Environment environment at $Location"

Write-Verbose "Previewing template deployment changes..."

$TemplateDeploymentWhatIfResult = Get-AzDeploymentWhatIfResult -Name $VersionBuildId `
                                                               -Location $Location `
                                                               -TemplateFile $SolutionTemplateFile `
                                                               -TemplateParameterFile $SolutionParametersFile `
                                                               -SkipTemplateParameterPrompt

CreateMarkdownFromObject -Object $TemplateDeploymentWhatIfResult -OutputFileName $OutputPlanFile -OverWrite $true

if ($OutputSummary){
    CreateAzureDevOpsAttachment -AttachmentName $Environment -AttachmentFile $OutputPlanFile
}
