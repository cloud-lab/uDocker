#!/bin/bash

# Add GPG key for the official Docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update package database with Docker packages from new repo
sudo apt-get update

# Verify Docker repo is used for install instead of Ubuntu 16.04 repo
apt-cache policy docker-ce

# Install Docker
echo "$(tput setaf 6)"
echo "!! Docker installation will start in 10 seconds !! $(tput sgr0)"
sleep 10s
echo && sudo apt-get install -y docker-ce

# Add user to Docker group
sudo usermod -aG docker ${USER}

echo && echo "$(tput setaf 6)!! Docker installation finished. !!$(tput sgr0)"
echo && echo Type below command to check docker status:
echo "$(tput setaf 6)sudo systemctl status docker$(tput sgr0)"
echo && echo Type below commands to check user group:
echo "$(tput setaf 6)su - ${USER}"
echo "id -nG"
echo "exit$(tput sgr0)"
echo "## return to non-root user.."
echo 
