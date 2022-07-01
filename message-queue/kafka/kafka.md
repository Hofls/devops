#### Info
* Kafka - event streaming platform (publish/subscribe)

#### Getting started
* Install Java:
    * `apt update && apt install default-jre`
    * `java --version` (should be 8+)
* Install & run Kafka:
    * `wget https://dlcdn.apache.org/kafka/3.1.0/kafka_2.13-3.1.0.tgz`
    * `cd kafka_2.13-3.1.0`
    * `nohup bin/zookeeper-server-start.sh config/zookeeper.properties &`
    * `nohup bin/kafka-server-start.sh config/server.properties &`
* Create topic:
    * `bin/kafka-topics.sh --create --topic quickstart-topic --bootstrap-server localhost:9092`
    * `bin/kafka-topics.sh --describe --topic quickstart-topic --bootstrap-server localhost:9092`
* Write events:
    * ```
      bin/kafka-console-producer.sh --topic quickstart-topic --bootstrap-server localhost:9092
      First event!
      Second event.
      ```
* Read events:
    * `bin/kafka-console-consumer.sh --topic quickstart-topic --from-beginning --bootstrap-server localhost:9092`
* To read/write events with client - look at `java-dependencies` repository

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
* 
