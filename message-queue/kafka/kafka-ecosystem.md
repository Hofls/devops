#### Ecosystem
* Disclaimer: this whole thing is not very good and widespread, there is better alternatives
* Example:
    * Your app -> Ksql Server -> Kafka Connect -> Kafka

#### Kafka connect
* [Rest API](https://docs.confluent.io/platform/current/connect/references/restapi.html)
* Lens -> Cluster -> Network -> Services -> Kafka-connect -> Forward port 8083
* Links:
    * http://localhost:56016/
    * http://localhost:56016/connectors/
    * http://localhost:56016/connectors/your_connector_name_here
        * To delete - "Copy request as Node.js fetch" OR "Edit and resend if Firefox"
        * Replace `GET` with `DELETE`

#### KSQL server
* [Rest API](https://docs.confluent.io/4.1.0/ksql/docs/api.html)
* Lens -> Cluster -> Network -> Services -> Ksql Server -> Forward port 8088
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
