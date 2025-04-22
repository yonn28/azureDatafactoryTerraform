Using module ./Common.psm1

$AZURE_DEVOPS_RESOURCE_ID = "499b84ac-1321-427f-aa17-267ca6975798"

function SetupAzureDevOps {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory)] [string] $AzureDevOpsPAT,
        [Parameter(Mandatory)] [uri] $AzureDevOpsOrganizationURI,
        [Parameter(Mandatory)] [string] $AzureDevOpsProject
    )
    [Argument]::AssertIsNotNullOrEmpty("AzureDevOpsPAT", $AzureDevOpsPAT)
    [Argument]::AssertIsNotNullOrEmpty("AzureDevOpsProject", $AzureDevOpsProject)

    $env:AZURE_DEVOPS_EXT_PAT = $AzureDevOpsPAT

    Write-Verbose "Set default project"
    az devops configure --defaults organization=$AzureDevOpsOrganizationURI project="$AzureDevOpsProject"
}

function GetAzureDevOpsVariableGroup {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [string] $VariableGroupName
    )
    [Argument]::AssertIsNotNullOrEmpty("VariableGroupName", $VariableGroupName)

    Write-Verbose "Getting variables from Variable Group $VariableGroupName..."

    $GroupId = $(az pipelines variable-group list --query "[?name=='$VariableGroupName'].id" -o tsv)
    $json = $(az pipelines variable-group variable list --group-id $GroupId)
    $variables = $json | ConvertFrom-Json -AsHashtable

    return  $variables
}

function CreateAzureDevOpsVariableGroup {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [string] $VariableGroupName
    )
    [Argument]::AssertIsNotNullOrEmpty("VariableGroupName", $VariableGroupName)

    $GroupId = $(az pipelines variable-group list --query "[?name=='$VariableGroupName'].id" -o tsv)

    if (! $GroupId) {
        Write-Verbose "Creating variable group $VariableGroupName ..."
        $GroupId = $(az pipelines variable-group create --name $VariableGroupName --authorize --variable createdAt="$(Get-Date)" --query "id" -o tsv)

        if (! $GroupId) {
            Write-Error "The build agent does not have permissions to create variable groups"
            exit 1
        }
    }
    return $GroupId
}


function CreateAzureDevopsVGVariablesFromDeployment {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [string] $VariableGroupId,
        [Parameter(Mandatory)] [string] $DeploymentOutputFile
    )

    if (-NOT (Test-Path $DeploymentOutputFile)) {
        throw "Deployment output file '$DeploymentOutputFile' does not exists"
    }

    [Argument]::AssertIsNotNullOrEmpty("VariableGroupName", $VariableGroupId)
    [Argument]::AssertIsNotNull("DeploymentOutputFile", $DeploymentOutputFile)

    Write-Verbose "Getting variables from $DeploymentOutputFile file..."
    $DeploymentOutput = Get-Content -Path $DeploymentOutputFile | ConvertFrom-Json -AsHashtable

    Write-Verbose "Setting Variable Group variables from ARM outputs..."
    foreach ($output in $DeploymentOutput.GetEnumerator()) {
        $name = $output.Key
        $value = $output.Value

        Write-Verbose "Trying to update variable $key..."
        if (! (az pipelines variable-group variable update --group-id $VariableGroupId --name $name --value $value)) {
            Write-Verbose "Creating variable $key..."
            az pipelines variable-group variable create --group-id $VariableGroupId --name $name --value $value
        }
    }
}

function CreateAzureDevopsVGVariablesFromVariables {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [string] $VariableGroupId,
        [Parameter(Mandatory)] [string[]] $Variables
    )

    [Argument]::AssertIsNotNullOrEmpty("VariableGroupId", $VariableGroupId)
    [Argument]::AssertIsNotNull("Variables", $Variables)


    Write-Verbose "Setting Variable Group variables from ARM outputs..."
    foreach ($variable in $Variables) {
        $name = $variable
        $value = (Get-Item "env:$variable").Value

        Write-Verbose "Trying to update variable $key..."
        if (! (az pipelines variable-group variable update --group-id $VariableGroupId --name $name --value $value)) {
            Write-Verbose "Creating variable $key..."
            az pipelines variable-group variable create --group-id $VariableGroupId --name $name --value $value
        }
    }
}

function CreateAzureDevOpsAttachment {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [string] $AttachmentName,
        [Parameter(Mandatory)] [string] $AttachmentFile
    )

    if (-NOT (Test-Path $AttachmentFile)) {
        Write-Error "AttachmentFile file '$AttachmentFile' does not exists"
        return
    }

    Write-Host "##vso[task.addattachment type=Distributedtask.Core.Summary;name=$AttachmentName;]$AttachmentFile"
}

function GetAzureDevopsPAT {
    $token = az account get-access-token --resource $AZURE_DEVOPS_RESOURCE_ID | ConvertFrom-Json
    if (!$token) {
        throw "Failed in getting the access token"
    }
    return $token.accessToken
}

function CreateAzureDevopsRepository {
    param (
        [Parameter(Mandatory)] [hashtable] $RepoConfiguration
    )
    [Argument]::AssertIsNotNull("RepoConfiguration", $RepoConfiguration)

    $repo = az repos show -r $RepoConfiguration.RepoName --org $RepoConfiguration.AzureDevOpsOrganizationURI --project $RepoConfiguration.AzureDevOpsProject
    if (! $?) {
        $reply = Read-Host -Prompt "The script is about to create a Repo called '$($RepoConfiguration.RepoName)' on the '$($RepoConfiguration.AzureDevOpsOrganizationURI)' organization. Would you like to continue? (y/n)"
        if ( $reply -match "[yY]" ) {
            Write-Host "Creating repository..." -ForegroundColor Green
            $repo = az repos create --name $RepoConfiguration.RepoName --org $RepoConfiguration.AzureDevOpsOrganizationURI --project $RepoConfiguration.AzureDevOpsProject
        }else{
            Write-Host "Canceling script execution..." -ForegroundColor Yellow
            exit -1
        }
    }
    else {
        Write-Host "Repository $($RepoConfiguration.RepoName) already exists." -ForegroundColor Blue
    }

    return $repo | ConvertFrom-Json -AsHashtable
}

function CloneRepo {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [hashtable] $RepoInfo,
        [Parameter(Mandatory)] [boolean] $UseSSH
    )

    if (! $IsWindows) {
        $env:Temp = "/tmp";
    }
    $directory = Join-Path $env:Temp $(New-Guid)
    New-Item -Type Directory -Path $directory

    if ($UseSSH) {
        $domainGitUrl = $repoInfo.sshUrl
    } else {
        $domainGitUrl = $repoInfo.remoteUrl
    }

    git clone $domainGitUrl $directory

    return $directory[1]
}

function CreateAzDevOpsRepoApprovalPolicy {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory)] [hashtable] $RepoInfo,
        [Parameter(Mandatory)] [hashtable] $RepoConfiguration
    )
    [Argument]::AssertIsNotNull("RepoInfo", $RepoInfo)
    [Argument]::AssertIsNotNull("RepoConfiguration", $RepoConfiguration)

    Write-Host "Creating policy for approver count on branch $($RepoConfiguration.DefaultBranchName)" -ForegroundColor Green

    $result = az repos policy approver-count create --blocking true --branch $RepoConfiguration.DefaultBranchName --creator-vote-counts false --enabled true --minimum-approver-count $RepoConfiguration.MinimumApprovers --reset-on-source-push false --allow-downvotes false --repository-id $RepoInfo.id --org $RepoConfiguration.AzureDevOpsOrganizationURI --project $RepoConfiguration.AzureDevOpsProject

    $result | Write-Verbose
}

function CreateAzDevOpsRepoCommentPolicy {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory)] [hashtable] $RepoInfo,
        [Parameter(Mandatory)] [hashtable] $RepoConfiguration
    )
    [Argument]::AssertIsNotNull("RepoInfo", $RepoInfo)
    [Argument]::AssertIsNotNull("RepoConfiguration", $RepoConfiguration)

    Write-Host "Creating policy for comment resolution on branch $($RepoConfiguration.DefaultBranchName)" -ForegroundColor Green

    $result = az repos policy comment-required create --blocking true --branch $RepoConfiguration.DefaultBranchName --enabled true --repository-id $RepoInfo.id --org $RepoConfiguration.AzureDevOpsOrganizationURI --project $RepoConfiguration.AzureDevOpsProject

    $result | Write-Verbose
}

function CreateAzDevOpsRepoWorkItemPolicy {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory)] [hashtable] $RepoInfo,
        [Parameter(Mandatory)] [hashtable] $RepoConfiguration
    )
    [Argument]::AssertIsNotNull("RepoInfo", $RepoInfo)
    [Argument]::AssertIsNotNull("RepoConfiguration", $RepoConfiguration)

    Write-Host "Creating policy for linked workitem on branch $($RepoConfiguration.DefaultBranchName)" -ForegroundColor Green

    $result = az repos policy work-item-linking create --blocking true --branch $RepoConfiguration.DefaultBranchName --enabled true --repository-id $RepoInfo.id --org $RepoConfiguration.AzureDevOpsOrganizationURI --project $RepoConfiguration.AzureDevOpsProject

    $result | Write-Verbose
}

function CreateAzDevOpsYamlPipelines {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [hashtable] $RepoConfiguration
    )
    [Argument]::AssertIsNotNull("RepoConfiguration", $RepoConfiguration)

    foreach ($pipeline in $RepoConfiguration.Pipelines) {
        Write-Host "Creating AzDevOps Pipeline $($pipeline.Name)..." -ForegroundColor Green

        $result = az pipelines show --name "$($pipeline.Name)" --org $RepoConfiguration.AzureDevOpsOrganizationURI --project $RepoConfiguration.AzureDevOpsProject
        if (! $?){
            $result = az pipelines create --skip-first-run --branch $RepoConfiguration.DefaultBranchName --name "$($pipeline.Name)" --folder-path $RepoConfiguration.RepoName `
                                          --repository-type tfsgit --repository $RepoConfiguration.RepoName --yml-path $pipeline.SourceYamlPath `
                                          --org $RepoConfiguration.AzureDevOpsOrganizationURI --project $RepoConfiguration.AzureDevOpsProject
        }else{
            Write-Host "Pipeline '$($pipeline.Name)' already exists" -ForegroundColor Blue
        }

        $result | Write-Verbose
    }

}

function CreateAzDevOpsRepoBuildPolicy {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [hashtable] $RepoInfo,
        [Parameter(Mandatory)] [hashtable] $RepoConfiguration
    )

    [Argument]::AssertIsNotNull("RepoInfo", $RepoInfo)
    [Argument]::AssertIsNotNull("RepoConfiguration", $RepoConfiguration)

    foreach ($pipeline in $RepoConfiguration.Pipelines) {
        if ($pipeline.BuildPolicy){
            Write-Host "Creating AzDevOps Build Policy for $($pipeline.Name)..." -ForegroundColor Green

            $pipelineId = az pipelines show --name "$($pipeline.Name)" --org $RepoConfiguration.AzureDevOpsOrganizationURI --project $RepoConfiguration.AzureDevOpsProject --query "id" -o tsv

            $displayName = "$($pipeline.BuildPolicy.Name)"

            $policyId = az repos policy list --repository-id $RepoInfo.id --branch $RepoConfiguration.DefaultBranchName `
                            --org $RepoConfiguration.AzureDevOpsOrganizationURI --project $RepoConfiguration.AzureDevOpsProject `
                            --query "[?settings.displayName=='$displayName'].id" -o tsv

            if (! $policyId) {
                $result = az repos policy build create --repository-id $RepoInfo.id --build-definition-id $pipelineId --display-name $displayName `
                                                    --branch $RepoConfiguration.DefaultBranchName --path-filter $pipeline.BuildPolicy.PathFilter `
                                                    --blocking true --enabled true  --queue-on-source-update-only true `
                                                    --manual-queue-only false --valid-duration 0 `
                                                    --org $RepoConfiguration.AzureDevOpsOrganizationURI --project $RepoConfiguration.AzureDevOpsProject
                $result | Write-Verbose
            }else{
                Write-Host "Build Policy '$displayName' already exists" -ForegroundColor Blue
            }
        }
    }
}

function OpenPullRequest {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory)] [hashtable] $RepoInfo,
        [Parameter(Mandatory)] [hashtable] $RepoConfiguration,
        [string] $WorkItemId
    )
    [Argument]::AssertIsNotNull("RepoInfo", $RepoInfo)
    [Argument]::AssertIsNotNull("RepoConfiguration", $RepoConfiguration)

    Write-Host "Opening PR from $($RepoConfiguration.ReplacementBranchName) to $($RepoConfiguration.DefaultBranchName)..." -ForegroundColor Green

    $title = "Replacing changes for project"
    $description = "Fork created using Add-Domain.ps1 script"

    $result = az repos pr create --repository $RepoInfo.id --source-branch $RepoConfiguration.ReplacementBranchName --target-branch $RepoConfiguration.DefaultBranchName `
                                 --description $description --title $title --work-items $WorkItemId --open `
                                 --org $RepoConfiguration.AzureDevOpsOrganizationURI --project $RepoConfiguration.AzureDevOpsProject

    $result | Write-Verbose
}
