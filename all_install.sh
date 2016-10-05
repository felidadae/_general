#
#	Search for 
#		@Utility
#		@PythonPackages
#

INSTALL_MBPFAN=0
INSTALL_ANDROIDTOOLS=1
INSTALL_GIT_GNOME_KEYRING=1


if [[ $(dpkg-query -W -f='${Status}' git 2>/dev/null | grep -c "ok installed") == 0 ]]; 
then
	sudo apt-get install git
fi

if [[ "$INSTALL_GIT_GNOME_KEYRING" == "1" ]]; then
	sudo apt-get install libgnome-keyring-dev
	cd /usr/share/doc/git/contrib/credential/gnome-keyring
	sudo make
	git config --global credential.helper \
		/usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
fi

if [[ $INSTALL_MBPFAN == 1 ]]; then
	cd ~
	mkdir ToolsSources
	cd ToolsSources

	###
	#mbpfan
	###
	git clone https://github.com/dgraziotin/mbpfan
	sudo echo "coretemp" >> /etc/modules
	sudo echo "applesmc" >> /etc/modules
	sudo apt-get install build-essential
	###
	cd mbpfan
	make
	sudo make install
	###
	sudo cp mbpfan.upstart /etc/init/mbpfan.conf
	sudo start mbpfan
fi

if [[ ! -d ~/Programming/_General ]]; then
	###
	#my general
	###
	cd ~
	mkdir Programming
	cd Programming
	mkdir Labs
	mkdir Playground
	git clone https://bitbucket.org/felidadae/my-general
	mv my-general _General
	##bash profile
	echo -e "\n\nsource ~/Programming/_General/bashProfile/my_main.sh" >> ~/.bashrc
	source ~/.bashrc
fi

###
#Install software main software
###

#Sublime
if [[ "$(which subl)" == "" ]]; then
	sudo add-apt-repository ppa:webupd8team/sublime-text-3
	sudo apt-get update
	sudo apt-get install sublime-text-installer
fi

###Vim
if [[ "$(which vim)" == "" ]]; then
	sudo apt-get install vim
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

cd ~/Programming/_General
bash install.sh
vim +PluginInstall +qall

##
# @Utility
##
sudo apt-get install openssh-server
sudo apt-get install htop
sudo apt-get install tree
sudo apt-get install python-pygments
sudo pip install powerline-status
sudo apt-get install xbacklight
sudo apt-get install xclip
sudo apt-get install texlive-full


###Android-studio
#
#	Download from http://developer.android.com/sdk/index.html and put into
#	~/Downloads
#
if [[ "$(which android-studio)" == "" ]] && [[ "$INSTALL_ANDROIDTOOLS" == 1 ]]; then
	#statements
	cd ~/Downloads
	sudo apt-get install unzip
	unzip android-studio-ide* -d android-studio-ide
	mv android-studio-ide/android-studio .
	rm -r android-studio-ide
	sudo mv android-studio /usr/local/
	sudo ln -s /usr/local/android-studio/bin/studio.sh /usr/bin/android-studio
	cd ~; cd .AndroidStudio*; #echo "hidpi.system.dpi.override 130" > idea.properties

	sudo apt-get install lib32z1 lib32ncurses5 lib32stdc++6
	sudo add-apt-repository ppa:webupd8team/java
	sudo apt-get update
	sudo apt-get install oracle-java8-installer
fi


###xflux
if [ "$(which redshift)" == "" ]; then
	sudo apt install redshift
fi


###ppub READER
if [ "$(which redshift)" == "" ]; then
	cd ~/Downloads
	git clone https://github.com/sakisds/pPub.git
	cd pPub
	sudo make install
	sudo apt-get install gir1.2-webkit-3.0
fi

### tlp to keep cold computer
sudo apt install tlp
sudo apt install tlp-rdw





###
# @PythonPackages
###
if [ "$OS_KERNEL__" == "linux" ]; 
then
	sudo apt-get install python-pip python-dev build-essential 
	sudo apt install python3-pip
	sudo apt-get install ipython
	sudo apt-get install libfreetype6-dev libxft-dev
	sudo apt-get install python-matplotlib
fi

if [ "$OS_KERNEL__" == "darwin" ]; 
then
	sudo easy_install pip
	sudo pip install ipython
	sudo pip install ipdb
fi

sudo pip install --upgrade pip
sudo pip install numpy scipy 
sudo pip install matplotlib

###
# @RPackages
###


###
# @C/C++ libraries, tools
###
sudo apt install cmake



###
#	For VIM, tmux
###
sudo apt install exuberant-ctags
sudo apt-get install xclip #get copy to x11 clipboard in vi copy mode;
