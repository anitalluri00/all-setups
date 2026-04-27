#!/bin/bash

# Update system
sudo apt update -y
sudo apt upgrade -y

# Install Git, Maven, Tree
sudo apt install -y git maven tree

# Install Java 17 & Java 21 (Required for Jenkins & Maven)
sudo apt install -y openjdk-17-jdk openjdk-21-jdk

# Set Java 17 as default (optional - you can change to 21 if needed)
sudo update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java

# Install Jenkins
# Add Jenkins repository and key
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update and install Jenkins
sudo apt update -y
sudo apt install -y jenkins

# Start and enable Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins

# Print initial admin password
echo "========================================="
echo "Jenkins initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "========================================="
