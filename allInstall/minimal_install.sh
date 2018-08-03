#!/bin/bash -e
cd ../dotfiles
./install.sh

echo "Install vim and tmux."
echo "Remember to change prefix for tmux if the server will be used only by sshing into it"
read

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cd ~/.vim/bundle/YouCompleteMe/
python install.py
