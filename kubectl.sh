#!/bin/bash
# Script to install kubectl on an Ubuntu x86_64 instance

echo "Updating package list..."
sudo apt update -y

echo "Installing curl..."
sudo apt install -y curl

echo "Downloading latest stable kubectl for amd64..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

echo "Installing kubectl..."
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "Cleaning up..."
rm -f kubectl

echo "Verifying kubectl installation..."
kubectl version --client --short

echo "kubectl installation completed successfully!"
