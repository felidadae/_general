#^elka2015Z
elka2015Z="$base"/School/elka2015Z
elka2015L="$base"/School/elka2015L

#^ Magisterka
master="$base"/School/Master/
function master_letswork {
	cd $master; clear;
	stn .dev/MASTER_PROJECT.sublime-project
	open -a Terminal "`pwd`"
	
	#open -a /Applications/PyCharm.app $(pwd)/src/DNN

	cd src/DNN
	git status
	git remote -v
}

#^RIM
rim="$elka2015Z"/RIM
nbodies="$elka2015Z"/RIM/project/NBodiesSimulation
function rim_letwork {
	cd "$rim"; clear;
	stn .dev/RIM.sublime-project
	# browser file://"$rim"/labs/_papers/skrypt.pdf \
	# 	file://"$rim"/books/opengl_programming_guide_8th_edition.pdf 
	cd project/NBodiesSimulation; clear;
}
function nbodies_letwork {
	cd "$rim"; clear;
	stn .dev/RIM.sublime-project
	cd project/NBodiesSimulation; clear;
}

#^MOW
mow="$elka2015Z"/MOW
function mow_letswork {
	cd "$mow";
	stn .dev/MOW.sublime-project
	#browser https://drive.google.com/drive/folders/0Bze5-xB00zDLeXVzQ0xPOFpKM1E
}

#^ROB
rob="$elka2015L"/ROB