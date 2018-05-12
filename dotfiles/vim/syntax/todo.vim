" Quit when a syntax file was already loaded.
if exists('b:current_syntax') | finish |  endif

syntax match tickerDone "\[+\]" 
syntax match tickerRejected "\[|\]" 
syntax match ticker "\[[^+|]\]" 
syntax match tags "{.\{-}}" 
syntax match content "@.*" 
syntax match date "\v\d\d\d\d[-.]\d\d([-.]\d\d)?" 
syntax match title "$[a-zA-Z].*" 
syntax match priorytet "\v\*[\d+-]+\*"
syntax match http_link "\vhttps?://.*\s*" contained
syntax match note "\v^\s*\w.*" contains=http_link
syntax keyword MyKeywords Niewczesniej Czekajac Zakladajac Jezeli Wowczas Przypadek Gdy gotowe oraz lub Nota contained
syntax keyword logicStart %
syntax match logic "%.*$" contains=MyKeywords,logicStart
syn region braceBlock start='{{{' end='}}}' contains=Keyword

hi def link tickerDone TickerDone 
hi def link tickerRejected TickerRejected
hi def link ticker TickerUndone 
hi def link tags TickerDone
hi def link content ContentOf
hi def link date DateOf
hi def link title Title
hi def link http_link HttpLink 
hi def link note NoteC
hi def link MyKeywords Keyword
hi def link priorytet Priorytet
hi def link logic Logic
hi def link braceBlock BraceBlock


let b:current_syntax = 'todo'
hi TickerDone ctermfg=28 ctermbg=NONE cterm=NONE guifg=green guibg=NONE gui=NONE
hi TickerRejected ctermfg=red ctermbg=NONE cterm=NONE guifg=green guibg=NONE gui=NONE
hi TickerUndone ctermfg=31 ctermbg=NONE cterm=NONE guifg=red guibg=NONE gui=NONE
hi tags ctermfg=33 ctermbg=NONE cterm=NONE guifg=green guibg=NONE gui=NONE
hi ContentOf ctermfg=100 ctermbg=NONE cterm=NONE guifg=red guibg=NONE gui=NONE
hi DateOf ctermfg=69 ctermbg=NONE cterm=NONE guifg=red guibg=NONE gui=NONE
hi Title ctermfg=65 ctermbg=NONE cterm=NONE guifg=red guibg=NONE gui=NONE
hi NoteC ctermfg=11 ctermbg=NONE cterm=NONE guifg=darkgrey guibg=NONE gui=NONE
hi HttpLink ctermfg=12 ctermbg=NONE cterm=underline guifg=darkgrey guibg=NONE gui=NONE
hi Priorytet ctermfg=red ctermbg=NONE cterm=NONE guifg=darkgrey guibg=NONE gui=NONE
hi Logic ctermfg=11 ctermbg=NONE cterm=NONE guifg=darkgrey guibg=NONE gui=NONE
hi BraceBlock ctermfg=11 ctermbg=NONE cterm=NONE guifg=darkgrey guibg=NONE gui=NONE
