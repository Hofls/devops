#### Install docker
* `sudo su`
* `apt update`
* `apt install docker.io`
* Test installation:
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
    * `docker exec -it SK284KD2J /bin/sh`
* Connect to container `SK284KD2J` as a root user (superuser)
    * `docker exec -u 0 -it SK284KD2J bash`
    * Useful if you need to manually install bunch of packages for debug
* Execute command inside container`SK284KD2J`
    * `docker exec SK284KD2J ls /etc`
    * `docker exec -it SK284KD2J ls /etc`
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
* Copy file from container `SAK2D83JK` to host:
    * `docker cp SAK2D83JK:/file_path_container /filt_path_host`
* Check resources usage (RAM, CPU, MEM, NET):
    * `docker stats`
* Check disk usage (especially useful for gitlab runners):
    * `docker system df`
    * If takes too long - try to delete unused images and volumes 
* Remove unused stuff (containers, images, buildkit cache, networks):
    * `docker system prune --all`
    * `docker system prune --all --volumes` also removes volumes
* Clear all buildkit cache (--mount=type=cache)
    * `docker builder prune`
* Clear old buildkit cache (--mount=type=cache)
    * `docker builder prune --filter "until=48h"`
    * Only cache from last 48 hours will be left untouched
* Smart removal (volumes, images, old buildkit cache)
    * Order is important. Volume/buildkit cache won't be deleted if linked image still exists
    * Image prune:
        * Simple way - `docker image prune --force` (won't remove everything you want)
            * Check - `docker images`
        * Complex way - `docker rmi --force $(docker images --filter="label=to_delete" -q)`
            * Label should be applied during build - `docker build --label "to_delete" .`
    * Volume prune:
        * `docker volume prune --force`
        * Check - `docker volume ls`
    * Buildkit cache prune:
        * `docker builder prune --force --filter "until=48h"`
        * Check - `docker system df --verbose`
* Get `Dockerfile` from image:
    * `docker images`
    * `docker history dahuss/a-dark-room`
        * To output full text` --no-trunc`
* Docker container exits immediately? add `-dit`:
    * `docker run -dit ubuntu`
* Save current container state as new image
    * `docker commit 2a2s23fdwq ubuntu:kek`
    * e.g. - ssh to container, install/configure dependencies, save everything as new image
* Share network with another container (.e.g. share VPN, share localhost)
    * `docker run -dit --privileged --net=container:fortivpn ubuntu` (for details look at forti.md)
* Automatically restart on failure:
    * `docker run --restart on-failure mydockerimage`
* Use custom dockerfile:
    * `docker build . -f extras/Dockerfile-test`
* Edit /etc/hosts:
    * `docker run --add-host=artifactory.some.com:23.32.44.111 mydockerimage`
    * If you try to edit hosts directly - appears error "Read-only file system"
        
#### Dockerfile
* `RUN` vs `CMD` - build step vs execution step
    * `CMD` specifies commands that fill be fed to the `ENTRYPOINT` (which is `/bin/sh -c` by default)
* Each change adds new layer (`FROM`, `RUN`, `COPY`...), docker downloads all layers that come after changed one
    * Retrieves layers before changed one - from cache 
* Find which package manager to use:
    * First way - look at image layers (e.g. on hub.docker.com), often package manager is used here
    * Second way - look at "Find package manager" in `linux.md`
* Pass arguments:
    * Dockerfile:
        * `ARG TEST_ARGUMENT`
        * `RUN echo $TEST_ARGUMENT`
    * CLI:
        * `docker build . --build-arg TEST_ARGUMENT="Hello world"`
    * Notice: ARGs are not global. Each FROM clause has its own ARGs (multi-stage builds)

#### Use private image storage:
* Login to storage - `docker login -u hofls -p qwerty docker.artifactory.kera.com`
* Build & push image:
    * `docker build --tag your-company.com/project-name:build-image .`
    * `docker push your-company.com/project-name:build-image`
* Pull image:
    * Manually `docker pull docker.artifactory.kera.ru/oraclejdk:8_211`
    * Or by adding line to Dockerfile `FROM docker.artifactory.kera.ru/oraclejdk:8_211`

#### Problems
* Command (e.g. `touch /var/log/main.log`) produces error `touch: w: Permission denied`
    * Fix - give ownership to current user `chown -R hofls /var/log/`
* `You have reached your pull rate limit. You may increase the limit by authenticating and upgrading: https://www.docker.com/increase-rate-limits`
    * Use pull-through proxy / cache server