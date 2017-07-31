envsubst < /etc/kafka/connect-standalone.properties.template > /etc/kafka/connect-standalone.properties
envsubst < /etc/kafka-connect-jdbc/jdbc-source.properties.template > /etc/kafka-connect-jdbc/jdbc-source.properties
envsubst < /etc/kafka-connect-jdbc/jdbc-sink.properties.template > /etc/kafka-connect-jdbc/jdbc-sink.properties
