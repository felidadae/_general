#!/bin/bash -e
sudo apt-add-repository ppa:tista/adapta
sudo apt update && sudo apt install -y adapta-gtk-theme

mkdir -p ~/.themes
cp -r /usr/share/themes/Adapta-Nokto ~/.themes/Adapta-Nokto-My
cd ~/.themes/Adapta-Nokto-My/gnome-shell

#apply path
perl -i -pe 'if (/^stage/) {s/font-family:.*?;/font-family: Ubuntu Condensed;/g;}' gnome-shell.css 
perl -i -pe 'if (/^stage/) {s/font-size:.*?;/font-size: 11pt;/g;}' gnome-shell.css 
