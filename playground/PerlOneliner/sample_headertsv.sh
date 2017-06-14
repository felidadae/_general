rm test
echo -e "head0${TAB}head1${TAB}head2${TAB}head3\n" >> test
echo -e "col0${TAB}col1${TAB}col2${TAB}col3" >> test
echo -e "cola${TAB}colb${TAB}colc${TAB}cold" >> test

cat test | perl -F'\t' -lane '
		if ($. == 1) { for ($i=0; $i < @F; ++$i) { $a{$F[$i]}=$i++; } } 
		else { print $_ if $F[$a{"head0"}] eq "col0"; }'

