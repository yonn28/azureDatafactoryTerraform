[cmdletbinding()]
param(
    [Parameter(Mandatory)] [string] [ValidateSet("dev", "qas", "prd", "sandbox")] $Environment,
    [Parameter(Mandatory)] [string] $Location,
    [Parameter(Mandatory)] [string] $DomainName,
    [string] $SolutionTemplateFile = "./infrastructure-as-code/azuredeploy.json",
    [string] $SolutionParametersFile = "./infrastructure-as-code/parameters/parameters.$Environment.json",
    [string] $DeploymentOutputFile
)

$ErrorActionPreference = "Stop"

Write-Verbose "Start deploying $DomainName on $Location"

if (-NOT (Test-Path $SolutionTemplateFile)){
    Write-Error "$SolutionTemplateFile does not exists"
    exit -1
}

if (-NOT (Test-Path $SolutionParametersFile)){
    Write-Error "$SolutionParametersFile does not exists"
    exit -1
}

$Version = (git rev-parse HEAD).substring(0,7)

Write-Verbose "Deploying template $SolutionTemplateFile"
$deployment = New-AzDeployment -Name $Version `
                -Location $Location `
                -TemplateFile $SolutionTemplateFile `
                -TemplateParameterFile $SolutionParametersFile `
                -SkipTemplateParameterPrompt -Verbose

if ($DeploymentOutputFile -and $Deployment.Outputs) {
    Write-Verbose "Saving outputs to $DeploymentOutputFile..."
    $clustersOutput = @{}
    foreach ($output in $Deployment.Outputs.GetEnumerator()) {
        $clustersOutput.Add($output.Key, $output.Value.Value)
    }
    $clustersOutput | ConvertTo-Json | Set-Content -Path $DeploymentOutputFile
}
