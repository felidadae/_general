cd ~
mkdir .themes
cp -r /usr/share/themes/Adapta-Nokto .themes/
mv .themes/Adapta-Nokto .themes/Adapta-Nokto-My
cd .themes/Adapta-Nokto-My/gnome-shell

rm ~/.themes/Adapta-Nokto-My/gtk-3.0
cp -r /usr/share/themes/Adapta/gtk-3.0 ~/.themes/Adapta-Nokto-My/ 
