"----------------------------------------------------------------------------------
" @Plugins
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"@core 
Plugin 'Valloric/YouCompleteMe'
Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

"@usefull navigation
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'easymotion/vim-easymotion'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tmux-plugins/vim-tmux'

"@look
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ryanoasis/vim-devicons'

"@small things but making me so happy..
Plugin 'godlygeek/tabular'
Plugin 'jiangmiao/auto-pairs'
Plugin 'vim-scripts/CmdlineComplete'
Plugin 'itchyny/vim-cursorword' "underline words under cursor
Plugin 'tpope/vim-commentary'   "comments
Plugin 'tpope/vim-abolish'
Plugin 'qpkorr/vim-bufkill'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'
Plugin 'vim-scripts/keepcase.vim'
Plugin 'fweep/vim-tabber'
Plugin 'vim-scripts/vim-auto-save'

"@syntax
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'lifepillar/pgsql.vim'

"@folding
Plugin 'tmhedberg/SimpylFold'

call vundle#end()            
filetype plugin indent on
" @Plugins.end
"----------------------------------------------------------------------------------
