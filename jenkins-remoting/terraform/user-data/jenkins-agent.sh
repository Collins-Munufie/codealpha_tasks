#!/bin/bash
set -e

# Update packages
sudo apt-get update -y

# Install Java and utilities
sudo apt-get install -y openjdk-17-jdk wget git curl unzip

# Create Jenkins agent working directory
sudo mkdir -p /home/ubuntu/jenkins-agent

# Set ownership
sudo chown -R ubuntu:ubuntu /home/ubuntu/jenkins-agent

echo "Jenkins agent bootstrap completed"