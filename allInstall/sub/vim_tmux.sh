#!/bin/bash -e
if [[ "$(which vim)" == "" ]]; then
	./vim_from_source.sh
fi
if [[ "$(which tmux)" == "" ]]; then
	./tmux_from_source.sh
	echo "[Remember] run Prefix+I in tmux session to install tmux plugins"; sleep 1
fi
[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
[ ! -d ~/.vim/bundle/Vundle.vim ] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall
sudo apt install -y exuberant-ctags
sudo apt-get install -y xclip #get copy to x11 clipboard in vi copy mode;
sudo pip install git+git://github.com/Lokaltog/powerline #powerline for many
echo "[Remember] Install nerd fonts from fonts \$general/dir;"; sleep 3
#@vim @tmux

./install_youcompleteme.sh
