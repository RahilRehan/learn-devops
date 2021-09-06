## Basic commands
- quickly run shell: `docker container run -it --rm alpine:latest sh`
- start a stopped container `docker container start -it [container_id] sh`
- stop a running container `docker container stop [conainer_id]`
- remove all containers `docker container rm -v $(docker ps -a -q)`
- custom mount volume `docker container run -it -v $(pwd):/host alpine:latest /bin/sh`
- run with custom port `docker container run -it --rm -v $(pwd):/src -p 8080:8080 -w /src golang:alpine /bin/sh`
- The -w flag we are passing is to set the working directory
- running go files in docker:  `docker container run -it --rm -v $(pwd):/src -w /src -p 8080:8080 golang:alpine go run reading_writing_json_8.go`
- remove container and also associated volumes to that container `docker container rm -v server`

## Networking
- networks present by default
	- bridge :  default network that your containers will connect to when you launch them
	- host:  host network is essentially the same network that the Docker engine is running on. so, any port you expose will directly mapped to host machine. This restrict us from using multiple containers as only one port can be mapped to host and poses a security risk to container code. This is just like not using all the features of docker. One example which might use this is API gateway
	- none: containers have no network assigned
	- overlay:  unique Docker network that is used to connect containers running on separate hosts to one another. Usually in prod you can use multiple hosts machines which can have instances of your app.
	- custom network drivers: develop your own plugins  using open source libnetwork project. you can write it to be capable to connect to non docker applications and physical databases
		- weaveworks is a popular custom network driver, visualisations, service discovery etc
		- project calico - very fast custom network driver
	-  When you use a Docker network, Docker automatically adds a mapping to the containers resolve.conf pointing to the built in Docker DNS server, we can then contact other containers connected to the same network by referencing them by name.
	
	### commands
	- creating a new network
		- `docker network create --driver bridge test-network`
	- connecting container to network	
		`docker run -it --rm -v $(pwd):/src -w /src --name server --network=testnetwork golang:alpine go run main.go`
		
### Dockerfile
- as you now see, we have long terminal commands. Dockerfiles will make this intuitive to write all the arguments in a file.
- FROM
	- which image is in use
- MAINTAINER
	- maintainer of application or dockerfile
- EXPOSE
	- does not expose to host
	- you still need to use -p flag to export to host
- ENTRYPOINT ["executable", "param1", "param2"] 
	- runs when container starts.
	- cannot override parameters
	- best approach is to have just executable in entrypoint
- CMD [ "param1", "param2"]
	- attached after entrypoint
	- act as default parameters
	- can be overriden when you pass extra params with run command
	- only one cmd per file is allowed

- build images from dockerfiles
	- docker built -t imagename .
		- . is context: always optimize this, the while context is copied to docker!! huge memory is required
			- it is not always possible to have only requrie files in context
			- so use a .dockerignore file
- run the created image
	- `docker run --rm -p 8080:8080 testserver`

### Docker compose
 - Used to start multiple containers at once with your stack definition stored in a handy YAML file.
 - Container started, and service ready is not the same thing.
	 - so depends-on might not works always
 - docker-compose -f ./docker-compose.yml up
 - docker-compose -f ./docker-compose.yml rm -v : removes container and deletes all associated volumes
 - specify project name and override the default project names so that you can run multiple instances of the same service. As compose checks if a container with same name already running or not.
	 - docker-compose -p testproject up

### Good Practices
- Always keep in mind the "UNION FILE SYSTEM"(important part for caching layers)
- change in one layer requires all the next layers after it to rebuild
- always try to chain RUN commands just to one, so you can reduce number of layers
- organize COPY, copy your package managers list(package.json, go.mod etc) first and then the application code
- do not have deamons(which will autostart containers when they crash) in docker(antipattern) but instead use orchestration mechanism