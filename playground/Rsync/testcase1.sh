rm -rf source destiny
mkdir source destiny

touch source/sampleFile.txt
mkdir source/dir
touch source/dir/t1.txt
touch destiny/trashFile.txt

rsync -av --delete source/ destiny
