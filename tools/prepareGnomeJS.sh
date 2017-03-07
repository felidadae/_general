#! /bin/sh

gs=/usr/lib/gnome-shell/libgnome-shell.so

mkdir $HOME/gnome-shell-js
cd $HOME/gnome-shell-js

mkdir -p ui/components ui/status misc perf extensionPrefs gdm

for r in `gresource list $gs`; do
  gresource extract $gs $r > ${r/#\/org\/gnome\/shell/.}
done
