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

    echo $target
    if [ -e "$target" ]; then
        if [ "$OVERWRITE_DOTFILES" == "true" ]; then
            echo "Deleting file $source as we want to creat symbolic link for target $target"
            sudo rm -f "$target"
            echo "Creating symbolic for $name."
            sudo ln -s "$source" "$target"
        else
            echo "Skipping file $target, as it already exists and OVERWRITE_DOTFILES is not set to >>true<<."
        fi
    else
        echo "Creating symbolic for $name."
        [ ! -d "$source" ] && mkdir -p "$(dirname "$target")"
        sudo ln -s "$source" "$target"
    fi
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



# home dir level
for f in $dotfiles_dir/__user_dir_level__/*; do
	[ ! -e "$f" ] && continue
	create_link_long "$f" ~/.$(basename $f) $(basename $f)
done

# zsh
create_link zsh/felidadae.zsh-theme ~/.oh-my-zsh/themes/felidadae.zsh-theme

# vim
create_link vim/vimrc ~/.vimrc
create_link vim/snippets ~/.vim/felidadae_snippets
create_link vim/vimrc_splitted ~/.vim/vimrc_splitted
create_link vim/syntax ~/.vim/syntax
create_link vim/ftdetect ~/.vim/ftdetect

# matplotlib
create_link matplotlib/matplotlibrc ~/.config/matplotlib/matplotlibrc

# tmux
create_link tmux/tmux.conf ~/.tmux.conf

# perl
create_link perl/perldb ~/.perldb

# ipdb
create_link ipython/ipython_config.py ~/.ipython/profile_default/ipython_config.py
create_link ipython/keybindings.py ~/.ipython/profile_default/startup/keybindings.py

# ranger
create_link ranger/commands.py ~/.config/ranger/commands.py
create_link ranger/scope.sh ~/.config/ranger/scope.sh
create_link ranger/rc.conf ~/.config/ranger/rc.conf
