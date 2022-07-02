create stream if not exists "user_stream" (
    "user_id" varchar,
    "name" varchar,
    "address" varchar
)
with (
    kafka_topic='topics.user.v1',
    partitions=1,
    value_format='avro'
);

create sink connector "user_to_service_sink" with (
    'connector.class' = 'io.aiven.kafka.connect.http.HttpSinkConnector',
    'http.url' = 'http://user-service:8080/v1/user',
    'http.authorization.type' = 'none',
    'http.headers.content.type' = 'application/json',
    'batching.enabled' = 'true',
    'batch.prefix' = '{"events":[',
    'batch.suffix' = ']}',
    'batch.separator' = ',',
    'topics' = 'topics.user.v1',
    'key.converter' = 'org.apache.kafka.connect.storage.StringConverter',
    'max.retries' = '1000',
    'retry.backoff.ms' = '3000'
);
