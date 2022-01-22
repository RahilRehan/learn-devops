# Nexus
### Basics
- to bring up nexus: download tar or docker image
- there are two nexus folders: nexus-version, sonatype-work
	- nexus-version: binaries to bring up nexus
	- sonatype-work:
		- contains custom config of nexus
		- contains IP addressing which accessed nexis
		- contains logs of nexus 
		- you can backup nexus data in this folder
- nexus by default start on port 8081

### User creation
- never start nexus application with root user
	- you can change config to run as specific user in nexus/bin/nexus.rc
- you can create a new user in security tab, always assign to user least required roles/privileges to complete the task.

### upload artifacts
- put these lines in `build.gradle` to export .jar from build folder to local nexus
- put all the secrets like `nexusUser` and `nexusPass` in gradle.properties(git ignored)

```java
publishing{  
	publications{  
		maven(MavenPublication){  
			artifact("build/libs/payment-0.0.1-SNAPSHOT.jar"){  
				extension 'jar'  
			}  
 		}
	}  
	repositories{  
		maven{  
			name "nexus"  
			url "http://localhost:8081/repository/maven-snapshots/"  
			allowInsecureProtocol true  
			credentials{  
				username project.nexusUser  
				password project.nexusPass  
			}  
		}
	}
}
```

- for maven projects the structure will be different
- to store secret in maven project, create `settings.xml` in `.m2`  folder and store them there

### Blob store
- nexus storage which stores all uploaded files(binary files)
- options od local storage and cloud storage(amazon s3)
- if a repository uses blob, u cant delete it
- you can attach a specific repository to blob store

### cleanup policies
- clear storage or repositories when certain criteria is met
- you can check status of cleanup policies in tasks 
- these cleanup policies soft deleted your content
- to permanantly delete, we need to compact the blob store
- 