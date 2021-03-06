"----------------------------------------------------------------------------------
"GUI OPTIONS
" :set guifont=Roboto\ Mono\ Medium\ for\ Powerline\ Medium\ 9 

" @devicons
:let g:webdevicons_enable_ctrlp = 1
:let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
:let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

let g:rainbow_active = 1

" @colors
set background=dark
colorscheme solarized

filetype plugin on
syntax on

" :set t_Co=256
" :colorscheme monokai
:hi nontext ctermfg=bg 
:hi SignColumn term=none cterm=none ctermfg=green ctermbg=black
:hi folded term=none cterm=none ctermfg=green ctermbg=none
:hi foldcolumn ctermbg=none
:hi folded term=none cterm=none ctermfg=green ctermbg=none
:hi foldcolumn ctermbg=none
:hi MatchParen cterm=none ctermbg=none ctermfg=35 "opening/closing paranthesis

:hi DiffAdd ctermfg=none
:hi DiffText ctermfg=none
" :hi DiffDelete ctermfg=none 
:hi DiffChange ctermfg=none


" to fix ack output to terminal
set shellpipe=&>

" call Initialize_highlights_()


"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
" @encoding @indent @general
:set nowrap
:set linebreak
" :set display+=lastline
:set lazyredraw "very very good shit; not redrawing while macros, etc.
" :set rnu
:set rnu
:set number
:set cursorline
hi NonText guifg=bg
:set encoding=utf8
:set laststatus=2
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
:set timeoutlen=300 ttimeoutlen=0
:set backspace=indent,eol,start
if &history < 5000
  set history=5000
endif
"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
:set ttymouse=xterm2
:set mouse=n
:set ttymouse=sgr
:set breakindent
:set ttyfast
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

au BufRead,BufNewFile *.aurora set filetype=python
