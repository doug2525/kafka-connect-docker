## Kubernetes(k8s) Local Setup.

This section will help you get started with a local Kubernetes install.
Virtualization should be enabled in your BIOS.

### Installing kubectl
Kubectl is the command line client for kubernetes and will be used for most interactions with Kubernetes.

The following commands will install the latest version of kubectl on your machine.

###### macOS
```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/darwin/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/kubectl
```
###### Linux
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
