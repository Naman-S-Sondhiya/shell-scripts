#!/bin/bash

# Exit on any error
set -e

echo "---- Jenkins Installation Script (Ubuntu/Debian) ----"

# Update system
echo "Updating package list..."
sudo apt update

# Install Java (Jenkins dependency)
echo "Installing Java (OpenJDK 17)..."
sudo apt install -y openjdk-17-jdk

# Verify Java installation
java -version

# Add Jenkins repository key
echo "Adding Jenkins repository key..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository
echo "Adding Jenkins package repository..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list again
echo "Updating package list with Jenkins repo..."
sudo apt update

# Install Jenkins
echo "Installing Jenkins..."
sudo apt install -y jenkins

# Start and enable Jenkins service
echo "Starting and enabling Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Optional: Configure firewall
if command -v ufw > /dev/null; then
    echo "Configuring UFW to allow Jenkins on port 8080..."
    sudo ufw allow 8080
    sudo ufw reload
fi

# Display Jenkins status
echo "Jenkins service status:"
sudo systemctl status jenkins | grep Active

# Output initial admin password
echo "Fetching initial admin password..."
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "---- Jenkins installation completed successfully ----"
echo "Access Jenkins at: http://<your-server-ip>:8080"
