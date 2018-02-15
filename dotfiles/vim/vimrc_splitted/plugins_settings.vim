"----------------------------------------------------------------------------------
" @nerdtree
:let g:NERDTreeDirArrowExpandable="+"
:let g:NERDTreeDirArrowCollapsible="~"
:let g:NERDTreeWinSize=34
:let g:NERDTreeMinimalUI=1
:let NERDTreeHijackNetrw=0
" enable line numbers
:let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber
:let NERDTreeIgnore = ['\.pyc$', '__pycache__', 'tags$']
"----------------------------------------------------------------------------------



"----------------------------------------------------------------------------------
" @ctrlp fuzzy finder
:let g:ctrlp_follow_symlinks = 2
:let g:ctrlp_working_path_mode = 'r'
"----------------------------------------------------------------------------------



"----------------------------------------------------------------------------------
" @ultisnips
:let g:UltiSnipsExpandTrigger="<Esc>a"
:let g:UltiSnipsListSnippets="<c-u>"
:let g:UltiSnipsJumpForwardTrigger="<c-b>"
:let g:UltiSnipsJumpBackwardTrigger="<c-z>"
:let g:UltiSnipsEditSplit="horizontal"
:let g:UltiSnipsSnippetDirectories=["UltiSnips", "felidadae_snippets"]
:let g:UltiSnipsSnippetsDir="~/.vim/felidadae_snippets"
"----------------------------------------------------------------------------------



"----------------------------------------------------------------------------------
" @easy-motion
map ,. <Plug>(easymotion-prefix)
"----------------------------------------------------------------------------------



"----------------------------------------------------------------------------------
" @autosave plugin options
let g:auto_save = 1
let g:auto_save_no_updatetime = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1
"----------------------------------------------------------------------------------



"----------------------------------------------------------------------------------
" @ycm you complete me ycm to set python version
:let g:ycm_python_binary_path = 'python'
:let g:ycm_global_ycm_extra_conf = '~/Programming/_General/tools/ycm/.ycm_global_conf.py'
"----------------------------------------------------------------------------------



"----------------------------------------------------------------------------------
" @session @vim-session
set sessionoptions-=options
set sessionoptions-=help
set sessionoptions-=buffers
"----------------------------------------------------------------------------------
