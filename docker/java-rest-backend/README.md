# Java REST backend 

# How to run
#### .jar (possibly in Docker container)
* Execute commands:
    * `mvn clean bootJar`
    * `cd build/libs`
    * `java -jar rest-backend.jar`
* Open link [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)

#### Maven
Build project by executing `mvn clean install`.  
* To run locally (debug mode) - `mvn clean spring-boot:run`
Then open link in the browser [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)

#### Gradle
* Run locally:
    * `gradlew bootRun`
    * Then open link in the browser [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)
