" @nerdtree
:let g:NERDTreeDirArrowExpandable="+"
:let g:NERDTreeDirArrowCollapsible="~"
:let g:NERDTreeWinSize=45
:let g:NERDTreeMinimalUI=1
:let NERDTreeHijackNetrw=0
" enable line numbers
:let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber
:let NERDTreeIgnore = ['\.pyc$', '__pycache__', 'tags$']
" :autocmd VimEnter * NERDTree

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" @devicons
:let g:webdevicons_enable_ctrlp = 1
:let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
:let g:WebDevIconsUnicodeGlyphDoubleWidth = 1


" @ctrlp fuzzy finder
:let g:ctrlp_follow_symlinks = 2
:let g:ctrlp_working_path_mode = 'r'
:let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" @ultisnips
:let g:UltiSnipsEditSplit="horizontal"
:let g:UltiSnipsSnippetDirectories=["UltiSnips", "felidadae_snippets"]
:let g:UltiSnipsSnippetsDir="~/.vim/felidadae_snippets"


" @easy-motion
map ,, <Plug>(easymotion-prefix)


" @autosave plugin options
let g:auto_save = 1
let g:auto_save_no_updatetime = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1


" @ycm you complete me ycm to set python version
" :let g:ycm_python_binary_path = 'python'
" :let g:ycm_global_ycm_extra_conf = '~/Programming/_General/tools/ycm/.ycm_global_conf.py'


" @session @vim-session
" let g:gitgutter_realtime = 0
" let g:gitgutter_eager = 0
if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif


" @session @vim-session
set sessionoptions-=options
set sessionoptions-=help
set sessionoptions-=buffers


" @tabber
let g:tabber_predefined_labels = { 1: 'workspace-1', 2: 'workspace-2', 3: 'workspace-3' }

" @vim-slime
let g:slime_target = "tmux"
let g:slime_python_ipython = 1

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
" function! s:on_lsp_buffer_enabled() abort
setlocal omnifunc=lsp#complete
setlocal signcolumn=yes
nmap <buffer> gd <plug>(lsp-definition)
nmap <buffer> <f2> <plug>(lsp-rename)
" refer to doc to add more commands
" endfunction
