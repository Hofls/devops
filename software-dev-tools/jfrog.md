#### Info
* `JFrog` - universal artifact storage (e.g. docker images, npm/maven packages)
* Persistence - `-v /opt/artifactory:/var/opt/jfrog/artifactory`

#### Getting started
* Install & run:
    * `docker run --name artifactory -d -p 8081:8081 -p 8082:8082 releases-docker.jfrog.io/jfrog/artifactory-cpp-ce:latest`
* Check it:
    * Open in browser `http://YOUR_SERVER_IP:8082/ui/login/`
    * Credentials - `admin/password`
