#!/bin/bash

# Update System Packages
echo "Updating system..."
sudo dnf update -y
# Install Docker
echo "Installing Docker..."
sudo dnf install -y docker
echo "Starting Docker service..."
sudo systemctl start docker
echo "Enabling Docker service..."
sudo systemctl enable docker
echo "Adding ec2-user to docker group..."
sudo usermod -aG docker ec2-user
sudo systemctl daemon-reload
sudo systemctl restart docker
docker --version
