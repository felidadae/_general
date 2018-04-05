
"----------------------------------------------------------------------------------
" @wipeout
command! -bang Wipeout :call Wipeout(<bang>0)
function! Wipeout(bang)
	" figure out which buffers are visible in any tab
	let visible = {}
	for t in range(1, tabpagenr('$'))
		for b in tabpagebuflist(t)
			let visible[b] = 1
		endfor
	endfor
	" close any buffer that are loaded and not visible
	let l:tally = 0
	let l:cmd = 'bw'
	if a:bang
		let l:cmd .= '!'
	endif
	for b in range(1, bufnr('$'))
		if buflisted(b) && !has_key(visible, b)
			let l:tally += 1
			exe l:cmd . ' ' . b
		endif
	endfor
	echon "Deleted " . l:tally . " buffers"
endfun

:let g:session_autosave = 'no'
"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
"to highlight (["
:let OPTION_NAME = 1
autocmd FileType * call <SID>def_base_syntax() " autocmd Syntax may be better
function! s:def_base_syntax()
	" Simple example
	syntax match commonOperator "\(+\|=\|-\|\^\|\*\)"
	syntax match baseDelimiter ","
	hi link commonOperator Operator
	hi link baseDelimiter Special
endfunction
"----------------------------------------------------------------------------------


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

" function! MyFoldText()
"     let line = getline(v:foldstart)
"     let line = getline(v:foldstart)
"     let line = substitute(l:line, "{", "", "")
"     let lines = 1 + v:foldend - v:foldstart
" 	let i = indent(v:foldstart)
" 	return repeat(' ', i) . "⎨" . "[" . lines . "]" . "⎬"
" endfunction

" function! MyFoldTextCpp()
"     let line = getline(v:foldstart)
"     if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
"         let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
"         let linenum = v:foldstart + 1
"         while linenum < v:foldend
"             let line = getline( linenum )
"             let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2 */', 'g' )
"             if comment_content != ''
"                 break
"             endif
"             let linenum = linenum + 1
"         endwhile
"         let sub = initial . ' ' . comment_content
"     else
"         let sub = line
"         let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
"         if startbrace == '{'
"             let line = getline(v:foldend)
"             let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
"             if endbrace == '}'
"                 let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
"             endif
"         endif
"     endif
"     let n = v:foldend - v:foldstart + 1
"     let info = " " . n . " lines"
"     let sub = "⎨" . sub . "⎬" 
"     let sub = sub . "                                                                                                                                                                                                                                    "
"     let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
"     let fold_w = getwinvar( 0, '&foldcolumn' )
"     let i = indent(v:foldstart)
"     " let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - i - 1 - 1 )
"     return repeat(' ', i) . sub
" endfunction
"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
" @line-length-limit x-st column is magenta if there is a char
autocmd BufNewFile,BufRead *.py highlight ColorColumn ctermbg=magenta
autocmd BufNewFile,BufRead *.py call matchadd('ColorColumn', '\%100v', 100)
"----------------------------------------------------------------------------------
