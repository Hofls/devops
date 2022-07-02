## Kafka connect
* Works with connectors (send data from topic to http endpoint or directly to DB)
* [Rest API](https://docs.confluent.io/platform/current/connect/references/restapi.html)
* Lens -> Cluster -> Network -> Services -> Kafka-connect -> Forward port 8083
* Links:
    * http://localhost:56016/
    * http://localhost:56016/connectors/
        * To create:
            * "Copy request as Node.js fetch" OR "Edit and resend if Firefox"
            * Add "name" and "config" to body
            * Add "content-type": "application/json" to headers
            * Replace `GET` with `POST` 
    * http://localhost:56016/connectors/your_connector_name_here
        * To delete:
            * "Copy request as Node.js fetch" OR "Edit and resend if Firefox"
            * Replace `GET` with `DELETE`
    * Status - http://localhost:56016/connectors/INSER_CONNECTOR_NAME_HERE/status
    * Restart connector - POST http://localhost:56016/connectors/CONNECTOR_NAME_HERE/restart
    * Restart connector task - POST http://localhost:56016/connectors/CONNECTOR_NAME_HERE/tasks/TASK_ID_HERE/restart
        * Use case - service was dead, sink connector tried for some time and died too
        * In kafka logs - "Group connect-CONNECTOR_NAME_HERE transitioned to Dead in generation 2"

#### Kafka connect. GUI (Module)
* Look at [kafka.md](kafka-ecosystem.md), text `yaml/kafka-ui.yaml`
* Add environment variables:
    * `KAFKA_CLUSTERS_0_KAFKACONNECT_0_ADDRESS` - kafka-connect k8s service name + port
    * `KAFKA_CLUSTERS_0_KAFKACONNECT_0_NAME` - look for parameter CONNECT_REST_ADVERTISED_HOST_NAME in kafka-connect pod
* New menu item should appear on UI - `Kafka Connect`

#### Kafka connect. GUI (Standalone)
* In lens - find kafka-connect pod, forward port 8083 to localhost:9090
* Run client (not really working):
    ```
    docker run --rm -it -p 7373:8000 \
    -e "CONNECT_URL=http://localhost:9090" \
    landoop/kafka-connect-ui
    ```
* Open http://localhost:9044/ in browser
* If `CONNECTIVITY ERROR` appears
    * It means you cannot connect to kafka-connect using localhost
    * Deploy [kafka-ui](yaml/kafka-connect.yaml) to k8s cluster
        * Make sure that service name is `cp-kafka-connect`, port is `8083`
        * Lens -> Create resource -> Paste -> Create & Close
    * Find kafka-ui pod, forward container port 8000 to localhost:7373, open it in browser
