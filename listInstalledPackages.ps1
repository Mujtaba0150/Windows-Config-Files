winget list | ForEach-Object {
    if ($_ -match '^(?<Name>.+?)\s{2,}(?<Id>[^\s]+)\s{2,}') {
        [PSCustomObject]@{
            Name = $Matches['Name'].Trim()
            Id   = $Matches['Id'].Trim()
        }
    }
} | ConvertTo-Json -Depth 2 | Out-File -FilePath "installedPackages.json" -Encoding utf8