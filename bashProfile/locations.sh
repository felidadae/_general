export base=~/Programming
export myphotos=~/Pictures/MojeZdjecia
export documents=~/Documents

export general="$base"/_General
export bashProfileFiles="$general"/bashProfile
export skeletons="$general/Skeletons"
#---
export projects="$base"/Projects
#---
export playground="$base"/Playground
export labs="$base"/Labs
export musicallab=$labs/MusicalLab
function locationAdd {
	echo "$1" >> "$bashProfileFiles"/locations
}
export algorithms="$base"/Algorithms
export _sources="$base"/_ToolsSource
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
notus=$general/notusLink
#---
#---
