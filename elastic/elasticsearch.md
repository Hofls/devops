#### Info
* `Elasticsearch` - search and analytics engine 

#### Getting started
* Install:
  * `apt update`
  * `apt install docker.io`
  * `docker pull docker.elastic.co/elasticsearch/elasticsearch:7.11.0`
* Run:
  ```
  docker run \
  --publish 9200:9200 --publish 9300:9300 \
  --env "discovery.type=single-node" \
  --detach \
  docker.elastic.co/elasticsearch/elasticsearch:7.11.0
  ```
* Test:
  * Health:
    * `curl -X GET "localhost:9200/_cat/health?v=true&pretty"`
  * Logs:
    * `docker logs 529b9b7d24d7`
  * Write/Read:
    * `curl -X PUT "localhost:9200/customer/_doc/1?pretty" -H 'Content-Type: application/json' -d '{ "name": "John Doe" }'`
    * `curl -X GET "localhost:9200/_cat/indices"`
    * `curl -X GET "localhost:9200/customer/_search?pretty"`

#### Advanced
* Automatically remove old logs (with `crontab`):
  * `0 5 * * * curl -X DELETE http://localhost:9200/filebeat-$(date +"%Y.%m.%d" -d "last Week")`
* 