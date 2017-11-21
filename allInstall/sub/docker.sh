#!/bin/bash -e
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce

echo "Check if right. Type <Enter> to continue"
read
sudo apt-get install -y docker-ce
sudo usermod -aG docker ${USER}
