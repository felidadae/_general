export base=~/Programming
export myphotos=~/Pictures/MojeZdjecia
export documents=~/Documents

export general="$base"/_General
export bashProfileFiles="$general"/bashProfile
#---
export projects="$base"/Projects
#---
export playground="$base"/Playground
export labs="$base"/Labs
function locationAdd {
	echo "$1" >> "$bashProfileFiles"/locations
}
export algorithms="$base"/Algorithms
#---
export vimrc=~/.vimrc
export tmuxconf=~/.tmux.conf
export tmuxsessions=$general/configurationFiles/tmux/sessions
#---
if [ "$OS_KERNEL__" = "darwin" ]; 
then
	#MAC OS X
	externDisc="/Volumes/EXTERNDISC"
fi
#---
notus=$general/notus
#---
#---

