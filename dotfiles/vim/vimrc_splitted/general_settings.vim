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
"----------------------------------------------------------------------------------

au BufRead,BufNewFile *.aurora set filetype=python


"----------------------------------------------------------------------------------
" @wipeout
command! -bang Wipeout2 :call Wipeout2(<bang>0)
function! Wipeout2(bang)
	" figure out which buffers are visible in any tab
	let visible = {}
	for t in range(1, tabpagenr('$'))
		for b in tabpagebuflist(t)
			let visible[b] = 1
		endfor
	endfor
	" close any buffer that are loaded and not visible
	let l:tally = 0
	let l:cmd = 'bw'
	if a:bang
		let l:cmd .= '!'
	endif
	for b in range(1, bufnr('$'))
		if buflisted(b) && !has_key(visible, b)
			let l:tally += 1
			exe l:cmd . ' ' . b
		endif
	endfor
	echon "Deleted " . l:tally . " buffers"
endfun

:let g:session_autosave = 'no'
"----------------------------------------------------------------------------------

"----------------------------------------------------------------------------------
" @line-length-limit x-st column is magenta if there is a char
" autocmd BufNewFile,BufRead *.py highlight ColorColumn ctermbg=magenta
" autocmd BufNewFile,BufRead *.py call matchadd('ColorColumn', '\%100v', 100)
"----------------------------------------------------------------------------------

"----------------------------------------------------------------------------------
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction
"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
:set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
:autocmd Filetype html setlocal ts=2 sw=2 expandtab
:autocmd Filetype htmldjango setlocal ts=2 sw=2 expandtab
:autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
:autocmd FileType json setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
:autocmd FileType java setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
:autocmd FileType cpp setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
:autocmd FileType javascript setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
:autocmd FileType sh setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
:autocmd Filetype typescript setlocal ts=2 sw=2 expandtab
"----------------------------------------------------------------------------------
