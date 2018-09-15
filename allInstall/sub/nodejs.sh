#!/bin/bash -e

# from ppa ubuntu LTS version 8.x
curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh

sudo apt-get install nodejs
