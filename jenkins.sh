#!/usr/bin/env bash
# Jenkins installation on Ubuntu
# Optimized, portable, with error handling

set -euo pipefail   # exit on error, undefined variable, or pipe failure

echo "Updating package list..."
sudo apt update -y

echo "Installing Java (OpenJDK 17)..."
sudo apt install -y fontconfig openjdk-17-jre wget gnupg

echo "Adding Jenkins repository key..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc "https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key"

echo "Adding Jenkins repository..."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating package list with Jenkins repository..."
sudo apt update -y

echo "Installing Jenkins..."
sudo apt install -y jenkins

echo "Enabling and starting Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Waiting 10 seconds for Jenkins to start..."
sleep 10

echo "Checking Jenkins service status..."
sudo systemctl status jenkins --no-pager

echo "Jenkins installation completed successfully!"
echo "You can access Jenkins at http://<your_server_ip>:8080"
