#!/bin/bash

echo
if [ "${USER}" = "root" ] ; then
   echo -e "$(tput setaf 1)!! Do not use sudo for installation$(tput sgr0)"
   exit 0 ; fi
duser="${USER}" 

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

# Add current user to Docker group
# sudo usermod -aG docker $duser
sudo gpasswd -a $duser docker

echo && echo "$(tput setaf 6)!! Docker installation finished. !!$(tput sgr0)"
echo && echo Type below command to check docker status:
echo "$(tput setaf 6)sudo systemctl status docker$(tput sgr0)"
echo && echo Type below commands to check user group:
echo "$(tput setaf 6)su - $duser"
echo "id -nG"
echo "exit$(tput sgr0)"
echo "## re-login to activate membership in docker group ##"
echo 
