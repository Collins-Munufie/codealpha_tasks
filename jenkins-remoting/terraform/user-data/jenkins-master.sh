#!/bin/bash
set -e

# Update packages
sudo apt-get update -y

# Install Java and utilities
sudo apt-get install -y openjdk-17-jdk wget git curl gnupg

# Add Jenkins repository key
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list
sudo apt-get update -y

# Install Jenkins
sudo apt-get install -y jenkins

# Enable Jenkins service
sudo systemctl enable jenkins

# Start Jenkins
sudo systemctl start jenkins

echo "Jenkins master installation completed"