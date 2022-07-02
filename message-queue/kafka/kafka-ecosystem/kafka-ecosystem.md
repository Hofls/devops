## Ecosystem
* Notice: this whole thing is not very good and widespread, there should be better alternatives
* Ecosystem example:
    ```
    Your app -> Ksql Server -> Kafka Connect   -> Kafka
    Your app -> Ksql Server -> Schema Registry -> Kafka
                                                  Kafka -> Kafka exporter 
    ```
  
## Kafka exporter
* Exports kafka metrics in prometheus format (e.g. schema for topic)
* Lens -> Pods -> kafka-exporter -> Port forwarding -> to port 57017
    * Open localhost:57017/metrics , look at metrics

## Schema registry
* Stores JSON/Protobuf schemas
* [Rest API](https://docs.confluent.io/platform/current/schema-registry/develop/api.html)
    * Lens -> Cluster -> Network -> Services -> Schema-registry -> Forward port 8081
    * Schemas - http://localhost:53823/schemas
    * Subjects - http://localhost:53823/subjects

## Zookeeper
* Back in the day was necessary part of kafka (distributed coordination, leader election) 
* Now its actively being removed (2022)
