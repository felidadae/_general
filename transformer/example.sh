function dupa {
	echo PAN_JANEK

	exec 3>&1
	exec 4>&2

	exec &> examples__
	echo "DUPASON"
	echo "DUPASON"
	echo "DUPASON"
	echo "DUPASON"
	echo "DUPASON"
	echo "DUPASON"
	echo "DUPASON"
	echo "DUPASON"
	echo "DUPASON"

	exec 1>&3
	exec 2>&4

	echo PAN_JANEK
}

dupa &> examples0_
