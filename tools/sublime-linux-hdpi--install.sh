sodadark='/home/felidadae/.config/sublime-text-3/Packages/Theme - Soda/Soda Dark'
sodalight='/home/felidadae/.config/sublime-text-3/Packages/Theme - Soda/Soda Light'

cp "$general"/tools/sublime-linux-hdpi.py "$sodadark"/
cp "$general"/tools/sublime-linux-hdpi.py "$sodalight"/

cd "$sodadark"
python sublime-linux-hdpi.py

cd "$sodalight"
python sublime-linux-hdpi.py