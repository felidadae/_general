
cd $general
for installf in $(find . -maxdepth 2 -mindepth 2 -name install.sh); do
	cd "$general"
	cd $(dirname $installf)
	bash install.sh
done
