#### Kafka GUI client
* In lens - find kafka pod, forward port 9092 to localhost:64064
* Run client (pick 1, not really working):
    * kafka-ui:
        ```
        docker run -p 9044:8080 ^
        -e KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=localhost:64064 ^
        -d provectuslabs/kafka-ui:latest
        ```
    * kafdrop:
        ```
        docker run -d --rm -p 9044:9000 ^
        -e KAFKA_BROKERCONNECT=localhost:64064 ^
        -e JVM_OPTS="-Xms32M -Xmx64M" ^
        -e SERVER_SERVLET_CONTEXTPATH="/" ^
        obsidiandynamics/kafdrop
        ```
    * Redpanda Console:
        ```
        docker run -p 8080:8080 -e KAFKA_BROKERS=localhost:64064 ^
        docker.redpanda.com/vectorized/console:master-0a8fce8
        ```
* Open http://localhost:9044/ in browser
* If client has error in logs `Broker may not be available`
    * It means you cannot connect to kafka using localhost
    * Deploy [kafka-ui](yaml/kafka-ui.yaml) / [kafdrop](yaml/kafdrop.yaml) / [redpanda](yaml/redpanda.yaml) to k8s cluster
        * Make sure that kafka service name is `kafka`, port is `9092`
        * Lens -> Create resource -> Paste -> Create & Close
    * Find kafka-ui pod, forward container port 8080 to localhost:9044, open it in browser

#### Kafka GUI clients comparison
* [kafka-ui](https://github.com/provectus/kafka-ui)
    * Notice: simply the best
    * Topics list, Add a topic, Topic messages/consumers/stats/settings, Send message, Recreate Topic, Remove Topic, Copy topic, Purge messages
    * Consumer group list, Reset offset, Delete consumer group
    * Brokers/Clusters info, metrics (production/consumption)
    * KSQL DB - Tables/Streams list, Execute KSQL request
    * Kafka Connect - Connectors list, Create connector, Remove connector, Restart connector/tasks, Edit connector, Connector tasks/config
    * Schema Registry - Schemas list, Create schema, Compare Versions, Edit Schema, Remove Schema
* [redpanda](https://github.com/redpanda-data/console)
    * Notice: no KSQL integration
    * Topics list, Create Topic, Publish Message, Topic messages/consumers/partitions/configuration
    * Consumer group list, Edit Group, Delete Group
    * Broker parameters, Access Control List, Quotas
    * Schema Registry - ?
    * Kafka Connect - ?
* [kafdrop](https://github.com/obsidiandynamics/kafdrop)
    * Notice: amount of functionality is very low (no KSQL, no Kafka Connect, no Schema Registry, no Send message, etc)
    * Topics list, New topic, Delete topic, Messages, Consumers