## KSQL server
* [Rest API](https://docs.confluent.io/4.1.0/ksql/docs/api.html)
* KSQL migrations [examples](ksql-migrations)
* Lens -> Cluster -> Network -> Services -> Ksql Server -> Forward port 8088
    * http://localhost:57061/info
        * "Copy request as Node.js fetch" OR "Edit and resend if Firefox"
        * Replace:
            * url: "http://localhost:57061/ksql"
            * "body": `{"ksql": "LIST STREAMS;"}`
            * "method": "POST"
* CMD:
    * Open shell in ksql container, execute: `unset JMX_PORT && ksql`
* Alternatives to LIST STREAMS:
    * LIST TOPICS, LIST TABLES, LIST QUERIES, LIST PROPERTIES
* Problems:
    * The server has detected corruption in the command topic
        * Fix - restart Ksql server
    * Could not clean up the schema registry for topic
        * Fix - restart schema registry
* Also manages [migrations](https://docs.ksqldb.io/en/latest/operate-and-deploy/migrations-tool/)

## KSQL server. Problems
* Kafka restarted, now error appears - `A server restart is required to restore full functionality.. Error code: 50000`
    * Fix - restart KSQL
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

#### KSQL. GUI
* Look at [kafka.md](../kafka.md), text `yaml/kafka-ui.yaml`
* Add environment variable:
    * `KAFKA_CLUSTERS_0_KSQLDBSERVER` - ksql db k8s service name + port
* New menu item should appear on UI - `KSQL DB`
