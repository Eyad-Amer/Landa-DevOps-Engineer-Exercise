# install the NuGet package provider
Install-PackageProvider -Name NuGet -Force

# function to prepend timestamp to output
function Write-TimestampedOutput($message) {
    Write-Host ("[{0}] {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $message)
}

# Change the working directory to the directory containing the script
Set-Location $PSScriptRoot

# Define variables
$packageName = "autoMapper"
$packageVersion = "12.0.1"
$updatedPackageVersion = "14.1.3"
$nugetUrl = "https://www.nuget.org/api/v2/"
$azureArtifactFeed = "DemoFeed"
$nuspecFileName = "$packageName.$packageVersion.nuspec"
$nugetAPIName = "DemoToken"
$nugetAPIKey = "6vpz5tlz6rv33qetuwpmrpdw5w5t54dpj5lg37s7d26gtpl7lqsq"

# a. Restore the AutoMapper package

# Check if the package is already installed
if (Get-Package $packageName -ErrorAction SilentlyContinue) {
    Write-TimestampedOutput "Package $packageName is already installed."
    $installedVersion = (Get-Package $packageName).Version
    Write-TimestampedOutput "Installed version: $installedVersion"
    # If the installed version is not the required version, uninstall it
    if ($installedVersion -ne $packageVersion) {
        Uninstall-Package $packageName -Force
        Write-TimestampedOutput "Uninstalled package $packageName version $installedVersion."
    }
}
# Install the package if it's not already installed
else {
    Install-Package $packageName -RequiredVersion $packageVersion -Source $nugetUrl
    Write-TimestampedOutput "Installed package $packageName version $packageVersion."
}

# find the path to the nuspec file of the package
$nuspecPath = (Get-ChildItem -Path "C:\Users\eyada\.nuget\packages\$packageName\$packageVersion" -Filter *.nuspec).FullName

# Open the nuspec file in a text editor
#notepad $nuspecPath

# b. read the version information from the nuspec file
[xml]$nuspec = Get-Content "C:\Users\eyada\.nuget\packages\automapper\12.0.1\automapper.nuspec"
$version = $nuspec.package.metadata.version
Write-TimestampedOutput "The version of the NuGet package is $version"

# c. Install the NuGet.CommandLine package if it is not already installed
Install-Package NuGet.CommandLine

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

# nuget.exe delete AutoMapper 12.0.1 -Source DemoFeed -ApiKey $nugetAPIKey

# d. to Change the version of the nuspec file of the NuGet package AutoMapper from 12.0.1 to 14.1.3
# Change the version number in the nuspec file
(Get-Content $nuspecPath) | ForEach-Object { $_ -replace '12.0.1', '14.1.3' } | Set-Content $nuspecPath

# e. Read the nuspec file again and write to console the (new) version from the file.
[xml]$nuspec = Get-Content "C:\Users\eyada\.nuget\packages\automapper\12.0.1\automapper.nuspec"
$version = $nuspec.package.metadata.version
Write-TimestampedOutput "The version of the NuGet package is $version"
