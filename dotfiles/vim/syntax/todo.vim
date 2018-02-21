" Quit when a syntax file was already loaded.
if exists('b:current_syntax') | finish |  endif

syntax match tickerDone "\[+\]" 
syntax match tickerRejected "\[|\]" 
syntax match ticker "\[[^+|]\]" 
syntax match tags "{.*}" 
syntax match content "@.*" 
syntax match date "$\d+" 
syntax match title "$[a-zA-Z].*" 
syntax match note "\v^\s+[^$\[].*" 

hi def link tickerDone TickerDone 
hi def link tickerRejected TickerRejected
hi def link ticker TickerUndone 
hi def link tags TickerDone
hi def link content ContentOf
hi def link date DateOf
hi def link title Title
hi def link note Comment

let b:current_syntax = 'todo'
hi TickerDone ctermfg=28 ctermbg=NONE cterm=NONE guifg=green guibg=NONE gui=NONE
hi TickerRejected ctermfg=red ctermbg=NONE cterm=NONE guifg=green guibg=NONE gui=NONE
hi TickerUndone ctermfg=31 ctermbg=NONE cterm=NONE guifg=red guibg=NONE gui=NONE
hi tags ctermfg=33 ctermbg=NONE cterm=NONE guifg=green guibg=NONE gui=NONE
hi ContentOf ctermfg=100 ctermbg=NONE cterm=NONE guifg=red guibg=NONE gui=NONE
hi DateOf ctermfg=65 ctermbg=NONE cterm=NONE guifg=red guibg=NONE gui=NONE
hi Title ctermfg=65 ctermbg=NONE cterm=NONE guifg=red guibg=NONE gui=NONE
