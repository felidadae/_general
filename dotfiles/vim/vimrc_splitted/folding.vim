"----------------------------------------------------------------------------------
" @folding
" set foldmethod=indent
" autocmd Filetype cpp set foldmethod=syntax
" autocmd Filetype python set foldmethod=indent
" set foldtext=MyFoldText()
" autocmd Filetype cpp set foldtext=MyFoldTextCpp()
" autocmd Filetype python set foldtext=MyFoldText()
" autocmd Filetype todo hi Folded ctermfg=11
" hi Folded ctermfg=11

function! MyFoldText()
    let line = getline(v:foldstart)
    let line = getline(v:foldstart)
    let line = substitute(l:line, "{", "", "")
    let lines = 1 + v:foldend - v:foldstart
	let i = indent(v:foldstart)
	let cline = substitute(line, '^\s*\(.\{-}\)\s*$', '\1', '')
	
	if cline =~ '\/'
		let cline = "comment";
	endif

	return repeat(' ', i) . "⎨" . cline . "⎬"
endfunction

function! MyFoldTextCpp()
    let line = getline(v:foldstart)
    if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
        let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
        let linenum = v:foldstart + 1
        while linenum < v:foldend
            let line = getline( linenum )
            let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2 */', 'g' )
            if comment_content != ''
                break
            endif
            let linenum = linenum + 1
        endwhile
        let sub = initial . ' ' . comment_content
    else
        let sub = line
        let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
        if startbrace == '{'
            let line = getline(v:foldend)
            let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
            if endbrace == '}'
                let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
            endif
        endif
    endif
    let n = v:foldend - v:foldstart + 1
    let info = " " . n . " lines"
    let sub = "⎨" . sub . "⎬" 
    let sub = sub . "                                                                                                                                                                                                                                    "
    let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
    let fold_w = getwinvar( 0, '&foldcolumn' )
    let i = indent(v:foldstart)
    " let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - i - 1 - 1 )
    return repeat(' ', i) . sub
endfunction

set foldtext=MyFoldText()

set foldmethod=indent
set foldlevelstart=20
autocmd BufNewFile,BufRead *.py set foldmethod=indent
autocmd BufNewFile,BufRead *.cpp set foldmethod=syntax
