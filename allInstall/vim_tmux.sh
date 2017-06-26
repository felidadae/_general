if [[ "$(which vim)" == "" ]]; then
	source vim_from_source.sh
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
if [[ "$(which tmux)" == "" ]]; then
	source tmux_from_source.sh
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	echo "[Remember] run Prefix+I in tmux session to install tmux plugins"; sleep 1
fi
sudo apt install exuberant-ctags
sudo apt-get install xclip #get copy to x11 clipboard in vi copy mode;
sudo pip install git+git://github.com/Lokaltog/powerline #powerline for many
echo "[Remember] Install nerd fonts from fonts \$general/dir;"; sleep 1
#@vim @tmux
