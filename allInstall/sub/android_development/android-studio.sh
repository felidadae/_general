#!/bin/bash -e
#	Download from http://developer.android.com/sdk/index.html and put into
#	~/Downloads

cd ~/Downloads
sudo apt-get install -y unzip
unzip android-studio-ide* -d android-studio-ide
mv android-studio-ide/android-studio .
rm -r android-studio-ide
sudo mv android-studio /usr/local/
sudo ln -s /usr/local/android-studio/bin/studio.sh /usr/bin/android-studio
echo "The app is located in /usr/local/android-studio"
read

sudo apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer
