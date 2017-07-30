#### Heap setting for Connector
KAFKA_HEAP_OPTS="-Xmx 1536m -Xms 1024m"

#### Kafka Connect Kafka Related Properties

# Kafka Endpoint

KAFKA_BOOTSTRAP_URL=

# Schema Registry URLs. Format is http://host:port 

KEY_SR_URL=
VALUE_SR_URL=

# Offsets file

KC_OFFSETS_FILE=connect-offsets

# SSL Properties

SSL_KEY_PW=
SSL_KEYSTORE_PW=
SSL_TRUSTSTORE_PW=
FULL_PATH_TO_TS=
FULL_PATH_TO_KS=


#### JDBC source related properties

CONNECTOR_NAME=
JDBC_URL=
MODE=
QUERY=
TOPIC=test
POLL_INTERVAL_MS=
TIMESTAMP_COLUMN_NAME=
