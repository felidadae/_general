#!/bin/bash -e
sudo apt-get install -y libgnome-keyring-dev
cd /usr/share/doc/git/contrib/credential/gnome-keyring
sudo make
git config --global credential.helper \
	/usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
