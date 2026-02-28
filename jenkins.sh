#!/bin/bash

# Update system
sudo dnf update -y

# Install Git
sudo dnf install git maven tree -y

# Install Java 17 & java 21 (Which are Required for Jenkins & Maven)
sudo dnf install -y java-17-amazon-corretto-devel
sudo dnf install java-21-amazon-corretto -y
sudo alternatives --config java

# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo dnf install -y jenkins

# Start and enable Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
