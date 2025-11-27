#!/bin/bash
# Script to install kubectl on an Ubuntu instance

echo "Updating package list..."
sudo apt update -y

echo "Installing curl..."
sudo apt install -y curl

# Detect architecture
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then
    ARCH="amd64"
elif [[ "$ARCH" == "aarch64" ]]; then
    ARCH="arm64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

echo "Downloading latest stable kubectl for $ARCH..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$ARCH/kubectl"

echo "Installing kubectl..."
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "Cleaning up..."
rm -f kubectl

echo "Verifying kubectl installation..."
kubectl version --client --short

echo "kubectl installation completed successfully!"
