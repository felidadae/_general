#!/bin/bash -e
echo "Print install tmux 2.3 from source code"

echo "Install dependency libevent 2.x"
sudo apt-get install -y libevent-dev automake

echo "Cloning tmux github repo"
cd $_sources
git clone https://github.com/tmux/tmux.git
cd tmux/
echo "Checkout to 2.3 version"
git checkout 2.3
sh autogen.sh 

echo "Install system wide using checkinstall."
sudo apt-get install -y checkinstall
./configure && make && sudo checkinstall
