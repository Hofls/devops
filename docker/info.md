#### Install docker
* `apt-get update`
* `apt install docker.io`
    * to test installation:
        * `docker pull hello-world`
        * `docker run hello-world`

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
