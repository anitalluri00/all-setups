#!/bin/bash

# ==================================
# AWS EKS Setup Script (Amazon Linux 2023)
# kernel-6.1 / kernel-6.12
# ==================================

set -e

echo "Updating system..."
sudo dnf update -y --allowerasing --best --skip-broken

echo "Installing dependencies..."
sudo dnf install -y unzip curl tar git --allowerasing --best --skip-broken

# ----------------------------------
# Install AWS CLI v2 (if missing)
# ----------------------------------
if ! command -v aws &> /dev/null
then
  echo "Installing AWS CLI..."
  curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip -oq awscliv2.zip
  sudo ./aws/install
fi

echo ">>> Run 'aws configure' manually if not configured"

# ----------------------------------
# Install kubectl v1.32.0
# ----------------------------------
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/v1.32.0/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv -f kubectl /usr/local/bin/

kubectl version --client

# ----------------------------------
# Install eksctl (latest)
# ----------------------------------
echo "Installing eksctl..."
curl --silent --location \
"https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" \
| tar xz -C /tmp

sudo mv -f /tmp/eksctl /usr/local/bin

eksctl version

# ----------------------------------
# Create EKS Cluster
# ----------------------------------
eksctl create cluster \
  --name=kscluster \
  --region=us-east-1 \
  --zones=us-east-1a,us-east-1b \
  --without-nodegroup

# ----------------------------------
# Install Amazon EKS Pod Identity Agent Add-on
# ----------------------------------
eksctl create addon \
  --cluster kscluster \
  --region us-east-1 \
  --name eks-pod-identity-agent

# ----------------------------------
# Associate IAM OIDC Provider
# ----------------------------------
eksctl utils associate-iam-oidc-provider \
  --cluster kscluster \
  --region us-east-1 \
  --approve

# ----------------------------------
# Create Nodegroup
# ----------------------------------
eksctl create nodegroup \
  --cluster=kscluster \
  --region=us-east-1 \
  --name=kseks-node-group \
  --node-type=t3.medium \
  --nodes=2 \
  --nodes-min=2 \
  --nodes-max=3 \
  --node-volume-size=20 \
  --ssh-access \
  --ssh-public-key=All \
  --managed \
  --asg-access \
  --external-dns-access \
  --full-ecr-access \
  --alb-ingress-access \
  --appmesh-access

echo "EKS Setup Completed!"
