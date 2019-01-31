#!/bin/bash -ex

# works for centos 7.5
perl -i -pe 's/ZSH_THEME="felidadae"/ZSH_THEME="blinks"/' ~/.zshrc
rm ~/.vimrc
cd ..
sudo yum -y install zsh git vim curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cd ~; mkdir Programming; cd Programming;
git clone https://github.com/felidadae/_general.git
mv _general _General
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
sudo passwd sbugaj
chsh -s /bin/zsh
