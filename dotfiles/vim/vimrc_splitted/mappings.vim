"
" Grouping mappings into groups:
" - @basics
"
"

" @basics
:let mapleader = ","
:let maplocalleader = "\\"
inoremap jk <Esc>
:nnoremap ghg G
:nnoremap <leader>= :vertical resize +10<cr>
:nnoremap <leader>- :vertical resize -10<cr>
:nnoremap <leader><leader>= :resize +10<cr>
:nnoremap <leader><leader>- :resize -10<cr>
:nmap ; :
:nnoremap grt gT
:nnoremap <leader>ev :split $MYVIMRC<cr>/Mapping<cr>zt
:nnoremap <leader>rv :source ~/.vimrc<cr>
augroup MyAutoCmd
    autocmd!
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END
:nnoremap ,.. >>
:nnoremap .,, << 
:nnoremap l;l :tabn<Enter>
:nnoremap ;;; :tabe<Enter>
:nnoremap e, :TabberLabel 

" @insert-move provide hjkl movements in Insert mode via the <Alt> modifier key
:inoremap <Esc>l <Right>
:inoremap <Esc>h <Left>

" @fast begin end
:nnoremap <Esc>g 0
:nnoremap <Esc>; $
:inoremap <Esc>b <c-o>b
:inoremap <Esc>e <c-o>e
:inoremap <Esc>w <c-o>w
:inoremap ó <c-o>
:nnoremap <Esc>a A

" @Insert blank
nnoremap ,2, :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><F3> :set paste<CR>m`O<Esc>``:set nopaste<CR>
:nnoremap =<space> i<space><esc>
:nnoremap =<tab> i<tab><esc>
:nnoremap =<CR> i<CR><esc>

" @nerdtree
:nnoremap <leader>nt :NERDTreeToggle<cr>
:nnoremap <leader>nf :NERDTreeFocus<cr>

" @double quote string
:nnoremap <leader>" bdwi""<Esc>hp
:nnoremap <leader>{ bdwi{}<Esc>hp
:inoremap <m-j> <Tab><C-a>
""
" @others
:nnoremap cp :let @+ = expand("%") <cr>
:nnoremap <leader>ep :split $general/bashProfile/pocketknife.sh<cr>/Mapping<cr>zt
:nnoremap <leader>epo :split $general/bashProfile/pocketknife.sh<cr>G
:nnoremap <leader>p :CtrlPTag
:nnoremap <leader>h :hide
:nnoremap <leader>b :CtrlPBuffer<cr>
:nnoremap <leader>e 10<C-e>
:nnoremap <leader>[ :execute "ptag " . expand("<cword>")<CR>
:nnoremap <leader>" <Right>Bi"<Esc>Ea"<Esc> 
nnoremap <Esc>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
:nnoremap op[ :UltiSnipsEdit<CR>
let g:tabber_predefined_labels = { 1: 'core', 2: 'html/json', 3: 'others' }

" @replace current
:vnoremap <leader>n y :.,$s/<c-r>"//gc<Left><Left><Left>
:nnoremap <leader>n viwy :.,$s/<c-r>"//gc<Left><Left><Left>


" @all programming languages
:inoremap ;'; <Esc>o
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
	:autocmd Filetype javascript,c,c++ inoremap p[ {<cr><cr>}<esc>ka<tab>
augroup END
