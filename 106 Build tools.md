## Build Tools and Artifact Repositories
### why do they exist?
- to compile, compress and package the application into single artifact which can be deployed to production or for testing or other purposes.

### Artifacts
- similar to zip files, but contains all the files required to run the application with configurations.
##### examples
- gradle, maven, webpack, make
- when you build java code with gradle, artifacts are stored in build/lib folder
- when you build java code with maven, artifacts are stored in taget folder

### dependency management
##### why?
- to list all the required dependencies and versions
- all build tools require a dependency management file
- all downloaded dependencies are cached by most tools

### package managers
- tools to just handle dependencies
- example: npm, yarn

##### examples
- pom.xml, build.gradle, package.json, go.mod etc
 
### Artifact repository
##### why do they exist?
- whenever you build a new version of an artifact, store them in artifact repository

##### uses
- if there are no changes, we can skip build the step
- we can share or host this repository so that people can access
- we can automate CI/CD and push artifacts on go
	- ex: use jenkins to push when build is successful in CI 
- most of artifact repositories provide a nice REST api
- multiple artifact formats are supported in most of artifact repositories
- they provide version tagging
- they provide cleanup policies if you follow CI, else repositories will run out of space
- functionality to search for particular repositories
- authentication and authorization

##### examples:
- docker repository, nexus(local), mavencentral(public), npm repository(public)
- you can proxy nexus to fetch from mavencentral -> so that you can have single source to download and cache

### Docker
- no need to have different artifact types, all can be images
- spinning up multiple instances becomes easier
- configuration becomes simple

### workflow
- install dependencies -> run tests -> build/bundle -> push to repository

