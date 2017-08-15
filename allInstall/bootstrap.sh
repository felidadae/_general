#!/bin/bash -e
export general=~/Programming/_General
export father=$general/shellProfile/AllFatherOfAllSons.sh

if [[ ! -d $general ]]; then
	mkdir -p ~/Programming
	cd ~/Programming
	sudo apt-get install -y git
	git clone https://github.com/felidadae/_general.git
	mv _general _General
fi
__MY_SHELL__=bash
source $father 
mkdir -p $labs
mkdir -p $_sources 
cd "$general/allInstall"
source all_install.sh
