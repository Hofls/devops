#### Install docker
* `apt update`
* `apt install docker.io`
    * to test installation:
        * `docker pull hello-world`
        * `docker run hello-world`
        
#### From Dockerfile to running container
* Lets say you have `Dockerfile`, `environment.list` and `rest-backend.jar` in same folder
    * `rest-backend.jar` - has endpoints at localhost:8080/swagger-ui.html
* Build image `docker build --tag rest-backend:1.0 .`
    * It should appear in images list: `docker images`
* Run image `docker run --publish 8000:8080 --name rest-container --detach --env-file ./environment.list rest-backend:1.0`
    * It should appear in containers list: `docker ps`
    * Port forwarding should be working: `curl localhost:8000/swagger-ui.html`
    * Connect to container via SSH: `docker exec -it rest-container bash`
        * Make sure that environment variables are set: `echo $VAR1`
        
#### Deploy new version of application
* Look at script example [here](java-rest-backend/extras/update-backend.sh)
    
#### Useful commands:
* List of local images:
    * `docker images`
* List of containers:
    * Running - `docker ps`
    * All - `docker ps --all`
* Connect to container `SK284KD2J` via ssh
    * `docker exec -it SK284KD2J bash`
* Show last 1k logs from container `SAK2D83JK`
    * `docker logs SAK2D83JK --tail 1000`
* Run container that shares host network
    * `docker run --network host strm/helloworld-http`
        * In this case container will listen on port 80 of host network (meaning all incoming http connections)
* Run container that shares host filesystem (persistence)
    * `docker run --volume /host_dir:/container_dir --network host strm/helloworld-http`
        * To test if its working:
            * ssh into container, create file in `container_dir`
            * return to host, check if file appeared in `host_dir`
    * To map container to current directory - `--volume $(pwd):/container_dir`
* Check resources usage (RAM, CPU, MEM, NET):
    * `docker stats`
* Remove containers and images:
    * `docker container prune --force`
    * `docker image prune --force`
* Get `Dockerfile` from image:
    * `docker images`
    * `docker history dahuss/a-dark-room`
        * To output full text` --no-trunc`
        
#### Dockerfile
* `RUN` vs `CMD` - build step vs execution step

#### Connect to private image storage:
* Login to storage - `docker login https://docker.artifactory.kera.ru`
* Pull image:
    * Manually `docker pull docker.artifactory.kera.ru/oraclejdk:8_211`
    * Or by adding line to Dockerfile `FROM docker.artifactory.kera.ru/oraclejdk:8_211`

#### Problems:
* If container won't run, without showing errors:
    * Try to add `-it`, e.g. `docker run -it ubuntu` (interactive + tty)
