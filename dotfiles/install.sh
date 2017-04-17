export dotfiles_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function createSymbolicLink {
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
	rm $target
	if [ -e "$target" ]; then
		echo -e "\t$target\n\t\tfile/dir exists already; delete it first;"
	else
		ln -s "$source" "$target"
	fi
}
function addDotfile { 
	# @Description add new dot file to _general repository
	# @Note: not tested yet
	local name=${1}

	cp "$name" "$dotfiles_dir/__user_dir_level__/$name" 
	echo 'createSymbolicLink "$dotfiles_dir"/__user_dir_level__/'"$1" '~/.'"${1} $1" >> "$dotfiles_dir"/install.sh; }
	cd "$dotfiles_dir" 
	bash install.sh
	echo "[Success] Finished."
}


for f in $dotfiles_dir/__user_dir_level__/*; do
	[ ! -e "$f" ] && continue
	createSymbolicLink "$f" ~/.$(basename $f) $(basename $f)
done

createSymbolicLink "$dotfiles_dir"/zsh/felidadae.zsh-theme ~/.oh-my-zsh/themes/felidadae.zsh-theme
createSymbolicLink "$dotfiles_dir"/vim/vimrc ~/.vimrc vimrc
createSymbolicLink "$dotfiles_dir"/vim/snippets ~/.vim/felidadae_snippets vim_snippets 
createSymbolicLink "$dotfiles_dir"/autokey/data ~/.config/autokey/data autokey 
createSymbolicLink "$dotfiles_dir"/matplotlib/matplotlibrc  ~/.config/matplotlib/matplotlibrc  matplotlibrc
createSymbolicLink "$dotfiles_dir"/tmux/tmux.conf ~/.tmux.conf tmux.conf
createSymbolicLink "$dotfiles_dir"/perl/perldb ~/.perldb perldb
