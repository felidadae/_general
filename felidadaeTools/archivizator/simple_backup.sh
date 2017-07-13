cd /media/felidadae/EXTERNDISC/Backups
rsync --update -av --exclude 'felidadae/*Android*' --exclude 'felidadae/.*' ~ .

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$script_path"
today=`date +%Y%m%d--%H%M`
echo "[Success][$today]" >> backup_logs
