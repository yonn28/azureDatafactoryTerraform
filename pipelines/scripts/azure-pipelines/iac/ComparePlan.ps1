Using module ../../modules/Common.psm1
Using module ../../modules/AzureDevOps.psm1
Using module ../../modules/PlanComparison.psm1

[cmdletbinding()]
param(
    [Parameter(Mandatory)] [string] [ValidateSet("dev", "qas", "prd", "sandbox")] $Environment,
    [Parameter(Mandatory)] [string] $PlanFile1,
    [Parameter(Mandatory)] [string] $PlanFile2,
    [bool] $OutputSummary = $true,
    [string] $ComparePlanOutputFile = "comparePlanOutput.md"
)

if (-NOT (Test-Path $PlanFile1)) {
    Write-Host "PlanFile1 '$PlanFile1' does not exists"
    exit -1
}

if (-NOT (Test-Path $PlanFile2)) {
    Write-Host "PlanFile2 '$PlanFile2' does not exists"
    exit -1
}

$plan1_content = GetPlanContent -PlanFile $PlanFile1
$plan2_content = GetPlanContent -PlanFile $PlanFile2

if (Compare-Object $plan1_content $plan2_content) {
    Write-Warning "#####################    The deployment plans didn't match in $Environment   ##################### "
    CreateCompareMarkdownFile -Content1 $plan1_content -Content2 $plan2_content -OutputFileName $ComparePlanOutputFile
    if ($OutputSummary) {
        CreateAzureDevOpsAttachment -AttachmentName $Environment -AttachmentFile $ComparePlanOutputFile
    }
    exit -1
}
else {
    Write-Warning "#####################    The plans matched in $Environment   ##################### "
}