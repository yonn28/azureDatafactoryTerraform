param(
    [string] $SolutionTemplateFolder = "./infrastructure-as-code"
)

$ArmTtkModule = "arm-ttk"
$TtkFolder = "./scripts/azure-pipelines/iac/arm-ttk"

$ErrorActionPreference = "Continue"

if (!(Get-Module -Name $ArmTtkModule)) {
    Import-Module $TtkFolder/arm-ttk/arm-ttk.psd1
}

$testOutput = @(Test-AzTemplate -TemplatePath $SolutionTemplateFolder)
$testOutput

if ($testOutput | ? { $_.Errors }) {
    Write-Host "##vso[task.logissue type=error;]Linter has found some problems."
    exit 1
}
