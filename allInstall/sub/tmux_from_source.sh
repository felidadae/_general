#!/bin/bash -e
echo "Print install tmux newest from source code"

echo "Install dependency libevent 2.x"
sudo apt-get install -y libevent-dev automake

echo "Cloning tmux github repo"
cd $_sources
[ ! -d tmux ] && git clone https://github.com/tmux/tmux.git
cd tmux/
git fetch
git pull origin master
git checkout master
echo "Install to location $(pwd)"
sh autogen.sh 

echo "Install system wide using checkinstall."
sudo apt-get install -y checkinstall
./configure && make 
sudo checkinstall -D -y \
  --install=yes \
  --fstrans=no \
  --reset-uids=yes \
  --pkgname=tmux \
  --pkgversion="$(git tag | tail -1)" \
  --maintainer="felidadae@gmail.com"
