#!/bin/bash -e
general=~/Programming/_General
if [[ ! -d $general ]]; then
	mkdir -p ~/Programming
	cd ~/Programming
	sudo apt-get install git
	git clone https://github.com/felidadae/_general.git
	mv _general _General

	father=$general/shellProfile/AllFatherOfAllSons.sh
	source $father
	
	mkdir -p $labs
	mkdir -p $_sources 
fi
cd "$general/allInstall"; ./all_install.sh
