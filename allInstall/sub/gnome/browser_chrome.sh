#!/bin/bash -e

function get_chromium {
	sudo apt-get install chromium-browser
}
function get_chrome_beta {
	# https://www.ubuntuupdates.org/ppa/google_chrome	
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
	sudo apt-get update
	sudo apt-get install google-chrome-beta
}

echo "Installing google chrome beta."
get_chrome_beta
sudo apt-get install chrome-gnome-shell
