##### Getting started (.jar)
* Install java
    * To check - `java --version`
* Get any .jar file, e.g. `rest-backend.jar` from `docker/java-rest-backend`
    * Make sure its working - `java -jar rest-backend.jar`
* Download [jmx exporter (jar)](https://github.com/prometheus/jmx_exporter)
* Download [example config](https://github.com/prometheus/jmx_exporter/tree/master/example_configs)
    * Or just create empty config file
* Move everything to the same folder
* Open console, execute:
    * `java -javaagent:./jmx_prometheus_javaagent-0.14.0.jar=8081:config.yaml -jar rest-backend.jar`
* Open http://localhost:8081/ to look at metrics, [example](example.txt)

##### Getting started (.war)
* The only difference - add `-javaagent` to `JAVA_OPTS` at `${wildfly}/bin/standalone.conf`
