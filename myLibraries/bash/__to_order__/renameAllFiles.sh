function renameFiles {
	for ifile in *; do
		fname="${ifile%.*}"
		ext="${ifile##*.}"

		mv "$ifile" "$fname"_common."$ext"  
	done
}