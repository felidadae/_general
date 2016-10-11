DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function createSymbolicLink {
	local source=${1}
	local target=${2}
	local name=${3}

	echo "Creating symbolic for $name."
	if [ -e "$target" ]; then
		echo -e "\t$target\n\t\tfile/dir exists already; delete it first;"
	else
		ln -s "$source" "$target"
	fi
}

createSymbolicLink "$DIR"/vim/vimrc ~/.vimrc vimrc
createSymbolicLink "$DIR"/inputrc ~/.inputrc inputrc
createSymbolicLink "$DIR"/vim/snippets ~/.vim/felidadae_snippets vim_snippets 
createSymbolicLink "$DIR"/matplotlib/matplotlibrc  ~/.config/matplotlib/matplotlibrc  matplotlibrc
createSymbolicLink "$DIR"/tmux/tmux.conf ~/.tmux.conf tmux.conf
createSymbolicLink "$DIR"/perl/perldb ~/.perldb perldb

#sublime
echo "Creating symbolic for sublime-text3."
for f in sublime-text/*; do 
	[ -e "$f" ] || continue

	source="$DIR/$f"
	target="$sublime3_my/$(echo $(basename "$f"))"
	
	if [ -e  "$target" ]; then
		echo -e "\t$target\n\t\tfile/dir exists already; delete it first;"
	else
		ln -s   "$source"   "$target"
	fi
done
