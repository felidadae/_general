#!/bin/bash -e
cd $_sources


export IF_NO_X11=0

[[ ! -d vim ]] && git clone https://github.com/vim/vim.git 
if [ $IF_NO_X11 == 0 ]; then	 
	sudo apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
		libgtk-3-dev \
		libatk1.0-dev libbonoboui2-dev \
		libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
		python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git
else
	sudo apt-get install -y libncurses5-dev \
		libatk1.0-dev libbonoboui2-dev \
		libxpm-dev libxt-dev python-dev \
		python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git	
fi

sudo apt-get -y remove vim vim-runtime gvim
cd vim
sudo dpkg -r vim
sudo make uninstall
make distclean

./configure --with-features=huge \
			--enable-multibyte \
			--enable-rubyinterp=yes \
			--enable-python3interp=yes \
			--with-python3-config-dir=$(python3-config --configdir) \
			--enable-perlinterp=yes \
			--enable-luainterp=yes \
			--enable-gui=gtk3 \
			--enable-cscope \
			--prefix=/usr/local
make

echo "Install system wide using checkinstall."
sudo apt-get install -y checkinstall
sudo checkinstall -D -y \
  --install=yes \
  --fstrans=no \
  --reset-uids=yes \
  --pkgname=vim\
  --pkgversion=8.2 \
  --maintainer="felidadae@gmail.com"
