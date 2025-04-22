Using module ./Common.psm1
function ImportTemplateRepoToDomainRepo {
    param (
        [Parameter(Mandatory)] [hashtable] $RepoConfiguration,
        [Parameter(Mandatory)] [string] $Directory
    )
    [Argument]::AssertIsNotNull("RepoConfiguration", $RepoConfiguration)

    Write-Host "Importing Template..." -ForegroundColor Green

    Set-Location $Directory

    git remote add template $RepoConfiguration.TemplateGitUrl
    git fetch template
    git merge remotes/template/main
    git branch -M $RepoConfiguration.DefaultBranchName
    git push -u origin $RepoConfiguration.DefaultBranchName

    Set-Location -
}

function UpdateDomainSourceCode {
    param(
        [Parameter(Mandatory)] [hashtable] $DomainConfiguration,
        [Parameter(Mandatory)] [string] $Directory
    )
    [Argument]::AssertIsNotNull("DomainConfiguration", $DomainConfiguration)

    Write-Host "Updating Source Code" -ForegroundColor Green

    Set-Location $Directory

    foreach ($item in $DomainConfiguration.TemplateReplacements) {
        $content = Get-Content -Path $item.FileName

        foreach ($replacement in $item.Replacements) {
            $content = $content.Replace($replacement.From, $replacement.To)
        }
        Set-Content -Path $item.FileName -Value $content
    }

    git checkout -b $DomainConfiguration.RepoConfiguration.ReplacementBranchName
    git add .
    git commit -m "refactor: replacing template for domain $($DomainConfiguration.Domain.Name)"
    git push --set-upstream origin $DomainConfiguration.RepoConfiguration.ReplacementBranchName --force

    Set-Location -
}