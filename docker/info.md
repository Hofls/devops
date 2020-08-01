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
* Run image `docker run --publish 8000:8080 --detach --env-file ./environment.list rest-backend:1.0`
    * It should appear in containers list: `docker ps`
    * Port forwarding should be working: `curl localhost:8000/swagger-ui.html`
    * Connect to container via SSH: `docker exec -it SK284KD2J bash`
        * Make sure that environment variables are set: `echo $VAR1`
    
#### Useful commands:
* List of local images:
    * `docker images`
* List of running containers:
    * `docker ps`
* Connect to container `SK284KD2J` via ssh
    * `docker exec -it SK284KD2J bash`
* Show container `SAK2D83JK` logs
    * `docker logs SAK2D83JK`
* Build and run Dockerfile
    * `docker run -it $(docker build -q .)`
