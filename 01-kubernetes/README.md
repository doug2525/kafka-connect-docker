## Kubernetes(k8s) Local Setup.

This section will help you get started with a local Kubernetes install.
Virtualization should be enabled in your BIOS.

You will need VirtualBox which can be downloaded and installed from [here](https://www.virtualbox.org/wiki/Downloads) for your operating system.

### Installing kubectl
Kubectl is the command line client for kubernetes and will be used for most interactions with Kubernetes.

The following commands will install the latest version of kubectl on your machine.

##### macOS
```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/darwin/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/kubectl
```
##### Linux
```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/kubectl
```
You can check the install by running `kubectl version`. You should get something like this.
```
kubectl version
Client Version: version.Info{Major:"1", Minor:"9", GitVersion:"v1.9.0", GitCommit:"925c127ec6b946659ad0fd596fa959be43f0cc05", GitTreeState:"clean", BuildDate:"2017-12-15T21:07:38Z", GoVersion:"go1.9.2", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"9", GitVersion:"v1.9.0", GitCommit:"925c127ec6b946659ad0fd596fa959be43f0cc05", GitTreeState:"clean", BuildDate:"2017-12-15T20:55:30Z", GoVersion:"go1.9.2", Compiler:"gc", Platform:"linux/amd64"}
```
You may not see the server version yet as your k8s cluster is not yet setup.

### Installing Minikube

Minikube is a self-contained single-node local Kubernetes cluster running in a VM on your laptop/workstation. It is very easy and install and configure as described below.

The Minikube binary can be downloaded from the GitHub releases page [here](https://github.com/kubernetes/minikube/releases).

As of this writing, the latest version is `0.25.0`. To install

On macOS,

```bash
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.25.0/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
```

On Linux,

```bash
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.25.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
```
Now you can run `minikube version` and you should see something like this.

```bash
$ minikube version
minikube version: v0.25.0
```
To get the available versions of Kubernetes, you can run `minikube get-k8s-versions`.  The output will be something like this.

```bash
minikube get-k8s-versions
- v1.9.0
- v1.8.0
- v1.7.5
- v1.7.4
- v1.7.3
.
.
.
```
To deploy the latest version `v1.9.0`, you can run `minikube start --kubernetes-version v1.9.0`. The output will be something like this.
```bash
$ minikube start --kubernetes-version v1.9.0
Starting local Kubernetes v1.9.0 cluster...
Starting VM...
Getting VM IP address...
Moving files into cluster...
Setting up certs...
Connecting to cluster...
Setting up kubeconfig...
Starting cluster components...
Kubectl is now configured to use the cluster.
Loading cached images from config file.
```

As indicated above in the output for the start command, you can
To check the status of your new cluster, you can run `kubectl get componentstatuses`. The output should look something like this.

```bash
$ kubectl get componentstatuses
NAME                 STATUS    MESSAGE              ERROR
etcd-0               Healthy   {"health": "true"}   
controller-manager   Healthy   ok                   
scheduler            Healthy   ok                  
```

To stop the VM temorarily, you can run `minikube stop`. The output will be something like this.
```bash
$ minikube stop
Stopping local Kubernetes cluster...
Machine stopped.
```

You can check the status of your Minikube cluster by running `minikube status`. The output will be something like this.
```bash
$ minikube status
minikube: Running
cluster: Running
kubectl: Correctly Configured: pointing to minikube-vm at 192.168.99.100
```

To remove all k8s related components created by Minikube, you can run `minikube delete`. All data, configuration and state will be destroyed.
```bash
$ minikube delete
Deleting local Kubernetes cluster...
Machine deleted.
```
You should now have a functional Kubernetes cluster on your laptop/workstation. We'll use the cluster to deploy a number of Kafka Connect Sources and Sinks with a variety of datastores.
