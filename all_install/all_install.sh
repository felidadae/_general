source config.sh
source head.sh

sudo apt-get install python-pip
sudo apt-get install python3-pip
sudo apt install cmake
sudo apt install tlp
sudo apt install tlp-rdw
sudo apt-get install openssh-server
sudo apt-get install htop
sudo apt-get install tree
sudo apt-get install python-pygments
sudo pip install powerline-status
sudo apt-get install xbacklight
sudo apt-get install xclip
sudo apt-get install lynx
sudo apt install redshift
[[ $INSTALL_TEX_FULL == "1" ]] && sudo apt-get install texlive-full
if [[ "$INSTALL_GIT_GNOME_KEYRING" == "1" ]]; then
	sudo apt-get install libgnome-keyring-dev
	cd /usr/share/doc/git/contrib/credential/gnome-keyring
	sudo make
	git config --global credential.helper \
		/usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
fi
wget git.io/trans
chmod +x ./trans
sudo mv trans /usr/local/bin/
sudo apt-get install autokey-gtk
if [ "$(which ppub)" == "" ]; then
	cd ~/Downloads
	git clone https://github.com/sakisds/pPub.git
	cd pPub
	sudo make install
	sudo apt-get install gir1.2-webkit-3.0
fi
if [[ $INSTALL_SUBLIMETEXT == 1 ]]; then
	sudo add-apt-repository ppa:webupd8team/sublime-text-3
	sudo apt-get update
	sudo apt-get install sublime-text-installer
fi
#@Main_


#PRE
source python.sh
source c++.sh
source vim_tmux.sh
if [[ "$(which android-studio)" == "" ]] && [[ "$INSTALL_ANDROIDTOOLS" == 1 ]]; then
	source android-studio.sh
fi

cd ~/Programming/_General
bash install.sh

#POST
source vim_tmux__postconf.sh
