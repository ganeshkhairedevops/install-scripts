#!/bin/bash

echo "Downloading Helm installation script..."
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

echo "Making the script executable..."
chmod 700 get_helm.sh

echo "Running the Helm installation script..."
./get_helm.sh

echo "Cleaning up..."
rm get_helm.sh

echo "Verifying Helm installation..."
helm version
