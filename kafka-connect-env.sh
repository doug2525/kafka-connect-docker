#### Command to execute

KC_CMD=
## Example: /usr/bin/connect-standalone /etc/kafka/connect-standalone.properties /etc/kafka-connect-jdbc/jdbc-sink.properties


#### Heap setting for Connector
#KAFKA_HEAP_OPTS="-Xmx1536m -Xms1024m"

#### Kafka Connect Kafka Related Properties

# Kafka Endpoint

KAFKA_BOOTSTRAP_URL=

# Schema Registry URLs. Format is http://host:port 

KEY_SR_URL=
VALUE_SR_URL=

# Offsets file

KC_OFFSETS_FILE=

## Absolute path within the Docker container. use host networking when possible, otherwise may not be reachable.

# SSL Properties

SSL_KEY_PW=
SSL_KEYSTORE_PW=
SSL_TRUSTSTORE_PW=
FULL_PATH_TO_TS=
FULL_PATH_TO_KS=

#### JDBC source related properties

SOURCE_CONNECTOR_NAME=
SOURCE_JDBC_URL=
SOURCE_MODE=
SOURCE_QUERY=
SOURCE_TOPIC=
SOURCE_POLL_INTERVAL_MS=
SOURCE_TIMESTAMP_COLUMN_NAME=


#### JDBC Sink related properties

SINK_CONNECTOR_NAME=
SINK_TOPICS=
SINK_AUTO_CREATE=
SINK_AUTO_EVOLVE=
SINK_TABLE_NAME_FORMAT=
