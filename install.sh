source bashProfile/my_main.sh

cd "$general"
cd configurationFiles
bash install.sh

cd "$general"
cd tools
bash install.sh

cd "$general"
cd subconsciousManager
#check if dropbox working
# make ln -s of all dailyNotes
# ln -s ~/Dropbox/dailyNotes/thoughts.todo thoughts.todo
# ln -s ~/Dropbox/dailyNotes/thoughts.todo thoughts.todo