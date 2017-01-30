#/opt/local/bin/bash -eu

#	@Title: 
#		Archivizator
#
#	@Description:
#		archive from $sourceArchive locations
#		to $destinationArchive;
#
#	@Abbreviations:
#		@fbp <- full base path
#


source ~/.bash_profile

# 
#	$base <- 
#		e.g. on mac ~/Programming;
#		all programming projects;
#	$myphotos <-
#		e.g. on mac ~/Pictures/MojeZdjecia	
# 
sourceArchive=(\
	"$base" \
	"$myphotos" \
	"$documents" \
)

#
#	$externDisc <- 
#		e.g. on mac: /Volumes/EXTERNDISC
#
destinationArchive=(\
	"$externDisc"/_archive \
)

for dest in "${destinationArchive[@]}"
do
	if [ ! -d "$dest" ]; then continue; fi;
	for source in "${sourceArchive[@]}"
	do
	   rsync --update -r --delete "$source" "$dest"
	done
done
