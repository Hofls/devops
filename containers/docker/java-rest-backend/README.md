# Java REST backend 

# How to run
#### Locally (.jar)
* Execute commands:
    * `mvn clean bootJar`
    * `cd build/libs`
    * `java -jar rest-backend.jar`
* Open [link](http://localhost:8080/rest-backend/swagger-ui.html)

#### Maven
Build project by executing `mvn clean install`.  
* To run locally (debug mode) - `mvn clean spring-boot:run`
Then open [link](http://localhost:8080/rest-backend/swagger-ui.html)

#### Gradle
Build project by executing `mvn clean bootJar`
* Run locally:
    * `gradlew bootRun`
    * Then open [link](http://localhost:8080/rest-backend/swagger-ui.html)

#### Docker
* Prerequisites:
    * Server with `docker` and `apache2`
    * .jar file (build with maven/gradle)
* Build project with maven/gradle
* Copy to the server:
    * Contents of folder [extras](extras)
    * .jar file
* Set reverse proxy to redirect traffic 
    * from `localhost:80/rest-backend`
    * to `http://localhost:8000/rest-backend`
* Run script update-backend.sh
* Check if everything is working:
    * Execute `curl localhost:8000/rest-backend/swagger-ui.html`
    * Open link in browser `http://YOUR_SERVER_IP/rest-backend/swagger-ui.html`, send requests
