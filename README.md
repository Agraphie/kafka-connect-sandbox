# Kafka Sandbox
A sandbox project to play around with Kafka, Kafka connect and Spring.
This project uses Spring Data REST for quickly exposing a `/users` endpoint
with CRUD operations.

## Run
```bash
docker compose up
./gradlew bootRun
```

## Configure
You can apply and change any Kafka connect config. See https://docs.confluent.io/cloud/current/connectors/cc-postgresql-source.html#postgresql-source-jdbc-connector-for-ccloud
You can start with the following config:

```bash
curl --location --request POST 'http://localhost:8083/connectors' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "jdbc_source_postgres_users",
    "config": {
        "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
        "connection.url": "jdbc:postgresql://postgres:5432/postgres",
        "value.converter":"org.apache.kafka.connect.json.JsonConverter", 
        "value.converter.schemas.enable":"false",
        "connection.user": "postgres",
        "connection.password": "postgres",
        "topic.prefix": "postgres_",
        "mode": "timestamp",
        "timestamp.column.name": "updated_at",
        "incrementing.column.name": "id",
        "table.whitelist": "demo_user",
        "output.data.format": "JSON"
    }
}'
```

## Create data
You can run any CRUD operation against `/users`. E.g.
```bash
curl --location --request POST 'http://localhost:8080/users/1' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "user 1"
}'
```

## Consume & view
The class [UserConsumer.java](src/main/java/com/example/kafkaconnectquickstart/user/consumer/UserConsumer.java)
consumes users from Kafka, read from the `demo_user` table via Kafka JDBC connect and logs 
them to the console.