export base=~/Programming

# @general
export general="$base"/_General
export bashProfileFiles="$general"/bashProfile
export skeletons="$general/Skeletons"
export playground="$general"/playground
export algorithms="$general"/algorithms

# @base other than general
export projects="$base"/Projects
export labs="$base"/Labs
export musicallab=$labs/MusicalLab
export _sources="$base"/_ToolsSource
notus=$general/notusLink

# @other than base
export myphotos=~/Pictures/MojeZdjecia
export documents=~/Documents


function locationAdd {
	echo "$1" >> "$bashProfileFiles"/locations
}
### @added by function locationAdd >>
