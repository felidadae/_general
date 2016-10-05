if [ "$OS_KERNEL__" == "linux" ]; 
then
	sudo apt-get install python-pip python-dev build-essential 
	sudo apt-get install ipython
	sudo apt-get install libfreetype6-dev libxft-dev
fi

if [ "$OS_KERNEL__" == "darwin" ]; 
then
	sudo easy_install pip
	sudo pip install ipython
fi

sudo pip install --upgrade pip
sudo pip install numpy scipy 
sudo pip install matplotlib