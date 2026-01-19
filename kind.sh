#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# 1. Install Docker (if not installed)
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl enable --now docker
fi

# 2. Download and install kind
echo "Downloading kind binary..."
if [ "$(uname -m)" = "x86_64" ]; then
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64
elif [ "$(uname -m)" = "aarch64" ]; then
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-arm64
else
    echo "Unsupported architecture"
    exit 1
fi

# 3. Make executable and move to PATH
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# 4. Verify installation
kind --version
echo "Kind installed successfully!"
