# Installing Kuberentes On Ubuntu Servers
---
The purpose of this guide is to automate the installation of a Kubernetes cluster on Ubuntu Servers.

Before we start, let us point out couple of points.
1. The scripts available in this mainfest is tested on Ubuntu 18.04
2. The scripts available here supports only one Master Node and one or more Workers Node.
3. Two scripts to be used
..* One to install Kubernetes on the Master Node.
..* One to Install Kubernetes on the Worker Node.

## Installing Kubernetes on Master Node
---
First, we will install Kubernetes on the Master Node.

We will be using the MasterNodeInstall.sh to automate almost all the tasks to install Kubernetes.
The script will install Kubernetes with the version highlighted in line 2 and with the Pod CIDR and Service CIDR highlighted in line 3 and 4. Please change the version and the CIDR if required.

```
curl https://raw.githubusercontent.com/tahershaker/Kubernetes-BareMetal-Install/main/MasterNodeInstall.sh | bash
```

Once the script is complete, copy the kubeadm join command to use it on the Worker Nodes. 

Example of the kubeadm join command:

```
kubeadm join 10.10.20.78:6443 --token lxq0zl.seush421jcd56cx1 \
    --discovery-token-ca-cert-hash sha256:f1a87bf35dbb75ac44c6b6d2277dee35e28ea710fd99b559e724fd52a3e1d66d
```

If you missed this output, you can use the below command to retrive the output again.
```
kubeadm token create --print-join-command
```

## Installing Kubernetes on Worker Node
---
```
curl https://raw.githubusercontent.com/tahershaker/Kubernetes-BareMetal-Install/main/WorkerNodeInstall.sh | bash
```

