:nnoremap ne :bp\|bd #<CR> 
:nnoremap <C-n> :<C-f>
:nnoremap <C-b> :CtrlPBuffer<CR>
:nnoremap <C-t> :CtrlPTag<CR>
let g:ctrlp_switch_buffer = '0'
:nnoremap T zt

syn keyword pythonSelf self
highlight def link pythonSelf TickerDone
hi TickerDone ctermfg=28 ctermbg=NONE cterm=NONE guifg=green guibg=NONE gui=NONE

" :nnoremap gd :YcmCompleter GoTo<CR>
:nnoremap <silent> ,gs :Gstatus<CR>:13wincmd_<CR>
let g:ycm_confirm_extra_conf = 0

:nnoremap tbt :SlimeConfig<CR>
:nnoremap rvr :SlimeSend<CR>
:nnoremap rrr :SlimeSend<CR>
