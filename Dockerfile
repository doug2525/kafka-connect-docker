FROM buildpack-deps:stretch-scm

RUN apt-get update && apt-get install -y --no-install-recommends \
		bzip2 \
		unzip \
		xz-utils \
		apt-utils \
		software-properties-common \
		gettext \
	&& rm -rf /var/lib/apt/lists/*

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home

# do some fancy footwork to create a JAVA_HOME that's cross-architecture-safe
RUN ln -svT "/usr/lib/jvm/java-8-openjdk-$(dpkg --print-architecture)" /docker-java-home
ENV JAVA_HOME /docker-java-home

ENV JAVA_VERSION 8u141
ENV JAVA_DEBIAN_VERSION 8u141-b15-1~deb9u1

# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV CA_CERTIFICATES_JAVA_VERSION 20170531+nmu1

RUN set -ex; \
	\
# deal with slim variants not having man page directories (which causes "update-alternatives" to fail)
	if [ ! -d /usr/share/man/man1 ]; then \
		mkdir -p /usr/share/man/man1; \
	fi; \
	\
	apt-get update; \
	apt-get install -y \
		openjdk-8-jdk="$JAVA_DEBIAN_VERSION" \
		ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
# verify that "docker-java-home" returns what we expect
	[ "$(readlink -f "$JAVA_HOME")" = "$(docker-java-home)" ]; \
	\
# update-alternatives so that future installs of other OpenJDK versions don't change /usr/bin/java
	update-alternatives --get-selections | awk -v home="$(readlink -f "$JAVA_HOME")" 'index($3, home) == 1 { $2 = "manual"; print | "update-alternatives --set-selections" }'; \
# ... and verify that it actually worked for one of the alternatives we care about
	update-alternatives --query java | grep -q 'Status: manual'

# see CA_CERTIFICATES_JAVA_VERSION notes above
RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure

# If you're reading this and have any feedback on how this image could be
# improved, please open an issue or a pull request so we can discuss it!
#
#   https://github.com/docker-library/openjdk/issues

# Add Confluent Repository and install Confluent Platform

RUN wget -qO - http://packages.confluent.io/deb/3.2/archive.key | apt-key add -
RUN add-apt-repository "deb [arch=amd64] http://packages.confluent.io/deb/3.2 stable main"
RUN apt-get update &&  apt-get install -y --no-install-recommends confluent-platform-2.11

# Config script and templates.

COPY configure.sh /configure.sh
COPY connect-standalone.properties.template /etc/kafka/connect-standalone.properties.template
COPY jdbc-source.properties.template /etc/kafka-connect-jdbc/jdbc-source.properties.template
COPY jdbc-sink.properties.template /etc/kafka-connect-jdbc/jdbc-sink.properties.template

## Placeholders for SSL files. Make sure these are updated before building the image.

COPY kafka.client.keystore.jks /kafka.client.keystore.jks
COPY kafka.client.truststore.jks /kafka.client.truststore.jks 


RUN chmod 755 configure.sh 
ENTRYPOINT /configure.sh && /usr/bin/connect-standalone /etc/kafka/connect-standalone.properties /etc/kafka-connect-jdbc/jdbc-source.properties && bash
