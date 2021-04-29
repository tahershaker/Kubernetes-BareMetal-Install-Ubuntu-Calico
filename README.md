# Installing Kuberentes On Ubuntu Servers

The purpose of this guide is to automate the installation of a Kubernetes cluster on Ubuntu Servers.

Before we start, let us point out couple of points.
* The scripts available in this mainfest is tested on Ubuntu 18.04
* The scripts available here supports only one Master Node and one or more Workers Node.
* There are 2 Scripts, one to be used to install Kubernetes on the Master Node and the Other is to Install Kubernetes on the Worker Node



'''
curl https://raw.githubusercontent.com/tahershaker/Kubernetes-BareMetal-Install/main/MasterNodeInstall.sh | bash
'''


'''
curl https://raw.githubusercontent.com/tahershaker/Kubernetes-BareMetal-Install/main/WorkerNodeInstall.sh | bash
'''
