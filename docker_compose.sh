#!/bin/bash

# Exit on any error
set -e

echo "---- Docker + Docker Compose Installation Script (Ubuntu/Debian) ----"

# Update package index
echo "Updating package list..."
sudo apt update

# Install prerequisite packages
echo "Installing prerequisites..."
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common

# Add Docker’s official GPG key
echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update again after adding Docker repo
echo "Updating package list with Docker repo..."
sudo apt update

# Install Docker Engine and CLI
echo "Installing Docker Engine..."
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Enable and start Docker service
echo "Enabling and starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

# Add current user to Docker group
if ! groups $USER | grep -q '\bdocker\b'; then
    echo "Adding user '$USER' to docker group..."
    sudo usermod -aG docker $USER
    echo "You need to log out and log back in (or run: newgrp docker) for Docker group changes to apply."
fi

# Install Docker Compose (standalone plugin)
DOCKER_COMPOSE_VERSION="v2.24.1"

echo "Installing Docker Compose version $DOCKER_COMPOSE_VERSION..."
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

# Make it executable
sudo chmod +x /usr/local/bin/docker-compose

# Verify installations
echo "Docker version:"
docker --version

echo "Docker Compose version:"
docker-compose --version

echo "---- Docker and Docker Compose installation complete ----"
