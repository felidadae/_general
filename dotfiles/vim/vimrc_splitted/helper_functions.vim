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
" @line-length-limit x-st column is magenta if there is a char
autocmd BufNewFile,BufRead *.py highlight ColorColumn ctermbg=magenta
autocmd BufNewFile,BufRead *.py call matchadd('ColorColumn', '\%100v', 100)
"----------------------------------------------------------------------------------

"----------------------------------------------------------------------------------
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction
"----------------------------------------------------------------------------------
