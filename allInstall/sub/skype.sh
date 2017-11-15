#!/bin/bash -e
[ ! -e ~/Downloads/skypeforlinux-64.deb ] && curl https://repo.skype.com/latest/skypeforlinux-64.deb > ~/Download/skypeforlinux-64.deb
sudo dpkg -i ~/Downloads/skypeforlinux-64.deb
sudo apt-get install -f
echo "Skype installed on the system."
# rm ~/Downloads/skypeforlinux-64.deb
