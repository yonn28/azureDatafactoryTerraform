param
(
    [Parameter(Mandatory)]
    [ValidateSet("dev", "qas", "prd", "sandbox", "drp")]
    [String]$Environment,
    [Parameter(Mandatory)]
    [String]$ProfilesDirectory
)

$testingPath = "$ProfilesDirectory\$Environment.publish.xml"
$fileExists = Test-Path -Path $testingPath
if ($fileExists -eq $false)
{
    Write-Output "##vso[task.logissue type=error]Profile $testingPath has not been found"
    Write-Host "Profile in $ProfilesDirectory are:`n" (Get-ChildItem $ProfilesDirectory)
    Write-Host "##vso[task.complete result=Failed;]Profile $testingPath not found"
}
else {
    Write-Output ("Profile {0} adquired" -f $testingPath)
}