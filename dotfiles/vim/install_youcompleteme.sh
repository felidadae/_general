cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer 

cd ~
mkdir ycm_tmp
cd ycm_tmp
curl http://llvm.org/releases/3.8.1/clang+llvm-3.8.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
#curl http://llvm.org/releases/3.8.1/clang+llvm-3.8.1-x86_64-linux-gnu-ubuntu-14.04.tar.xz

cd ~
mkdir ycm_build 
cd ycm_build

K=~/ycm_tmp/clang+llvm-3.8.1-x86_64-linux-gnu-ubuntu-16.04
cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=$K . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core --config Release
