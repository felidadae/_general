#!/bin/bash -ex
for i in $HOME/.dropbox-dist/dropbox-lnx.x86_64-*/images/hicolor/16x16/status/*; do
	cp $HOME/.dropbox-dist/dropbox-lnx.x86_64-*/images/emblems/emblem-dropbox-infinite.png $i
done
