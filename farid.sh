#!/bin/bash

# Update package index
echo "Updating package index..."
sudo apt-get update

# Install necessary packages
echo "Installing necessary packages..."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Set up the Docker repository
echo "Setting up the Docker repository..."
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update package index again with Docker's repository
echo "Updating package index with Docker's repository..."
sudo apt-get update

# Install Docker Engine
echo "Installing Docker Engine..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start Docker service
echo "Starting Docker service..."
sudo systemctl start docker

# Enable Docker to start on boot
echo "Enabling Docker to start on boot..."
sudo systemctl enable docker

# Verify Docker installation
echo "Verifying Docker installation..."
sudo docker --version

# Optionally, add your user to the 'docker' group
# This allows running Docker commands without 'sudo'
echo "Adding user to the Docker group..."
sudo usermod -aG docker $(whoami)

echo "Docker installation completed successfully!"
