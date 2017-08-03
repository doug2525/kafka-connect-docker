# kafka-connect-docker

I created this project to be able to deploy Kafka Connect standalone in an elegant fashion. 

## Steps to Deploy a Connector.

#### Ensure that Docker is installed. 

#### Clone the repo and change directory

```bash
git clone git@github.com:cortics/kafka-connect-docker.git
cd kafka-connect-docker
```

Make sure the client Keystore and Truststore are copied to this directory and the Dockerfile is updated to reflect these names. For more info on configuring Kafka Connect with TLS, please visit Confluent's excellent [documentation](http://docs.confluent.io/current/connect/security.html) on that topic.

#### Run ```docker build .```

The initial build takes a couple of minutes as it downloads a number of packages from the Internet. Subsequent builds will be much faster. 

#### Copy the kafka-connect-env.sh.template to kafka-connect-env.sh and add configs.

Once the env file is populated, run the docker container like so 

```docker run -dit --env-file kafka-connect-env.sh --name <container-name> <container-id-from-the-build-above>```

To see the logs,

```docker logs -f <container-name>```


