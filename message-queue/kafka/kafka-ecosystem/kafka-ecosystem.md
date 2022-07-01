## Ecosystem
* Notice: this whole thing is not very good and widespread, there should be better alternatives
* Ecosystem example:
    ```
    Your app -> Ksql Server -> Kafka Connect   -> Kafka
                            -> Schema Registry -> Kafka
                                                  Kafka -> Kafka exporter 
    ```