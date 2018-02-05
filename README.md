# kafka-connect-docker

I created this project to be able to deploy Kafka Connect instances in an elegant, secure and scalable manner. 

## Prerequisites for running connectors. 

#### Ensure that Docker is installed. 

You can download Docker for linux using this command.

```bash
curl -SsL https://get.docker.com | bash
```
For macOS, you can download Docker from [here](https://docs.docker.com/docker-for-mac/install/#download-docker-for-mac).

You can verify a docker install by running `docker version`. The output should be something like this.
```bash
$ docker version
Client:
 Version:	17.12.0-ce
 API version:	1.35
 Go version:	go1.9.2
 Git commit:	c97c6d6
 Built:	Wed Dec 27 20:03:51 2017
 OS/Arch:	darwin/amd64

Server:
 Engine:
  Version:	17.12.0-ce
  API version:	1.35 (minimum version 1.12)
  Go version:	go1.9.2
  Git commit:	c97c6d6
  Built:	Wed Dec 27 20:12:29 2017
  OS/Arch:	linux/amd64
  Experimental:	true
```
To test the connectors, you'll need at minimum, a Kafka sandbox with the associated services running locally. Run can get them up and running by using Landoop's `fast-data-dev` image like so.
```bash
 docker run -dit --name kafka-sbx -p 2181:2181 -p 3030:3030 -p 8081-8083:8081-8083 -p 9581-9585:9581-9585 -p 9092-9093:9092-9093 -e ADV_HOST=<your-machine-ip> -e ENABLE_SSL=1 landoop/fast-data-dev:latest 
 ```
Replace the value of `ADV_HOST` with your LAN IP.

You can check `http://<your-machine-ip>:3030` for the Landoop dashboard.
 
You can download the certs needed to connect to Kafka over SSL from `http://<your-machine-ip>:3030/certs`. The password for key/truststore and SSL key is `fastdata`.

## Running connectors.

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


