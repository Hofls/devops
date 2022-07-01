## Kafka connect
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

#### Kafka connect. GUI
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
