function tmpAdd {
	echo "$1" >> $general/bashProfile/.tmp.sh
}

function book__fluentpython {
	xdg-open "/home/felidadae/Documents/Fluent Python - 1st Edition (2015) (Pdf, Epub & Mobi) Gooner/Fluent Python (2015).pdf"
}

function book__superinteligence {
	xdg-open "/home/felidadae/Documents/Nick Bostrom - Superintelligence. Paths, Dangers, Strategies [2014][A]/Nick Bostrom - Superintelligence [2014][A].pdf"
}

############
tabus=/home/felidadae/Programming/Projects/tabus
function tabus__letswork {
	cd $tabus
	source .dev/tools.sh
	stn .dev/tabus.sublime-project
}
#sudo add-apt-repository ppa:graphics-drivers/ppa
pmypaint=/home/felidadae/Programming/_othersProjects/mypaint
function petitprince {
	google-chrome --app="https://translate.google.com/m/translate" &
	ppub /home/felidadae/Downloads/petitprince.epub & 
	ppub /home/felidadae/Downloads/Antoine_de_Saint-Exup_233_ry_-_The_Little_Prince.epub &
}

#added by command tmpAdd
gnomeAppsDef="/usr/share/applications"
vim_snippets=~/.vim/felidadae_snippets
_synth=/home/felidadae/Programming/_toolsSources/music-synthesizer-for-android


vim_=/home/felidadae/.vim
darktable_conf=/home/felidadae/.config/darktable
darktable_exec=/opt/darktable
darktable_src=$base/_toolsSources/darktable
cv=/home/felidadae/Programming/_General/notus/CV
