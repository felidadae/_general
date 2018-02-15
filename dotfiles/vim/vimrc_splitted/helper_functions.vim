
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
set foldmethod=indent
set foldtext=MyFoldText()
function! MyFoldText()
	let i = indent(v:foldstart)
	return repeat(' ', i) . "----Folded----" 
endfunction
set foldlevel=3
"----------------------------------------------------------------------------------


"----------------------------------------------------------------------------------
" @line-length-limit x-st column is magenta if there is a char
autocmd BufNewFile,BufRead *.py highlight ColorColumn ctermbg=magenta
autocmd BufNewFile,BufRead *.py call matchadd('ColorColumn', '\%100v', 100)
"----------------------------------------------------------------------------------
