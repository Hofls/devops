#### Info
* `Kibana` - Web-interface for `Elastic Stack`

#### Getting started
* Install:
    * Prerequisite: install on same node as `Elasticsearch`
    * `docker pull docker.elastic.co/kibana/kibana:7.11.0`
* Run:
    * `docker run -d --link 529b9b7d24d7:elasticsearch -p 5601:5601 docker.elastic.co/kibana/kibana:7.11.0`
    * Where 529b9b7d24d7 is elasticsearch container
* Test:
    * `docker logs KIBANA_CONTAINER_NAME`
    * Execute on the server: `curl localhost:5601/app/home`
    * Open URL in a browser: `http://YUR_SERVER_IP:5601`
