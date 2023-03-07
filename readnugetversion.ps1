

# Define variables
$packageName = "autoMapper"
$packageVersion = "12.0.1"
$updatedPackageVersion = "14.1.3"
$nugetUrl = "https://www.nuget.org/api/v2/"
$azureArtifactFeed = "DemoFeed"
$nuspecFileName = "$packageName.$packageVersion.nuspec"
$nugetAPIName = "DemoToken"
$nugetAPIKey = "6vpz5tlz6rv33qetuwpmrpdw5w5t54dpj5lg37s7d26gtpl7lqsq"

#-------------------------------------------------------------------------

# f. function to prepend timestamp to output
function Write-TimestampedOutput($message) {
    Write-Host ("[{0}] {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $message)
}

#-------------------------------------------------------------------------

# a. Restore a NuGet package AutoMapper version 12.0.1 from public repository

# Install the NuGet provider for PackageManagement
Install-PackageProvider -Name NuGet

# install the package
nuget.exe install AutoMapper -Version 12.0.1 -Source https://api.nuget.org/v3/index.json
Write-TimestampedOutput "Installed package $packageName version $packageVersion."

#-------------------------------------------------------------------------

# b. Read the version of the nuspec file of the NuGet package AutoMapper and write it to console.

# first, Install the NuGet.CommandLine package
Install-Package NuGet.CommandLine

# find the path to the nuspec file of the package
$nuspecPath = (Get-ChildItem -Path "C:\Users\eyada\.nuget\packages\$packageName\$packageVersion" -Filter *.nuspec).FullName

# Open the nuspec file in a text editor
#notepad $nuspecPath

# read the version information from the nuspec file
[xml]$nuspec = Get-Content "C:\Users\eyada\.nuget\packages\automapper\12.0.1\automapper.nuspec"
$version = $nuspec.package.metadata.version
Write-TimestampedOutput "The version of the NuGet package is $version"

#-------------------------------------------------------------------------

# c. Push the NuGet package into the DemoFeed in Azure Artifacts

# if we want to remove azureArtifactFeed
#nuget.exe sources remove -Name $azureArtifactFeed

# Authenticate to your Azure DevOps organization
nuget.exe sources Add -Name $azureArtifactFeed -Source "https://pkgs.dev.azure.com/Landa-ExerciseOrg/ExerciseProject/_packaging/DemoFeed/nuget/v3/index.json" -UserName $nugetAPIName -Password $nugetAPIKey

# List all packages in the "DemoFeed" NuGet source
$packages = nuget.exe list -Source "DemoFeed"

# Search for the package and check its version number
$package = $packages | where { $_ -like "$packageName $packageVersion*" }
if ($package) {
    # The package is already in the NuGet source
    Write-TimestampedOutput "The package '$packageName $packageVersion' is already in the 'DemoFeed' NuGet source."
    Write-TimestampedOutput "Please remove it before attempting to push it again."
} else {
    # The package is not in the NuGet source
    Write-TimestampedOutput "The package '$packageName $packageVersion' is not in the 'DemoFeed' NuGet source, we will push it"
    # Push the NuGet package to the feed
    nuget.exe push -Source $azureArtifactFeed -ApiKey az automapper.12.0.1.nupkg
}

#-------------------------------------------------------------------------

# d. to Change the version of the nuspec file of the NuGet package AutoMapper from 12.0.1 to 14.1.3

# Change the version number in the nuspec file
(Get-Content $nuspecPath) | ForEach-Object { $_ -replace '12.0.1', '14.1.3' } | Set-Content $nuspecPath

#-------------------------------------------------------------------------

# e. Read the nuspec file again and write to console the (new) version from the file.

[xml]$nuspec = Get-Content "C:\Users\eyada\.nuget\packages\automapper\12.0.1\automapper.nuspec"
$version = $nuspec.package.metadata.version
Write-TimestampedOutput "The version of the NuGet package is $version"

#-------------------------------------------------------------------------
