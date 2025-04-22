class Argument {

    static [void] AssertIsNotNullOrEmpty([string] $paramName, [string] $paramValue) {
        if ([string]::IsNullOrWhiteSpace($paramValue)) {
            throw "Parameter $paramName is mandatory!"
        }
    }

    static [void] AssertIsNotNull([string] $paramName, [string] $paramValue) {
        if (-Not $paramValue) {
            throw "Parameter $paramName is null!"
        }
    }

    static [void] AssertIsMatch([string] $paramName, [string] $paramValue, [string] $regexPattern) {
        if (-Not ($paramValue -match $regexPattern)) {
            throw "Parameter $paramName value '$paramValue' does not match $regexPattern"
        }
    }
}

function CreateEnvironmentVariablesFromHashTable {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [hashtable] $Variables,
        [Parameter(Mandatory)] [string] $VariablePrefix
    )

    [Argument]::AssertIsNotNullOrEmpty("VariablePrefix", $VariablePrefix)

    Write-Verbose "Creating environment variables using prefix $VariablePrefix"

    foreach ($variable in $Variables.GetEnumerator()) {
        Write-Verbose -Message "$($variable.Key) - $($variable.Value.value)"

        $key = [regex]::replace($variable.Key, '([A-Z])(.)', { "_" + $args[0] }).ToUpper() #camelCase to SNAKE_CASE
        Set-Item "env:$($VariablePrefix)$key" $($variable.Value.value)

        Write-Verbose -Message "Variable: $($VariablePrefix)$key -> $($variable.Value.value) created!"
    }
}

function CreateMarkdownFromObject {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [psobject] $Object,
        [Parameter(Mandatory)] [string] $OutputFileName,
        [bool] $OverWrite = $true
    )

    [Argument]::AssertIsNotNullOrEmpty("OutputFileName", $OutputFileName)
    [Argument]::AssertIsNotNull("Object", $Object)

    if ((Test-Path $OutputFileName) -And -Not $OverWrite) {
        throw "$OutputFileName already exists and overwrite is set to false"
    }

    # Strips ANSI color code and wraps output with ``` to preserve characters
    '```' + (($Object | Out-String) -replace '\x1b\[[0-9;]*m','') + '```' > $OutputFileName
}

function LoadConfigurationFile {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [string] $ConfigurationFile
    )
    [Argument]::AssertIsNotNullOrEmpty("ConfigurationFile", $ConfigurationFile)

    if (-Not (Test-Path $ConfigurationFile)) {
        throw "Configuration File: $ConfigurationFile does not exists!"
    }

    return (Get-Content -Path $ConfigurationFile | ConvertFrom-Json -AsHashtable)
}

function ValidateConfiguration {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [hashtable] $Configuration
    )

    [Argument]::AssertIsNotNull("ConfigurationFile", $Configuration)
    [Argument]::AssertIsMatch("ConfigurationFile.Domain.Name", $Configuration.Domain.Name, '^[\w-]+$')
    [Argument]::AssertIsMatch("ConfigurationFile.RepoConfiguration.RepoName", $Configuration.RepoConfiguration.RepoName, '^[\w-]+$')
}