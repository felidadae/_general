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
" call Initialize_highlights_()
"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
" @encoding @indent @general
:set wrap
:set linebreak
:set display+=lastline
:set lazyredraw "very very good shit; not redrawing while macros, etc.
:set rnu
:set nu
set clipboard=unnamedplus
filetype on
filetype plugin on
filetype indent on
:set showtabline=2
set splitbelow
set splitright
:set autowrite
:set ignorecase
:set smartcase
:set hidden
:set ssop=blank,buffers,sesdir,folds,tabpages,winpos,winsize
:set isfname-=/
:set path=$PWD/**
:set timeoutlen=1000 ttimeoutlen=0
"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
" :set breakindent
" :set ttyfast
" :set t_ut=
" :set textwidth=0 
" :set wrapmargin=0
" :set cursorline
" hi NonText guifg=bg
" :set encoding=utf8
" :set laststatus=2
" :set backspace=2
" " :set scroll=15
" " :set showtabline=0
" :set foldignore=
" " set iskeyword-=_
"----------------------------------------------------------------------------------
