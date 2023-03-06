# Landa-DevOps-Engineer-Exercise
![landa-logo](https://user-images.githubusercontent.com/40535130/222986173-af4db030-892e-4051-8d7d-00fbc8a346d2.jpg)


#### - The objective of the task is to utilize Azure DevOps, PowerShell, and NuGet package management in conjunction.
### Installation
------------
Please ensure that the necessary prerequisites are installed on your computer.
- PowerShell (based on windows 10 or above)
- Git 2.38 or above
- NuGet.exe version 6.2.2.1

### 1. Create your own free account in Azure DevOps
------------
`<Azure DevOps>` : [http://dev.azure.com/](http://dev.azure.com/)
<img width="801" alt="Create account in Azure DevOps" src="https://user-images.githubusercontent.com/40535130/222896757-c4152a47-3361-439c-834f-aef2d6e90f92.png">

### 2. Create a new organization
------------
- Generate a new Azure DevOps organization with the name "Landa-ExerciseOrg".
<img width="330" alt="Create organization" src="https://user-images.githubusercontent.com/40535130/222986831-4bbdc23d-edb5-47a0-b281-fd823b8d009b.png">

### 3. Create a new project
------------
- Generate a new Azure DevOps project, named: "ExerciseProject".
<img width="427" alt="Create project" src="https://user-images.githubusercontent.com/40535130/222986914-3bd9e772-0e19-4b79-a1ea-e848380585ee.png">

### 4. Initialize a new Git repo
------------
- Generate a new repository in the project.
<img width="857" alt="Initialize git repo" src="https://user-images.githubusercontent.com/40535130/222986988-f4de1fb5-2d8e-456d-9f8a-7af73cc2be58.png">

### 5. Create a feed in Azure Artifacts
------------
- Generate a new feed in Azure Artifacts with the name "DemoFeed".
<img width="858" alt="create feed" src="https://user-images.githubusercontent.com/40535130/222987206-5a359135-475d-48d6-be63-1334fbbcfafc.png">

### 6. Create a new PowerShell file in the Git repo
------------
- Create a new PowerShell file in the Git repository and name it "readnugetversion.ps1".
![create powershell file](https://user-images.githubusercontent.com/40535130/222987504-787ededd-3449-4b66-bc46-5e6d84f398ae.png)

### 7. Refer to the appropriate documentation and set up the necessary credentials in Azure DevOps.
------------
- To clone, pull, and push to a Git repository in Azure DevOps from your local drive, you will need to perform the following steps:
- Create a Personal Access Token (PAT) in Azure DevOps:
a. Login to your Azure DevOps account and navigate to your profile settings.
b. Click on the "Personal access tokens" option from the left-hand menu.
c. Click on the "New Token" button to create a new PAT.
d. Give your token a name and select the appropriate scopes for your needs.
e. Click on the "Create" button to generate the token.
f. Copy the generated token as it will not be displayed again.
![token](https://user-images.githubusercontent.com/40535130/222990466-677ec7c5-703d-4b5e-b8ec-edf095dc6ed6.png)
- When you're done, copy the token and store it in a secure location. For your security, it won't be shown again.

- Open the command line on your computer and navigate to the folder where you want to clone the repository.

- Clone the repository by running the following command:
`git clone https://Landa-ExerciseOrg@dev.azure.com/Landa-ExerciseOrg/ExerciseProject/_git/ExerciseProject`

<img width="863" alt="clone" src="https://user-images.githubusercontent.com/40535130/222990907-af368d7b-938d-4940-aa0b-cf4f32d6170b.png">

- When prompted for credentials, enter your Azure DevOps useremail, username and PAT as the password.
- Run the command: `<git config --global user.email "your email address">`
- Run the command: `<git config --global user.name "your name">`
- Run the command: `<git config --global user.password "your PAT">`
<img width="1098" alt="config" src="https://user-images.githubusercontent.com/40535130/222991562-b99888b2-cf5f-4c39-8fc3-834113772c24.png">

### 8. Edit the PowerShell script file in a PowerShell editor
------------
- Open your preferred PowerShell editor
- edit the PowerShell script file readnugetversion.ps1 in a PowerShell editor
<img width="853" alt="powershell editor" src="https://user-images.githubusercontent.com/40535130/222991828-350c14c2-4292-49c9-a3d5-b39f1e4fa3d0.png">

### 9. Write a PowerShell function so each output line in the console will have a timestamp prefix
------------
- The function prepend timestamp to output

		function Write-TimestampedOutput($message) {
    		Write-Host ("[{0}] {1}" -f (Get-Date -Format "yyyy-MM-dd  HH:mm:ss"), $message)
		}

### 10. Restore a NuGet package AutoMapper version 12.0.1 from public repository `https://www.nuget.org/`
------------
- Before proceeding, it is important to verify that the NuGet package manager is installed in your PowerShell environment. In case it is not installed, you can use the following command to install it:

		Install-PackageProvider -Name NuGet -Force

- Restore a NuGet package AutoMapper version 12.0.1 from public repository, you can use the following command to install it:

		# first, check if the package is already installed
		if (Get-Package "autoMapper" -ErrorAction SilentlyContinue) {
    	Write-TimestampedOutput "Package "autoMapper" is already installed."
    	$installedVersion = (Get-Package $packageName).Version
    	Write-TimestampedOutput "Installed version: $installedVersion"
    	# If the installed version is not the required version, uninstall it
    	if ($installedVersion -ne "12.0.1") {
        	Uninstall-Package "autoMapper" -Force
        	Write-TimestampedOutput "Uninstalled package "autoMapper" version $installedVersion."
   		 }
		}
		# Install the package if it's not already installed
		else {
    		Install-Package "autoMapper" -RequiredVersion "12.0.1" -Source "https://www.nuget.org/api/v2/"
    		Write-TimestampedOutput "Installed package "autoMapper" version "12.0.1""
		}

### 11. Read the version of the nuspec file of the NuGet package AutoMapper and write it to console
------------
-  Read the version information from the nuspec file

		[xml]$nuspec = Get-Content "C:\Users\eyada\.nuget\packages\automapper\12.0.1\automapper.nuspec"
		$version = $nuspec.package.metadata.version
		Write-TimestampedOutput "The version of the NuGet package is $version"

### 12. Push the NuGet package into the DemoFeed in Azure Artifacts
------------
- Ensure you have installed the latest version of the Azure Artifacts credential provider from the "Get the tools" menu.
- Add a nuget.config file to your project:

		<?xml version="1.0" encoding="utf-8"?>
		<configuration>
  		<packageSources>
    		<clear />
    		<add key="DemoFeed" value="https://pkgs.dev.azure.com/Landa-ExerciseOrg/ExerciseProject/_packaging/DemoFeed/nuget/v3/index.json" />
  		</packageSources>
		</configuration>

- Install the NuGet.CommandLine package if it is not already installed
		Install-Package NuGet.CommandLine

- Authenticate to your Azure DevOps organization
		nuget.exe sources Add -Name "DemoFeed" -Source "https://pkgs.dev.azure.com/Landa-ExerciseOrg/ExerciseProject/_packaging/DemoFeed/nuget/v3/index.json" -UserName <nugetAPIName> -Password <nugetAPIKey>

- push NuGet package into DemoFeed in Azure Artifacts

		# List all packages in the "DemoFeed" NuGet source
		$packages = nuget.exe list -Source "DemoFeed"

		# Search for the package and check its version number
		$package = $packages | where { $_ -like ""autoMapper" "12.0.1"*" }
		if ($package) {
    		# The package is already in the NuGet source
    		Write-TimestampedOutput "The package '"autoMapper" "12.0.1"' is already in the 'DemoFeed' NuGet source."
    		Write-TimestampedOutput "Please remove it before attempting to push it again."
		} else {
    		# The package is not in the NuGet source
    		Write-TimestampedOutput "The package '"autoMapper" "12.0.1"' is not in the 'DemoFeed' NuGet source, we will push it"
    		# Push the NuGet package to the feed
    		nuget.exe push -Source "DemoFeed" -ApiKey az automapper.12.0.1.nupkg

### 13. Change the version of the nuspec file of the NuGet package AutoMapper from 12.0.1 to 14.1.3
------------
- find the path to the nuspec file of the package
		$nuspecPath = (Get-ChildItem -Path "C:\Users\eyada\.nuget\packages\autoMapper\12.0.1" -Filter *.nuspec).FullName

- Change the version number in the nuspec file
		(Get-Content $nuspecPath) | ForEach-Object { $_ -replace '12.0.1', '14.1.3' } | Set-Content $nuspecPath

### 14. Read the nuspec file again and write to console the (new) version from the file
------------
		[xml]$nuspec = Get-Content "C:\Users\eyada\.nuget\packages\automapper\12.0.1\automapper.nuspec"
		$version = $nuspec.package.metadata.version
		Write-TimestampedOutput "The version of the NuGet package is $version"

### 15. finally, Run the PowerShell script and saved it in the Git repo

- screenshot of the execution of the script:
<img width="802" alt="done" src="https://user-images.githubusercontent.com/40535130/223075775-aec069ae-51a7-444f-bd56-8f1291a8d0a9.png">

- screenshot of the files list in Git repo:
<img width="859" alt="repo" src="https://user-images.githubusercontent.com/40535130/223076166-63b86c9c-3a58-4e2c-9dad-fb1c9ec7c38c.png">

- screenshot of the Azure Artifacts feed:
<img width="859" alt="push feed to artifact" src="https://user-images.githubusercontent.com/40535130/223076443-f2d85440-bb09-45c8-b461-4e1b2f8b4652.png">
















