if exists('b:current_syntax') | finish|  endif

syntax match ZUPA "ZUPA" contained display
syntax region godDamnRegion start="{" end="}" contains=ZUPA
syntax region godDamnRegioN start="^\t" end="$" contains=ZUPA

let b:current_syntax = 'keymap'

hi def link ZUPA String 
