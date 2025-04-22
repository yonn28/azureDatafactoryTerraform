function CheckKeyVaultAccessPolicy {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)] [PSCustomObject] $KeyVault,
        [Parameter(Mandatory)] [string] $ObjectID,
        [Parameter(Mandatory)] [string[]] $SecretAccessList
    )

    foreach ($item in $KeyVault.AccessPolicies) {
        Write-Verbose "$($item.ObjectID) - $ObjectID"
        if ($item.ObjectID -eq $ObjectID) {
            Write-Verbose "Found $ObjectID access policy"
            for ($i = 0; $i -lt $SecretAccessList.Count; $i++) {
                if (-NOT ( $item.PermissionsToSecrets -contains $SecretAccessList[$i])) {
                    Write-Verbose "NOT Found secret permission $($SecretAccessList[$i]) for $ObjectID access policy"
                    return $false
                }
            }
            Write-Verbose "Found $ObjectID access policy"
            return $true
        }
    }
    return $false
}