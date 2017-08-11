#!/bin/bash -e
cd "$general/dotfiles"
./install.sh

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cd ~/.vim/bundle/YouCompleteMe/
python install.py
