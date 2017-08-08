perl -F"$TAB" -lane '
	if ($F[5] eq "surface" || $F[5] eq "german" || $F[5] eq "N/A") {
		$sum += $F[6] * $F[7];
	} 
	END {print $sum;}' \
	<( cat equipment.5.tsv | sed '1d')
