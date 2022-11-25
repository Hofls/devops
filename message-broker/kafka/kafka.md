#### Info
* Kafka - event streaming platform (publish/subscribe)

#### Getting started. CLI
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

#### Getting started. GUI
* Use [kafka-ui](kafka-gui.md)

#### Problems
* Unable to connect to `kafka:9092` (docker)
    * Fix - set parameter `KAFKA_CFG_ADVERTISED_LISTENERS: CLIENT://kafka:9092,EXTERNAL://localhost:9094`
