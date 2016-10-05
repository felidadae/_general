for i in *; do
	[[ ! -e "$i" ]] && continue
	[[ "$i" == "allBash.sh" ]] && continue
	[[ $i == *"__test"* ]] && continue
	source "$i"
done

for ifile in ~/*; do
	[ -e "$ifile" ] || continue
	
done

