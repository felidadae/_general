cd /media/felidadae/EXTERNDISC/Backups

#all my data
rsync --delete --update -av --exclude 'felidadae/*Android*' --exclude 'felidadae/.*' ~ .

#gnome shell extensions
rsync --delete --update -av ~/.local/share/gnome-shell/extensions .

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$script_path"
today=`date +%Y%m%d--%H%M`
echo "[Success][$today]" >> backup_logs
