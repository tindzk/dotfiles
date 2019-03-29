GuiTabline 0

let g:Font         = 'Ubuntu Mono'
let g:FontSize     = 10
let g:FontSizeMin  = 6
let g:FontSizeIncr = 2

call GuiFont(g:Font . ':h' . g:FontSize)

function! FontSizeDecr()
	if g:FontSize > g:FontSizeMin
		let g:FontSize = g:FontSize - g:FontSizeIncr
		call GuiFont(g:Font . ':h' . g:FontSize)
	endif
endfunction

function! FontSizeIncr()
	let g:FontSize = g:FontSize + g:FontSizeIncr
	call GuiFont(g:Font . ':h' . g:FontSize)
endfunction

map <C-=> :call FontSizeIncr()<CR>
map <C--> :call FontSizeDecr()<CR>

" Paste with <Shift> + <Insert>
imap <S-Insert> <C-R>*
