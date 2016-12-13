lynx -cookies=1 -accept_all_cookies=1 -cookie_file=cookie.file google.com
tmux attach-session -t 0
tmux ls
perl
    -e      #redirect output from perl to console
    -n -p   #loop for each line, second also add print
    -i      #do job in place

perl -pi -e  s/ XZA / DUPOSZ /gx $(find . -name *txt)

git remote set-url origin https://github.com/felidadae/_general.git
git push -u origin master

set -x ;
set -o functrace
find src -path src/g2p_improvement__server -prune -o -path src/tifocus/migrations -prune -o -name *.py -o -name *.sh -print | xargs wc -l

perl -pi.backup -e  's/ \saer_tsv__comparison__word_statistics__2html / run.sh /gx' $(find .)
grep -Pr 'pattern'

@Observation points for bugs
sed -n 111,117p _main/diff_.sh > _r
function seeWord {
	grep -iR "$1" ~/tmp/prev_refhyp > r; 
	echo "********************" >> r
	grep -iR "$1" ~/tmp/curr_refhyp >> r
	perl -pi -e 's/^.*?\t//g' r  
}
echo $prev_refhyp $curr_refhyp
exit
rep function -r --include=\*.sh _main