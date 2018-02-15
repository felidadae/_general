"----------------------------------------------------------------------------------
"GUI OPTIONS
:set guifont=Roboto\ Mono\ Medium\ for\ Powerline\ Medium\ 9 

" @devicons
:let g:webdevicons_enable_ctrlp = 1
:let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
:let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

" @colors
set background=dark
colorscheme solarized
:highlight nontext ctermfg=bg 
:hi folded term=none cterm=none ctermfg=green ctermbg=none
:hi foldcolumn ctermbg=none
"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
" @encoding @indent @general
:set wrap
:set linebreak
" :set breakindent
:set display+=lastline
:set t_ut=
:set rnu
:set nu
:set cursorline
hi NonText guifg=bg
:set encoding=utf8
:set laststatus=2
set clipboard=unnamedplus
filetype on
filetype plugin on
filetype indent on
syntax enable
:set textwidth=0 
:set wrapmargin=0
:set showtabline=2
:set backspace=2
" :set scroll=15
set splitbelow
set splitright
:set autowrite
:set ignorecase
:set smartcase
" :set showtabline=0
:set foldignore=
:set hidden
:set ssop=blank,buffers,sesdir,folds,tabpages,winpos,winsize
set iskeyword-=_
:set isfname-=/
:set path=$PWD/**
:set timeoutlen=300 ttimeoutlen=0
"----------------------------------------------------------------------------------
