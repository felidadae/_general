rm -rf source destiny
mkdir source destiny

touch source/sampleFile.txt
mkdir source/dir
touch source/dir/t1.txt
touch source/dir/really_big_file.tsv
touch destiny/trashFile.txt

rsync -av --exclude '*.tsv' --delete source/ destiny
