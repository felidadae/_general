#!/bin/bash -e
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
