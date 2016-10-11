#--------------------------------
#******
#CUDA
if [ "$OS_KERNEL__" = "darwin" ]; 
then
	#MAC OS X
	cudaSamplesCommon=/Developer/NVIDIA/CUDA-7.5/samples/common
	cuda="/Developer/NVIDIA/CUDA-7.5"
fi
if [ "$OS_KERNEL__" = "linux" ]; 
then
	cudaSamplesCommon=""
	cuda=""
fi
cudaTools="$cuda"/bin
alias cuda-memcheck="$cudaTools"/cuda-memcheck
cudasamples="$cuda/samples" 
cudadocpdf="$cuda/doc/pdf"
cudadochtml="$cuda/doc/html"
function openCUDATool {
	"$cuda"/bin/$1 $2
}
#******



#******
#General
if [ "$OS_KERNEL__" = "darwin" ]; 
then
	#MAC OS X
	alias gnugcc=/opt/local/bin/x86_64-apple-darwin15-gcc-5.2.0
	alias pdflatex=/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin/pdflatex
fi
if [ "$OS_KERNEL__" = "linux" ]; 
then
	function init_ {
		redshift -O "$1"
	}
fi
#******



#******
#Sublime-text

if [ "$OS_KERNEL__" = "darwin" ]; 
then
	#MAC OS X
	export sublime3_my="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
	###
	export sublime3_mainpref="$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
fi
if [ "$OS_KERNEL__" = "linux" ]; 
then
	#LINUX
	export sublime3_my="$HOME/.config/sublime-text-3/Packages/User"
	###
	export sublime3_mainpref="$sublime3_my/Preferences.sublime-settings"
fi

alias st="subl"
alias stn="subl -n"
#******



#******
#OCTAVE
if [ "$OS_KERNEL__" = "darwin" ]; 
then
	#MAC OS X
	alias octave=/usr/local/octave/3.8.0/bin/octave
	alias browser="osascript $general/tools/new_window.scpt"
	alias xcode="open -a Xcode"
	alias matlab=/Volumes/EXTERNDISC/Szymon/MATLAB_R2013a.app/bin/matlab 
fi
#******
#--------------------------------
