# Read the JSON file into a PowerShell object
$jsonContent = Get-Content -Path "installedPackages.json" | ConvertFrom-Json

# Extract PackageIdentifiers
$packageIdentifiers = $jsonContent.Sources.Packages.PackageIdentifier

# Loop through each PackageIdentifier and run the winget install command
foreach ($packageId in $packageIdentifiers) {
    # Execute the winget install command for each package
    Write-Host "Installing: $packageId"
    winget install --id "$packageId" -i
}
