param
(
    [Parameter(Mandatory)] [String] $PublishProfileFile
)

if ((Test-Path $PublishProfileFile) -eq $false) {
    Write-Error "Publishing profile $PublishProfileFile does not exists."
    exit -1
}

[xml] $profile = Get-Content $PublishProfileFile
$connectionString = $profile.Project.PropertyGroup.TargetConnectionString
$database = $profile.Project.PropertyGroup.TargetDatabaseName

if (-not ($connectionString -or $database)) {
    Write-Error "Publishing profile $PublishProfileFile does not contains expected properties 'TargetConnectionString' or 'TargetDatabaseName'."
    exit -1
}

$source = [regex]::Match($connectionString, 'Data Source=([^;]+)').Groups[1].Value
$server = $source.Split(".")[0] + ".database.windows.net"

Write-Host ("##vso[task.setvariable variable=sharedSynapseDatabase;]$database")
Write-Host ("##vso[task.setvariable variable=sharedSynapseServer;]$server")
