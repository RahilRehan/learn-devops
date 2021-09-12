## Jenkins
### why it exists?
- jenkins is a build automation tool
- whenever you want to do CI, the build process becomes repititive
- to overcome the repititive work, we use jenkins

### installing jenkins
- preferred way is to use docker container

### jenkin roles
- jenkins admin: administrators(ops/devops team)
- jenkins users: users(devops/developers)

### configure build tools
- depending on language, you need to have a build tools(ex: maven, gradle, node/npm) to run test and compile project.
- configure build tools in `global tool configuration`
- options
	- Jenkins plugin 
	- directly install build tools on jenkins container

### setup jobs
- jobs will be the actual commands/work which will be executed step by step
- each step in job can ne configured as a direct command or added from plugin
- we can also setup source code repo i.e git
- we can run shell scripts which contain bunch of commands

### setup docker, nexus on jenkins
- (tried but not working in macos)
- usually, you build images from source code in jenkin jobs
- to build images, we need docker runtime and server on jenkins cotainer
- rather than installing docker again jenkins, we can mount docker from host machine
```
docker run \
-p 8080:8080 \
-p 50000:50000 \
-v jenkins_home:/var/jenkins/home \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker \
jenkins/jenkins:lts
```
- make sure the jenkins user has read and write(`chmod 666`) permissions on /var/run/docker/docker.sock, add permissions via root user
- to push to lets say nexus, on host machine, also change /etc/docker/deamon.json, restart the jenkins container and also change permission for docker sock file again
```
{
	insecure-registries: [registery-ip:port] //this can be nexus ip:port
}
```
- build and push commands
```
docker build -t nexusrepoip:port/imagename:tag .
echo $PASSWORD | docker login -u $USERNAME --password-stdin nexusip:port
docker push imagename
```
- above PASSWORD and USERNAME are exported from jenkins credentials in build step itself(while creating job).

### jobs in jenkins
- freestyle
- pipeline
- multibranch pipeline

### freestyle vs multiple freestyle vs pipeline
- freestyle job can be seen as one task/job, ex: test or build
- by combining multiple freestyles you can have one freestyle for test, another build and other for deployment etc.
- freestyles are old, have ui and use plugins with limited functionalities.
- infrastructure as code is becoming popular and we need more customization, especially in CI/CD environment. welcome to pipelines.

### pipelines
- infrastructure as code as a principle
- pipeline scripts are written in groovy
- best practice is to have pipeline script in scm itself
- usually we have Jenkins file in root of project
- these groovy scipts are of two types
	- scripped : advanced, it will be like writing real script, no strucure
	- declarative: easy, has a strucure and hence limits some functionality
```
pipeline{
	agents any //where to execute
	
	tools{
		// below are avaiable by default, for others this is not supoorted
		maven "Maven"
		gradle
		jdk
	}
	
	//define env variables
	environment{
		NEW_ENV="something"
		SERVER_CREDENTIALS=credentials("id")
	}
	stages {
		stage("build"){
			steps{
			
			}
		}
		stage("build"){
			when{
				expression{
					BRANCH_NAME=="dev" || BRANCH_NAME=="master"
				}
			}
			steps{
				withCredentials([
					usernamePassword(credentials: "id", usernameVariable: USER, passwordVariable:PWD)
				]){
					sh "some script ${USER} ${PWD}"
				}
			}
		}
	}
}
```
- tools attribute: provides build tools for application
- jenkins provide environment variables by default
	- jenkins_ip:port/env-vars.html
- to use credentials in jenkin script, we need  credentials binding plugin
- post attribute : execute logic after all stages are done
```
post{
	always{
	}
	success{
	}
	failure{
	}
}
```
- parametrizing the build, now you will have ui for below parameters
```
//define in pipeline scope
parameter{
	choice(name: "version", choices: ["1.0", "1.1", "1.2", description:""])
	booleanParam(name: "executeTests", defaultValue: true, description:"")
}
//to use these variable, just use
${params.version}
```
- we can also import orther scripts into main scripts
- input parameters
```
//define
input{
	message: "input environment to deploy into"
	ok: "done"
	parameters{
		choice(name:"env", choices: ["dev", "staging", "prod"], description: "")
	}
}

//use
${env}
```

### multi branch pipeline
- pipeline for branches on git
- ex: run test for all branches, but for master: run tests and deploy
- executing each branch, will check for Jenkins file in branch, if presents then jenkins runs accoring to jenkins file
- we can execute commands according to branch, based on BRANCH_NAME variable which is injected by jenkins when using multi branch pipeline
- use when > expression 

### shared library
- if you are using lets say a microservice architecture and you have many services.
- there might be similar jenkin stages or steps in these different microservices.
- to reduce redundancy, we create a shared library.
- these shared library functions can be hosted on github as well

### webhooks and triggers
- to build automatically whenever there is a change in git state(push or merge ...etc)

### application versioning
- version: major:minor:patch => 4.1.3
	- pathches: dont change api
	- minor: changes which are backward compatible
	- major: big changes, which might break current usage
- we should try to automate versions rather than modifying them in build files(package.json, pom.xml etc)
- we can use build-helper in maven
- similarly we can have different plugins in different languages to increment versions
- also do not forget to add version names to docker images
- and all the version changes should reflect in git repo as well
	- so we need to commit from jenkins with credentials(also make sure u commit to correct branch)
		- include gitconfig as well
		- set origin url
	- also ignore build for commits from jenkins, else we will get into endless loop(use plugin, ignore committer strategy -> uses username or email from gitconfig)

### extras
- for sshig into server, use ssh plugin(ssh agent)
- use docker compose to deploy

