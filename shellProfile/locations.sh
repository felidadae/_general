# @system wide

# Where gnome keeps all its stuff system-wide
export gnome_system_stuff=/usr/share/gnome-shell 
export gnome_user_stuff=~/.local/share/gnome-shell



# @base
export base=~/Programming



# @general
export general="$base"/_General
export shellProfileFiles="$general"/shellProfile
export skeletons="$general/skeletons"
export playground="$general"/playground
export algorithms="$general"/algorithms



# @base other than general
export projects="$base"/Projects
export labs="$base"/Labs
export musicallab=$labs/MusicalLab
export _sources="$base"/_ToolsSource
export notus=$general/linkNotus
export books=$general/linkMyBooks
export powiesci=$general/linkMyBooks/powiesci
export dropbox=$general/linkDropbox

# @other than base
export myphotos=~/Pictures/MojeZdjecia
export documents=~/Documents



function locationAdd {
	echo "$1" >> "$shellProfileFiles"/locations
}

ultisnips_dir=$general/dotfiles/vim/snippets/
### @added by function locationAdd >>
