function installLab {
	local labDirName=${1}
	local repoName=${2}

	cd $general
	cd ..
	[[ ! -d Labs ]] && mkdir Labs
	cd Labs
	if [[ ! -d $"labDirName" ]]; then
		if git clone https://github.com/felidadae/$repoName.git; then
			printf "${GREEN}[Success]${NC} Installed >>$repoName<< repo in $(pwd)\n"
		else
			printf "${RED}[Error]${NC} Couldn't clone the repo\n"
			exit 1
		fi
	else 
		printf "${YELLOW}[Info]${NC} A Directory with the repo exists already\n"
	fi
	mv $repoName $"labDirName"
	cd $"labDirName"

	echo "Trying to install dependencies..."
	if bash installDependencies.sh; then
		printf "${GREEN}[Success]${NC} Successfully installed the repository\n"
	else
		printf "${RED}[Error]${NC} Couldn't install the dependencies\n"
		exit 1
	fi
}