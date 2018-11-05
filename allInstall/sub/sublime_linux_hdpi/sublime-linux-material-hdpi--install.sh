theScriptP="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

materialroot="/home/felidadae/.config/sublime-text-3/Packages/Material Theme/"
material="/home/felidadae/.config/sublime-text-3/Packages/Material Theme/assets"

for idir in "$material"/*; do
	[ -d "$idir" ] || continue
	[ "$idir" != "${material}/commons" ] || continue
	
	cp sublime-linux-material-hdpi.py "$idir"/
	cd "$idir"; python sublime-linux-material-hdpi.py 
	cd "$theScriptP"   	
done

idir="$material"/commons
cp sublime-linux-material-hdpi-commons.py "$idir"/
cd "$idir"; python sublime-linux-material-hdpi-commons.py   
cd "$theScriptP" 

idir="$materialroot"/icons
cp sublime-linux-material-hdpi-icons.py "$idir"/
cd "$idir"; python sublime-linux-material-hdpi-icons.py   
cd "$theScriptP" 