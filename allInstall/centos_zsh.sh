#!/bin/bash -ex

# works for centos 7.5
yum install -y sudo
sudo yum -y install epel-release
sudo yum -y install zsh git vim
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
echo "# Removing automatically created zshrc"
rm -rf ~/.zshrc

cd ~; mkdir -p Programming; cd Programming;
git clone https://github.com/felidadae/_general.git
mv _general _General
cd _General
cd dotfiles
mkdir ~/.vim
bash install.sh
perl -i -pe 's/ZSH_THEME=.*/ZSH_THEME="blinks"/' ~/.zshrc
cd ..
