#sublime
echo "Creating symbolic for sublime-text3."
for f in sublime-text/*; do 
	[ -e "$f" ] || continue

	source="$dotfiles_dir/$f"
	target="$sublime3_my/$(echo $(basename "$f"))"
	
	if [ -e  "$target" ]; then
		echo -e "\t$target\n\t\tfile/dir exists already; delete it first;"
	else
		ln -s   "$source"   "$target"
	fi
done
