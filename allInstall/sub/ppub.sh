#!/bin/bash -e
cd ~/Downloads
git clone https://github.com/sakisds/pPub.git
cd pPub
sudo make install
sudo apt-get install -y gir1.2-webkit-3.0
