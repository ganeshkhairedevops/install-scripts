#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting Ansible installation on Ubuntu..."

# 1. Update the system's package list
echo "Updating system packages..."
sudo apt update -y

# 2. Install software-properties-common to manage PPAs (Personal Package Archives)
echo "Installing prerequisites for managing PPAs..."
sudo apt install software-properties-common -y

# 3. Add the official Ansible PPA to get a potentially newer version than the default Ubuntu repositories
echo "Adding the official Ansible PPA..."
sudo add-apt-repository --yes --update ppa:ansible/ansible

# 4. Install Ansible
echo "Installing Ansible..."
sudo apt install ansible -y

# 5. Verify the installation
echo "Verifying Ansible installation..."
ansible --version

echo "Ansible has been successfully installed."
