lynx -cookies=1 -accept_all_cookies=1 -cookie_file=cookie.file google.com
tmux attach-session -t 0
tmux ls
perl
	-e		#redirect output from perl to console
	-n -p	#loop for each line, second also add print
	-i		#do job in place

perl -pi -e  s/ XZA / DUPOSZ /gx $(find . -name *txt)

git remote set-url origin https://github.com/felidadae/_general.git
git push -u origin master
