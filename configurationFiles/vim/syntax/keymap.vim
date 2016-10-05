if exists('b:current_syntax') | finish|  endif

syntax match descriptionOfKeys ".*$"
syntax match arrow "\v:\s" nextgroup=descriptionOfKeys
syntax match keys "\v^[^\$\-].{-}((:\s)|$)@=" nextgroup=arrow
syntax match title "\v^\s*\$.*$"
syntax match type "\v^\s*\@.*$"

let b:current_syntax = 'keymap'

hi def link title Statement
hi def link type Statement
hi def link keys String 
hi def link arrow Statement
hi def link descriptionOfKeys Comment 
