general=~/Programming/_General
if [[ ! -d $general ]]; then
	father=$general/bashProfile/AllFatherOfAllSons.sh
	sudo apt-get install git
	echo -e "\n\nsource $father" >> ~/.bashrc
	cd ~
	mkdir Programming
	cd Programming
	git clone https://bitbucket.org/felidadae/my-general
	mv my-general _General
	source $father

	mkdir $labs
	mkdir $playground
	mkdir $_sources 
fi

