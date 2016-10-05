#---------------------------------------------------------
#Convert to ISO to IMG
ubuntuISO=~/Downloads/ubuntu-gnome-15.04-desktop-amd64.iso
ubuntuIMG=~/Downloads/ubuntu-gnome-15.04-desktop-amd64.img
hdiutil convert -format UDRW -o $ubuntuIMG $ubuntuISO

#list devices
diskutil list

#unmount device N
diskutil unmountDisk /dev/diskN
 
#copy img to device N
sudo dd if=$ubuntuIMG of=/dev/rdiskN bs=1m
#--------------------------------------------------------
