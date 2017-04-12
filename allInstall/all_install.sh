source __config.sh
source __my_general_bootstrap.sh

sudo apt install cmake
sudo apt install tlp
sudo apt install tlp-rdw
sudo apt-get install openssh-server
sudo apt-get install htop
sudo apt-get install tree
sudo apt-get install python-pygments
sudo apt-get install xbacklight
sudo apt-get install lynx
sudo apt install redshift
sudo apt-get install autokey-gtk
bash trans.sh
[ "$INSTALL_TEX_FULL" == "1" ] && sudo apt-get install texlive-full
[ "$INSTALL_GIT_GNOME_KEYRING" == "1" ] && bash ./gnome_keyring.sh
[ "$INSTALL_SUBLIMETEXT" == 1 ] && bash ./sublime3.sh

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
