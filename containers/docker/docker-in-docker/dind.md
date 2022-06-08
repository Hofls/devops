#### Dind alternative - sibling containers
* Based on [stackoverflow answer](https://stackoverflow.com/questions/27879713/is-it-ok-to-run-docker-from-inside-docker/33003273#33003273)
* Get any container with installed docker, [example](https://hub.docker.com/_/docker)
* `docker run --volume /var/run/docker.sock:/var/run/docker.sock -dit --name dind docker`
    * Because of `--volume` will use host docker to run sibling containers
* `docker exec -it dind /bin/sh`
    * `docker run hello-world`
    * `exit`
* `docker kill dind && docker rm dind`

#### Build + tests example
* Look at "java-dependencies" repository, package "test-containers-postgres"