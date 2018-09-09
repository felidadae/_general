#!/bin/bash -e
dotfiles_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
function create_link_long {
	# @Description
	#	Create symbolic link of file 
	# @Doc
	#   source <- which file to link from e.g. $dotfiles_dir/vim/vimrc
	#   target <- full path to target symbolic link, e.g. ~/.vimrc
	#	name   <- description of file, to print to user
	local source=${1}
	local target=${2}
	local name=${3}

	echo "Creating symbolic for $name."
	sudo rm -f $target
	sudo ln -s "$source" "$target"
}
function create_link {
	local source=${1}
	local target=${2}
	
	create_link_long "$dotfiles_dir/$source" "$target" "$(basename "$source")"
}
function add_dot_file { 
	# @Description add new dot file to _general repository
	# @Note: not tested yet
	local name=${1}

	cp "$name" "$dotfiles_dir/__user_dir_level__/$name" 
	echo 'create_link_long "$dotfiles_dir"/__user_dir_level__/'"$1" '~/.'"${1} $1" >> "$dotfiles_dir"/install.sh;
	cd "$dotfiles_dir" 
	bash install.sh
	echo "[Success] Finished."
}


for f in $dotfiles_dir/__user_dir_level__/*; do
	[ ! -e "$f" ] && continue
	create_link_long "$f" ~/.$(basename $f) $(basename $f)
done
mkdir -p ~/.oh-my-zsh/themes; create_link zsh/felidadae.zsh-theme ~/.oh-my-zsh/themes/felidadae.zsh-theme
create_link vim/vimrc ~/.vimrc
create_link vim/snippets ~/.vim/felidadae_snippets
create_link vim/vimrc_splitted ~/.vim/vimrc_splitted
create_link vim/syntax ~/.vim/syntax
create_link vim/ftdetect ~/.vim/ftdetect
mkdir -p ~/.config/matplotlib; create_link matplotlib/matplotlibrc  ~/.config/matplotlib/matplotlibrc
create_link tmux/tmux.conf ~/.tmux.conf
create_link perl/perldb ~/.perldb

# ipdb

# ranger
