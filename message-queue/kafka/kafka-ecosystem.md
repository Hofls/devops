## Ecosystem
* Notice: this whole thing is not very good and widespread, there is better alternatives
* Example:
    * Your app -> Ksql Server -> Kafka Connect -> Kafka

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

## KSQL server
* [Rest API](https://docs.confluent.io/4.1.0/ksql/docs/api.html)
* Lens -> Cluster -> Network -> Services -> Ksql Server -> Forward port 8088
* CMD:
    * Open shell in ksql container, execute: `unset JMX_PORT && ksql`
* Links:
    * http://localhost:57061/info
        * "Copy request as Node.js fetch" OR "Edit and resend if Firefox"
        * Replace:
            * url: "http://localhost:57061/ksql"
            * "body": `{"ksql": "LIST STREAMS;"}`
            * "method": "POST"
* Alternatives to LIST STREAMS:
    * LIST TOPICS, LIST TABLES, LIST QUERIES, LIST PROPERTIES
* Problems:
    * The server has detected corruption in the command topic
        * Fix - restart Ksql server
    * Could not clean up the schema registry for topic
        * Fix - restart schema registry
* Also manages [migrations](https://docs.ksqldb.io/en/latest/operate-and-deploy/migrations-tool/)
* Migrations changed, checksum is different?
    * Destroy migrations metadata:
        * Create file `ksql-migrations.properties` with content:
            * `ksql.server.url=http://ksqldb-server:8088`
        * `ksql-migrations --config-file /home/user/init/ksql-migrations.properties destroy-metadata`
    * Rollback migrations:
        * Create `rollback.sql` with a bunch of DROP statements:
            * `DROP STREAM IF EXISTS "new_customers" DELETE TOPIC;`
            * `DROP CONNECTOR IF EXISTS "customer_to_warehouse";`
        * `ksql --file /home/user/migrations/rollback.sql http://ksqldb-server:8088`
    * Apply changed migrations:
        * `ksql-migrations --config-file /home/appuser/init/ksql-migrations.properties initialize-metadata`
        * `ksql-migrations --config-file /home/appuser/init/ksql-migrations.properties apply --all`