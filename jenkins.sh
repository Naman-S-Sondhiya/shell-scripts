#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "---- Jenkins Installation Script (Ubuntu/Debian) ----"

# Step 1: Update system packages
echo "Updating package list and upgrading existing packages..."
sudo apt update && sudo apt upgrade -y

# Step 2: Install Java (OpenJDK 21)
echo "Installing OpenJDK 21..."
sudo apt install -y openjdk-21-jdk

# Step 3: Verify Java installation
echo "Verifying Java installation..."
java -version

# Step 4: Add Jenkins GPG key (2023 version)
echo "Adding Jenkins GPG key (2023)..."
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Step 5: Add Jenkins repository with signed-by
echo "Adding Jenkins repository to APT sources..."
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Step 6: Update package list again with new repo
echo "Refreshing package list with Jenkins repository..."
sudo apt update

# Step 7: Install Jenkins
echo "Installing Jenkins..."
sudo apt install -y jenkins

# Step 8: Start and enable Jenkins service
echo "Starting and enabling Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Step 9: (Optional) Configure firewall
if command -v ufw > /dev/null; then
    echo "Configuring UFW to allow Jenkins on port 8080..."
    sudo ufw allow 8080
    sudo ufw reload
else
    echo "UFW firewall not found; skipping firewall configuration."
fi

# Step 10: Check Jenkins status
echo "Checking Jenkins service status..."
sudo systemctl status jenkins | grep -i Active

# Step 11: Output the initial admin password
echo "Fetching Jenkins initial admin password..."
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "---- Jenkins installation completed successfully ----"
echo "Access Jenkins at: http://<your-server-ip>:8080"
echo "Use the above password to unlock Jenkins during first-time setup."
