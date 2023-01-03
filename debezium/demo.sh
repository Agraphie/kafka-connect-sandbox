curl  -H 'Content-Type: application/json' 127.0.0.1:8083/connectors

curl -X DELETE -H 'Content-Type: application/json' 127.0.0.1:8083/connectors/test-cdc-connector

curl -H 'Content-Type: application/json' 127.0.0.1:8083/connectors/test-cdc-connector/status

curl -H 'Content-Type: application/json' 127.0.0.1:8083/connectors --data '
{
  "name": "test-cdc-shipments",
  "config": {
    "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
    "plugin.name": "pgoutput",
    "database.hostname": "postgres",
    "database.port": "5432",
    "database.user": "postgres",
    "database.password": "postgres",
    "database.dbname" : "postgres",
    "database.server.name": "postgres",
    "table.include.list": "public.shipments"
  }
}'

curl -H 'Content-Type: application/json' 127.0.0.1:8083/connectors --data '
{
  "name": "test-cdc-users",
  "config": {
    "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
    "plugin.name": "pgoutput",
    "database.hostname": "postgres",
    "database.port": "5432",
    "database.user": "postgres",
    "database.password": "postgres",
    "database.dbname" : "postgres",
    "database.server.name": "postgres",
    "table.include.list": "public.demo_user"
  }
}'

# consumer change events:
## notice the topic name is always `postgres.public.<tableName>`
docker run --tty \
--network debezium_default \
confluentinc/cp-kafkacat \
kafkacat -b kafka:9092 -C \
-s key=s -s value=avro \
-r http://schema-registry:8081 \
-t postgres.public.shipments

docker run --tty \
--network debezium_default \
confluentinc/cp-kafkacat \
kafkacat -b kafka:9092 -C \
-s key=s -s value=avro \
-r http://schema-registry:8081 \
-t postgres.public.demo_user
