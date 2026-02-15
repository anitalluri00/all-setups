#!/bin/bash

# Step-1:AWS + EKSCTL + KUBECTL SETUP
set -e
echo "Updating system..."
sudo dnf update -y
echo "Installing dependencies..."
sudo dnf install -y unzip curl tar git
sudo dnf clean all
sudo rm -rf /var/cache/dnf
sudo dnf update -y --allowerasing

# Step-2:Install AWS CLI
if ! command -v aws &> /dev/null
then
  echo "Installing AWS CLI..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
fi
echo "Run aws configure manually after script if not configured."

# Step-3:Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/v1.32.0/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client

# step-3:Install eksctl
echo "Installing eksctl..."
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" \
| tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# Step-4:CREATE EKS CLUSTER
echo "Creating EKS cluster..."
eksctl create cluster \
  --name=kscluster \
  --region=us-east-1 \
  --zones=us-east-1a,us-east-1b \
  --without-nodegroup

# Step-5:Associate IAM OIDC Provider
eksctl utils associate-iam-oidc-provider \
  --cluster kscluster \
  --region us-east-1 \
  --approve

# Step-6:Create Nodegroup
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
  --ssh-public-key=ksaws \
  --managed \
  --asg-access \
  --external-dns-access \
  --full-ecr-access \
  --alb-ingress-access \
  --appmesh-access
echo "EKS Setup Completed!"
