## Landa-DevOps-Engineer-Exercise
- DevOps Engineer Exercise
- The exercise aims to work with Azure DevOps, PowerShell, and NuGet package management.

#### Installation
------------
please have prerequisites installed on your computer.
- PowerShell (based on windows 10 or above)
- Git 2.38 or above
- NuGet.exe version 6.2.2.1

#### 1. Create your own free account in Azure DevOps
------------
`<link>` : [http://dev.azure.com/](http://dev.azure.com/)
<img width="801" alt="Create account in Azure DevOps" src="https://user-images.githubusercontent.com/40535130/222896757-c4152a47-3361-439c-834f-aef2d6e90f92.png">

#### 2. Create a new organization
------------
- Create a new Azure DevOps organization, named: "LandaExerciseOrg"
<img width="859" alt="create new organization" src="https://user-images.githubusercontent.com/40535130/222896841-808b0f35-99d7-4dcf-8d1e-12fc9b0f9012.png">

#### 3. Create a new project
------------
- Create a new Azure DevOps project, named: "ExerciseProject".
<img width="858" alt="create new projects" src="https://user-images.githubusercontent.com/40535130/222897149-73644be7-110e-494f-94d2-963a67366c38.png">

#### 4. Initialize a new Git repo
------------
- Create a new repository in the project, named: "ExerciseProject".
<img width="857" alt="Initialize Git repo" src="https://user-images.githubusercontent.com/40535130/222897353-1ccf56f2-cfcb-4edc-8f28-64daf8159515.png">


#### 5. Create a feed in Azure Artifacts
------------
- Create a new feed in Azure Artifacts, named: "DemoFeed".
<img width="859" alt="Create feed in Artifacts" src="https://user-images.githubusercontent.com/40535130/222897445-eb4ff102-c639-46e3-848e-936a44dd0105.png">


#### 6. Create a new PowerShell file in the Git repo
------------
- Create a new PowerShell file in the Git repo, named: "readnugetversion.ps1"
![create Powershell file full steps](https://user-images.githubusercontent.com/40535130/222897619-4132e368-156e-4257-903b-8286d124c51d.png)

#### 7. To clone/pull/push to your local drive in Azure DevOps, you need to Generate personal access token (PAT) 
------------
- From your home page, open user settings  and select Personal access tokens.
<img width="364" alt="personal access token" src="https://user-images.githubusercontent.com/40535130/222915960-188515c1-1bf3-4f39-ac4f-0abd4ec185c6.png">
- Click on "New Token" button.
- Enter a name for your token.
- Select the desired expiration date for the token.
- Check the "Full Access" checkbox under "Scope".
- Click on the "Create" button.
<img width="858" alt="new token" src="https://user-images.githubusercontent.com/40535130/222916215-9fcc21d2-3868-4c47-b9bc-788e4c909a96.png">
- When you're done, copy the token and store it in a secure location. For your security, it won't be shown again.

#### 8. Clone the Git repo to your local drive
------------
- Open the command line on your computer.
- Navigate to the folder where you want to clone the repository.
- Run the command: git clone '<repository URL>'
- Enter your Azure DevOps username and PAT when prompted.




