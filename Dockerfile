FROM openjdk:8-jre

# Add Confluent Repository and install Confluent Platform
RUN wget -qO - http://packages.confluent.io/deb/3.2/archive.key | apt-key add -
RUN echo "deb [arch=amd64] http://packages.confluent.io/deb/3.3 stable main" > /etc/apt/sources.list.d/confluent.list
RUN apt-get update &&  apt-get install -y --no-install-recommends apt-utils confluent-kafka-connect-* confluent-schema-registry gettext confluent-kafka-2.11
# Config script and templates.

COPY configure.sh /configure.sh
COPY connect-standalone.properties.template /etc/kafka/connect-standalone.properties.template
COPY jdbc-source.properties.template /etc/kafka-connect-jdbc/jdbc-source.properties.template
COPY jdbc-sink.properties.template /etc/kafka-connect-jdbc/jdbc-sink.properties.template

## Placeholders for SSL files. Make sure these are updated before building the image.

COPY kafka.client.keystore.jks /kafka.client.keystore.jks
COPY kafka.client.truststore.jks /kafka.client.truststore.jks 


RUN chmod 755 configure.sh 
ENTRYPOINT /configure.sh && $KC_CMD && bash
