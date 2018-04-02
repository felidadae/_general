"----------------------------------------------------------------------------------
" @Plugins
source ~/.vim/vimrc_splitted/plugins.vim
"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
" @must-be-on-top
" @powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

set tabline=%!tabber#TabLine()
"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
" @encoding @indent @general
source ~/.vim/vimrc_splitted/general_settings.vim
"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
" @plugin-settings
source ~/.vim/vimrc_splitted/plugins_settings.vim
"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
" @mappings
source ~/.vim/vimrc_splitted/mappings.vim
"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
" @helper functions
source ~/.vim/vimrc_splitted/helper_functions.vim
"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
" @must-be-on-end

:highlight nontext ctermfg=bg 
:hi folded term=none cterm=none ctermfg=none ctermbg=none
:hi Normal ctermbg=none
:hi foldcolumn ctermbg=none
:set fillchars="fold: " 
" :set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
:autocmd Filetype html setlocal ts=2 sw=2 expandtab
:autocmd Filetype htmldjango setlocal ts=2 sw=2 expandtab
:autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
:autocmd FileType java setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
:autocmd FileType cpp setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
:autocmd FileType javascript setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
:autocmd FileType sh setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
:autocmd Filetype typescript setlocal ts=2 sw=2 expandtab

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif
:highlight clear SignColumn
"----------------------------------------------------------------------------------
