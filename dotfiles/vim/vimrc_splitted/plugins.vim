"----------------------------------------------------------------------------------
" @Plugins
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"@core 
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
" Plugin 'vim-airline/vim-airline'

"@usefull navigation
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'easymotion/vim-easymotion'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tmux-plugins/vim-tmux'

"@look
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
" Plugin 'xolox/vim-session'
" Plugin 'xolox/vim-misc'
Plugin 'vim-scripts/keepcase.vim'
Plugin 'fweep/vim-tabber'
" Plugin 'vim-scripts/vim-auto-save'
Plugin 'mileszs/ack.vim'
Plugin 'tweekmonster/django-plus.vim'
Plugin 'majutsushi/tagbar'

"@syntax
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'lifepillar/pgsql.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'

"@folding
" Plugin 'Konfekt/FastFold'

call vundle#end()            
filetype plugin indent on
" @Plugins.end
"----------------------------------------------------------------------------------
