#!/usr/bin/env bash
KUBEVERSION=1.20.4-00

#Install Containerd On Server
#References: https://kubernetes.io/docs/setup/production-environment/container-runtimes/#containerd
#   Load kernel modules and modify system settings as a prerequisites (Overlay - Netfilter - IpForwarding).

cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# Setup required sysctl params, these persist across reboots.
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

#   Install Containerd 

sudo apt-get update && sudo apt-get install -y containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd

#------------------------------------------------------------


#Install Kubeadm and Kubernetes Components using Kubeadm
#References: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
#   Let IPTables to see the bridged traffic.

sudo modprobe br_netfilter
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system

#   Update the apt package index and install packages needed to use the Kubernetes apt repository

sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl

#   Download the Google Cloud public signing key
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

#   Add the Kubernetes apt repository
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

#   Update apt package index, install kubelet, kubeadm and kubectl, and pin their version

sudo apt-get update && sudo apt-get install -y kubelet=${KUBEVERSION} kubeadm=${KUBEVERSION} kubectl=${KUBEVERSION}
sudo apt-mark hold kubelet kubeadm kubectl

#------------------------------------------------------------
