# Add GPG key for the official Docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update package database with Docker packages from new repo
sudo apt-get update

# Verify Docker repo is used for install instead of Ubuntu 16.04 repo
apt-cache policy docker-ce

# Install Docker
echo && echo
echo "$(tput setaf 6) !! Docker installation will start in 10 seconds !! $(tput sgr0)"
sleep 10s
sudo apt-get install -y docker-ce

# Add user to Docker group
sudo usermod -aG docker ${USER}
echo && echo ${USER} is now added to below groups
id -nG

echo
echo !! Docker installation finished. !!
echo Enter below command to check Docker status
echo "$(tput setaf 6)sudo systemctl status docker. $(tput sgr0)"
echo

