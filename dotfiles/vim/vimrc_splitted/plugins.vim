"----------------------------------------------------------------------------------
" @Plugins
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"@core 
" Plugin 'Valloric/YouCompleteMe'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
Plugin 'thomasfaingnaert/vim-lsp-snippets'
Plugin 'thomasfaingnaert/vim-lsp-ultisnips'
Plugin 'prabirshrestha/asyncomplete.vim'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

"@usefull navigation
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-vinegar'
Plugin 'easymotion/vim-easymotion'
Plugin 'thalesmello/vim-tmux-navigator'
Plugin 'tmux-plugins/vim-tmux'

"@look
Plugin 'altercation/vim-colors-solarized'
Plugin 'ryanoasis/vim-devicons'
Plugin 'crusoexia/vim-monokai'

"@small things but making me so happy..
Plugin 'godlygeek/tabular'
" Plugin 'jiangmiao/auto-pairs' # paranthesis, but its too often wrong
Plugin 'vim-scripts/CmdlineComplete'
Plugin 'itchyny/vim-cursorword' "underline words under cursor
Plugin 'tpope/vim-commentary'   "comments
Plugin 'tpope/vim-abolish'
Plugin 'qpkorr/vim-bufkill'
Plugin 'vim-scripts/keepcase.vim'
Plugin 'fweep/vim-tabber'
Plugin 'vim-scripts/vim-auto-save'
Plugin 'mileszs/ack.vim'
Plugin 'mhinz/vim-grepper'
Plugin 'jpalardy/vim-slime'
" Plugin 'nathanaelkane/vim-indent-guides'

Plugin 'tweekmonster/django-plus.vim'
Plugin 'majutsushi/tagbar'
"Plugin 'fholgado/minibufexpl.vim'
Plugin 'nvie/vim-flake8'

"@syntax
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'lifepillar/pgsql.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'lepture/vim-jinja'
Plugin 'martinda/Jenkinsfile-vim-syntax'
Plugin 'itkq/fluentd-vim'

"@folding
Plugin 'vim-jp/vim-java'

call vundle#end()            
filetype plugin indent on
" @Plugins.end
"----------------------------------------------------------------------------------
