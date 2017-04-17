#
#	@NOTE
#		That script may delete existing snippets from
#		~/.vim/felidadae_snippets
#

python ./convertToVimUltiSnips.py 

cd .result 
for i in *; do
	target=~/.vim/felidadae_snippets/$i
	[[ -d "$target" ]] && rm -r "$target"
	cp -r $i ~/.vim/felidadae_snippets/
done
