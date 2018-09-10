#!/bin/bash -e
cd ~/.vim/bundle/YouCompleteMe
sudo apt-get install -y build-essential cmake
sudo apt-get install -y python-dev python3-dev
./install.py --clang-completer --java-completer
