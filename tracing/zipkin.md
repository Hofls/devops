#### Getting started
* Run zipkin:
    * `docker run --detach --publish 9411:9411 openzipkin/zipkin`
    * Open Web UI `http://YOUR_SERVER_IP:9411/zpikin`
        * "Search Traces" have the same trace id
        * "Search Dependencies" (shop service -> inventory service; means shop service calls inventory service)
* Run backend demo, that will send data to zipkin:
    * `docker run --detach --network host --add-host=zipkin:127.0.0.1 openzipkin/example-sleuth-webmvc backend`
    * Open `http://YOUR_SERVER_IP:9000/api`
* More in depth info at `java-examples` repository
