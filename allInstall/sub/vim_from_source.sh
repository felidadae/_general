#!/bin/bash -e
cd $_sources

export IF_NO_X11=0

[[ ! -d vim ]] && git clone https://github.com/vim/vim.git 
if [ $IF_NO_X11 == 0 ]; then
	if [ $OS_VER__ == "17.04" ]; then 
		sudo apt-get install libgtk-3-dev
	else
		sudo apt-get install libgtk3.0-dev
	fi
	sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
		libatk1.0-dev libbonoboui2-dev \
		libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
		python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git
else
	sudo apt-get install libncurses5-dev \
		libatk1.0-dev libbonoboui2-dev \
		libxpm-dev libxt-dev python-dev \
		python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git	
fi

sudo apt-get -y remove vim vim-runtime gvim
cd vim
sudo dpkg -r vim
sudo make uninstall
make distclean
if [ $IF_NO_X11 == 0 ]; then
	./configure --with-features=huge \
				--enable-multibyte \
				--enable-rubyinterp=yes \
				--enable-pythoninterp=yes \
				--with-python-config-dir=/usr/lib/python2.7/config \
				--enable-perlinterp=yes \
				--enable-luainterp=yes \
				--enable-cscope --prefix=/usr \
				--enable-gui=gtk3
				# --enable-python3interp=yes \
				# --with-python3-config-dir=/usr/lib/python3.5/config \
else
	./configure --with-features=huge \
				--enable-multibyte \
				--enable-rubyinterp=yes \
				--enable-pythoninterp=yes \
				--with-python-config-dir=/usr/lib/python2.7/config \
				--enable-perlinterp=yes \
				--enable-luainterp=yes \
				--enable-cscope --prefix=/usr \
				# --enable-python3interp=yes \
				# --with-python3-config-dir=/usr/lib/python3.5/config \
fi
make
sudo checkinstall 
