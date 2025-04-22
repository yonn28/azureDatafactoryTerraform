param
(
    [Parameter(Mandatory)] [String] $PublishProfilePath,
    [Parameter(Mandatory)] [String] $HaltOnConnectivityIssues
)

$context = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile.DefaultContext
$sqlToken = [Microsoft.Azure.Commands.Common.Authentication.AzureSession]::Instance.AuthenticationFactory.Authenticate($context.Account, $context.Environment, $context.Tenant.Id.ToString(), $null, [Microsoft.Azure.Commands.Common.Authentication.ShowDialog]::Never, $null, "https://database.windows.net").AccessToken
Write-Host ("##vso[task.setvariable variable=sqlToken;]$sqlToken")

$throwError= [System.Convert]::ToBoolean($HaltOnConnectivityIssues)
[xml] $profile = Get-Content $PublishProfilePath
$connectionString = $profile.Project.PropertyGroup.TargetConnectionString
$source = [regex]::Match($connectionString, 'Data Source=([^;]+)').Groups[1].Value
$database = $profile.Project.PropertyGroup.TargetDatabaseName

try {

    $conn = New-Object System.Data.SqlClient.SQLConnection
    $conn.ConnectionString = "Data Source=$source;Initial Catalog=$database;Connect Timeout=30"
    $conn.AccessToken = $sqlToken
    Write-Verbose "Connect to database"
    $conn.Open()

    Write-Host ("##vso[task.setvariable variable=foundConnectivityIssues;isOutput=true]$false")

} catch {
    Write-Host ("##vso[task.setvariable variable=foundConnectivityIssues;isOutput=true]$true")
    if($throwError)
    {
        Write-Host "##vso[task.complete result=Failed;]Fail to connect to databse $database on $source. Please check you have granted the service principal permissions into $database. Try executing Grant-Permissions-Synapse.CD"
    }else{
        Write-Host "##vso[task.logissue type=warning] Please remember to grant permissions to the service principal into $database. Try executing Grant-Permissions-Synapse.CD "
    }

} finally {
    $conn.Close()
}
