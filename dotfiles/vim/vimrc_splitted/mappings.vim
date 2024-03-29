" @leader
:let mapleader = ","
:let maplocalleader = "\\"

" @TODO copy to tmux buffer
" :vnoremap y :silent! tmux set-buffer "@*"<CR>

" @basics
inoremap jk <Esc>
:nmap ; :
:inoremap <C-d> <BS>
:nnoremap <Space> 5<C-e>
:nnoremap m 5<C-y>
:nnoremap <c-u> 10<C-y>
:nnoremap <c-d> 10<C-e>

" @gitgutter
:nmap ]h <Plug>GitGutterNextHunk
:nmap [h <Plug>GitGutterPrevHunk
:nmap <Leader>ha <Plug>GitGutterStageHunk
:nmap <Leader>hr <Plug>GitGutterUndoHunk
:nmap <Leader>hv <Plug>GitGutterPreviewHunk
:nmap <Leader>ggc :let g:gitgutter_diff_base = ''<Left>

" @fugitive
:nmap ,gd :Gdiff
:nmap ,gs :Gstatus<CR>

" @easy-motion
" map ,, <Plug>(easymotion-prefix)
map ` <Plug>(easymotion-prefix)
let g:EasyMotion_smartcase = 0

" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)


" @ycm
" :nnoremap ,] :YcmCompleter GoTo<CR>
" :nnoremap <C-LeftMouse> :YcmCompleter GoTo<CR>
" :nnoremap <C-RightMouse> :YckcmCompleter GoTo<CR>
:nnoremap <C-RightMouse> bye :Ack!<space>'<c-r>"'<Left>
:nnoremap <RightMouse> :CtrlPBuffer<CR>
" :nnoremap ,dc :YcmCompleter GetDoc<CR>

" @mini buffer explorer
:let g:miniBufExplBuffersNeeded = 0
:nnoremap <Leader>mbe :MBEOpen<cr>
:nnoremap <Leader>mbc :MBEClose<cr>
:nnoremap <Leader>mbt :MBEToggle<cr>
:nnoremap <Leader>mbf :MBEFocus<cr>
:nnoremap <Leader>mn :MBEbp<cr>
:nnoremap nm<Leader> :MBEbn<cr>

" fast saving, quiting
:nnoremap ,qq :wqall!<cr>
:nnoremap qq :q<cr>
:nnoremap ,`q :qall!<cr>
:nnoremap <leader>ww :w<cr>
:nnoremap <leader>k :BUN<cr>

" @resize windows
:nnoremap <leader>= :vertical resize +10<cr>
:nnoremap <leader>== :vertical resize +50<cr>
:nnoremap <leader>- :vertical resize -10<cr>
:nnoremap <leader>-- :vertical resize -50<cr>
:nnoremap <leader><leader>= :resize +10<cr>
:nnoremap <leader><leader>- :resize -10<cr>

" @copy all
:nnoremap yal ggVGy

" @indent
:nnoremap .,, <<
:nnoremap ,.. >>
:vnoremap .,, <<
:vnoremap ,.. >>

" @edit vimrc-family and other important files
:nnoremap <leader>ev :edit ~/.vim/vimrc_splitted/vimrc_original
:nnoremap <leader>tm :edit ~/.tmux.conf
:nnoremap <leader>evm :edit ~/.vim/vimrc_splitted/mappings.vim<cr>
:nnoremap <leader>rv :source ~/.vim/vimrc_splitted/mappings.vim<cr>
:nnoremap <leader>ep :edit $general/bashProfile/pocketknife.sh<cr>/Mapping<cr>zt
:nnoremap <leader>epo :edit $general/bashProfile/pocketknife.sh<cr>G
" copy current position
:nnoremap <leader>yy :let @+ = expand("%:p") <cr>

augroup MyAutoCmd
    autocmd!
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

"fast looking through files
" :nnoremap - <C-f>
" :nnoremap 0 <C-b>

" @tabs
:nnoremap grt gT
:nnoremap l;l :tabn<Enter>
:nnoremap ;;; :tabe<Enter>
:nnoremap e, :TabberLabel 

" @insert-move provide hjkl movements in Insert mode via the <Alt> modifier key
:inoremap <C-l> <Right>
:inoremap <C-h> <Right>
:inoremap <C-t> <Tab>

" @Insert blank
:nnoremap ,2, :set paste<CR>m`o<Esc>``:set nopaste<CR>
:nnoremap <silent><F3> :set paste<CR>m`O<Esc>``:set nopaste<CR>
:nnoremap =<space> i<space><esc>
:nnoremap =<tab> i<tab><esc>
:nnoremap =<CR> i<CR><esc>

" @tagbar
:nnoremap ,tb :TagbarToggle<cr>

" @nerdtree
:nnoremap <leader>nt :NERDTreeToggle<cr>
:nnoremap <leader>nf :NERDTreeFocus<cr>

" @double quote string
:nnoremap <leader>" bdwi""<Esc>hp
:nnoremap <leader>{ bdwi{}<Esc>hp
:inoremap <m-j> <Tab><C-a>

" @others
:nnoremap <leader>t :CtrlPTag<cr>
:nnoremap <leader>p :CtrlP<cr>
:nnoremap <leader>h :hide<cr>
:nnoremap nr :hide<CR>
:nnoremap vs :vs<CR>
:nnoremap ss :split<cr>
:nnoremap <leader>b :CtrlPBuffer<cr>
:nnoremap vb :CtrlPBuffer<cr>
:nnoremap <leader>e 10<C-e>
:nnoremap <leader>[ :execute "ptag " . expand("<cword>")<CR>
:nnoremap <leader>" <Right>Bi"<Esc>Ea"<Esc>
:nnoremap <Esc>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" @utlisnips
:nnoremap ,sl :UltiSnipsEdit<CR>
:let g:UltiSnipsExpandTrigger="<c-a>"
:let g:UltiSnipsListSnippets="<c-u>"
:let g:UltiSnipsJumpForwardTrigger="<c-b>"
:let g:UltiSnipsJumpBackwardTrigger="<c-z>"

:vnoremap 0y :! tee > ~/tmp/.buffer; tmux load-buffer ~/tmp/.buffer; cat ~/tmp/.buffer<CR>
:nnoremap 000 :echom expand("%:h") . '/' . expand("%:t") . ':' . line(".")<CR>
:nnoremap AQ :SlimeSend<CR>
:vnoremap `y :! tee > ~/tmp/.buffer; tmux load-buffer ~/tmp/.buffer; cat ~/tmp/.buffer<CR>
:vnoremap <leader>n y :.,$s/<c-r>"//gc<Left><Left><Left>
:nnoremap <leader>n viwy :.,$s/<c-r>"//gc<Left><Left><Left>

" @command mode
cnoremap <C-m> <cr>
cnoremap <C-j> <down>
cnoremap <C-k> <up>

" :nnoremap <leader>ac :Ack!<space>''<Left>
" :nnoremap <leader>ac :Grepper -query <space>''<Left>
:nnoremap <leader>ac lbye :Grepper -query <space>'<c-r>"'<Left>
:nnoremap <C-f> lbye :Ack!<space>'<c-r>"'<Left>


" @all programming languages
:inoremap -= +
:inoremap 89 ()<Left>
:inoremap ;' ""<Left>
:inoremap 0- _

" @mapping-sh only
augroup filtetype_sh
	autocmd!
	:autocmd Filetype sh :inoremap 34 "$"<Left>
	"VVV Thats quite shitty thing: we here use escape sequence
	:autocmd Filetype sh :inoremap <Esc>4 \|<Space>
augroup END

" @mapping-c++ only
augroup filtetype_cplusplus
	autocmd!
augroup END

" @mapping-python only
augroup filtetype_python
	autocmd!
	:autocmd Filetype python :inoremap ;; <Esc>$a:<cr>
	:autocmd Filetype python :inoremap ;'; <Esc>$a<cr>
	:autocmd Filetype python :inoremap [] {}<Left>
	:autocmd Filetype python :inoremap prt print()<Left>
augroup END

" @mapping-java only
augroup filtetype_java
	autocmd!
	:autocmd Filetype java :inoremap ;'; <Esc>$;a<cr>
augroup END

" @mapping-java-script js only
augroup filtetype_javascript
	autocmd!
	:autocmd Filetype javascript :inoremap 34 "$"<Left>
augroup END

" @mappings-c_like_languages
augroup cplusplus
	autocmd!
	:autocmd Filetype cpp inoremap sts std::
augroup END

augroup vimscript
	autocmd!
	:autocmd Filetype vim nnoremap gff lBvEgf
augroup END

" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()

" autocmd BufWritePre *.py :%s/\s\+$//e
" autocmd BufWritePre *.cpp :%s/\s\+$//e
" autocmd BufWritePre *.h :%s/\s\+$//e
" autocmd BufWritePre *.java :%s/\s\+$//e

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
:nnoremap tbt <Plug>SlimeConfig<CR>
:nnoremap rvr :SlimeSend<CR>
:nnoremap rrr :SlimeSend<CR>

:let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
:let g:slime_target = "tmux"
:let g:slime_dont_ask_default = 1
