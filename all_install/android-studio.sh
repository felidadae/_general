if [[ "$(which android-studio)" == "" ]] && [[ "$INSTALL_ANDROIDTOOLS" == 1 ]]; then
	#
	#	Download from http://developer.android.com/sdk/index.html and put into
	#	~/Downloads
	#
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
