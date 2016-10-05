mkdir ~/.vim
mkdir ~/.vim/bundle

cd ~/
ln -s Programming/_General/configurationFiles/vim/vimrc .vimrc
cd ~/.vimrc
ln -s ../Programming/_General/configurationFiles/vim/syntax
ln -s ../Programming/_General/configurationFiles/vim/fdetect
ln -s ../Programming/_General/configurationFiles/vim/sessions
ln -s ../Programming/_General/configurationFiles/vim/felidadade_snippets

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
