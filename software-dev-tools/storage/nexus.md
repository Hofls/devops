#### Info
* `Nexus` - Artifacts storage/proxy (e.g. for java dependencies, npm packages)
* Persistence - `--volume /opt/nexus-data:/nexus-data`

#### Getting started
* Prerequisite: at least 3GB RAM
* Run nexus:
    * `docker run -d -p 8081:8081 --name nexus sonatype/nexus3`
* Find `admin` password:
    * `docker exec a04s28sd cat /nexus-data/admin.password`
* Open `http://YOUR_SERVER_IP:8081/` -> Sign in
