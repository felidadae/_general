general=~/Programming/_General
if [[ ! -d $general ]]; then
	mkdir -p ~/Programming
	cd ~/Programming
	sudo apt-get install git
	git clone https://github.com/felidadae/_general.git
	mv _general _General

	father=$general/bashProfile/AllFatherOfAllSons.sh
	source $father
	
	mkdir -p $labs
	mkdir -p $_sources 
fi
source zsh.sh
source essentials.sh
bash oh_my_zsh.sh
bash $general/dotfiles/install.sh

