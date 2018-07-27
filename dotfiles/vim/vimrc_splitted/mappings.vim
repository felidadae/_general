" @leader
:let mapleader = ","
:let maplocalleader = "\\"

" @basics
inoremap jk <Esc>
:nmap ; :
:nnoremap <leader>ww :w<cr>
:inoremap <C-d> <BS>

" @gitgutter
:nmap ]h <Plug>GitGutterNextHunk
:nmap [h <Plug>GitGutterPrevHunk
:nmap <Leader>ha <Plug>GitGutterStageHunk
:nmap <Leader>hr <Plug>GitGutterUndoHunk
:nmap <Leader>hv <Plug>GitGutterPreviewHunk
:nmap <Leader>ggc :let g:gitgutter_diff_base = ''<Left>


" @easy-motion
" map ,, <Plug>(easymotion-prefix)
map ` <Plug>(easymotion-prefix)
let g:EasyMotion_smartcase = 1

" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)


" @ycm
:nnoremap ,] :YcmCompleter GoTo<CR>
:nnoremap ,dc :YcmCompleter GetDoc<CR>

" @mini buffer explorer
:let g:miniBufExplBuffersNeeded = 0
:nnoremap <Leader>mbe :MBEOpen<cr>
:nnoremap <Leader>mbc :MBEClose<cr>
:nnoremap <Leader>mbt :MBEToggle<cr>
:nnoremap <Leader>mbf :MBEFocus<cr>
:nnoremap <Leader>mn :MBEbp<cr>
:nnoremap nm<Leader> :MBEbn<cr>

:nnoremap ,qq :wqall!<cr>

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
:inoremap <Esc>l <Right>
:inoremap <Esc>h <Left>
:inoremap <Esc>b <c-o>b
:inoremap <Esc>e <c-o>e
:inoremap <Esc>w <c-o>w

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
:nnoremap <leader>b :CtrlPBuffer<cr>
:nnoremap <leader>e 10<C-e>
:nnoremap <leader>[ :execute "ptag " . expand("<cword>")<CR>
:nnoremap <leader>" <Right>Bi"<Esc>Ea"<Esc>
:nnoremap <Esc>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" @utlisnips
:nnoremap ,sl :UltiSnipsEdit<CR>
:let g:UltiSnipsExpandTrigger="<Esc>a"
:let g:UltiSnipsListSnippets="<c-u>"
:let g:UltiSnipsJumpForwardTrigger="<c-b>"
:let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" @replace current
:vnoremap <leader>n y :.,$s/<c-r>"//gc<Left><Left><Left>
:nnoremap <leader>n viwy :.,$s/<c-r>"//gc<Left><Left><Left>

" @command mode
cnoremap <C-w> <cr>
cnoremap <C-j> <down>
cnoremap <C-k> <up>

:nnoremap <leader>ac :Ack<space>



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
augroup filtetype_clike
	autocmd!
	:autocmd Filetype javascript,c,cpp inoremap p[ {<cr><cr>}<esc>kddko
	:autocmd Filetype c,cpp inoremap ;'; <Esc>$i;<Esc>o
	:autocmd Filetype c,cpp nnoremap ,cb /{<cr>N%xdw<C-o>xx<C-o>
augroup END

augroup cplusplus
	autocmd!
	:autocmd Filetype cpp inoremap -. ->
	:autocmd Filetype cpp inoremap 78 *
	:autocmd Filetype cpp inoremap `1 !
	:autocmd Filetype cpp inoremap 67 &
	:autocmd Filetype cpp inoremap sts std::
	:autocmd Filetype cpp inoremap vec vector<><Left>
	:autocmd Filetype cpp inoremap hashm unordered_map<><Left>
	:autocmd Filetype cpp inoremap boos boost::
	:autocmd Filetype cpp inoremap inc,. #include <><Left>
	:autocmd Filetype cpp inoremap ;; ::
	:autocmd Filetype cpp inoremap m,. <><Left>
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
