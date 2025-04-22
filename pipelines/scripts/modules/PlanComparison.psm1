Using module ./Common.psm1

function FormatCompareObjectResult {
    param (
        [Parameter(Mandatory)] [System.Object[]] $Differences
    )
    $tableResult = @()
    $lineNumber = 0
    foreach ($item in $Differences.GetEnumerator()) {
        if ($item.SideIndicator -eq "==" -or $item.SideIndicator -eq "=>") {
            $lineNumber = $item.InputObject.ReadCount
        }

        if ( $item.SideIndicator -ne "==") {
            if ($item.SideIndicator -eq "=>") {
                $lineOperation = "+"
            }
            elseif ($item.SideIndicator -eq "<=") {
                $lineOperation = "-"
            }

            $tableResult += [PSCustomObject] @{
                Line      = $lineNumber
                Operation = $lineOperation
                Text      = $item.InputObject
            }
        }
    }
    $tableResult | Format-Table -AutoSize
}

function CreateCompareMarkdownFile {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [psobject[]] $Content1,
        [Parameter(Mandatory)] [psobject[]] $Content2,
        [Parameter(Mandatory)] [string] $OutputFileName,
        [bool] $OverWrite = $true
    )

    [Argument]::AssertIsNotNullOrEmpty("Content1", $Content1)
    [Argument]::AssertIsNotNullOrEmpty("Content2", $Content2)

    if ((Test-Path $OutputFileName) -And -Not $OverWrite) {
        throw "$OutputFileName already exists and overwrite is set to false"
    }

    $differences = Compare-Object $Content1 $Content2 -IncludeEqual
    Write-Verbose "Differences:"
    Write-Verbose "$differences"

    $formatedDifferences = FormatCompareObjectResult -Differences $differences
    Write-Verbose "Formated Differences:"
    Write-Verbose "$formatedDifferences"

    CreateMarkdownFromObject -Object $formatedDifferences -OutputFileName $OutputFileName
}

function GetPlanContent {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [string] $PlanFile
    )

    if (-Not( Test-Path $PlanFile)) {
        throw "PlanFile: $PlanFile not found"
    }

    $content = Get-Content -Path $PlanFile
    $content = $content -replace '(\s*)\*\s(.*)',''
    $content = $content -replace '(.*)(,\s[0-9]* to ignore.)','$1'
    $content = $content | Where-Object {$_.trim() -ne "" }

    return $content
}