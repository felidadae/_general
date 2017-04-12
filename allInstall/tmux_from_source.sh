"Print install tmux 2.3 from source code"

"Install dependency libevent 2.x"
sudo apt install libevent-dev

"Cloning tmux github repo"
git clone https://github.com/tmux/tmux.git
cd tmux/
"Checkout to 2.3 version"
git checkout 2.3
sh autogen.sh 

print "Install system wide using checkinstall."
 ./configure && make && sudo checkinstall
