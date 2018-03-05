FROM openjdk:9-jre

ENV KAFKA_HEAP_OPTS "-Xmx3072M"
# Add Confluent Repository and install Confluent Platform
RUN wget -qO - http://packages.confluent.io/deb/4.0/archive.key | apt-key add -
RUN echo "deb [arch=amd64] http://packages.confluent.io/deb/4.0 stable main" > /etc/apt/sources.list.d/confluent.list
RUN apt-get update &&  apt-get install -y --no-install-recommends apt-utils confluent-kafka-connect-* confluent-schema-registry gettext confluent-kafka-2.11
# Config script and templates.

COPY configure.sh /configure.sh
COPY connect-standalone.properties.template /etc/kafka/connect-standalone.properties.template
COPY jdbc-source.properties.template /etc/kafka-connect-jdbc/jdbc-source.properties.template
COPY jdbc-sink.properties.template /etc/kafka-connect-jdbc/jdbc-sink.properties.template

RUN chmod 755 configure.sh 
ENTRYPOINT /configure.sh && $KC_CMD && bash
