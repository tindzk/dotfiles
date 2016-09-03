" {{{ Colours and syntax highlighting
	if has("gui_running")
		" Font
		" set guifont=Monaco\ 14
		" set guifont=ProFont\ 8
		" set guifont=Inconsolata\ Medium\ 18
		" set guifont=Monospace\ 10
		" set guifont=Monaco\ 7
		" set guifont=Monaco\ 12
		" set guifont=Droid\ Sans\ Mono\ 10
		" set guifont=MonteCarlo\ 6

		" Disable the blinking cursor
		set guicursor=a:blinkon0

		" Select the color scheme
		" colorscheme asmanian_blood
		" colorscheme bclear
		" colorscheme vanzan_color
		colorscheme bclear

		" GUI options
		" set guioptions=abcegvirLT
	endif

	if ! has("gui_running")
		" Enable support for 256 colors
		set t_Co=256

		" Select the color scheme
		" colorscheme wombat
		" colorscheme asmanian_blood
		" colorscheme bclear

		" Disable mouse
		set mouse=
	endif

	" Turn syntax highlighting on
	syntax on

	" Show trailing whitepace and spaces before a tab
	highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
	match ExtraWhitespace /\s\+$\| \+\ze\t/

	" Show red column indicating line length
	hi ColorColumn ctermbg=5

	" Get rid of highlighted text after searching by pressing <F1>
	map <F1> :noh<CR>
" }}}

" {{{ General
	" Show matching bracket
	set showmatch

	" highlight Special guifg=SlateBlue guibg=GhostWhite
	" nnoremap <F12><Tab>      :syntax match SpecialKey "\t"<CR>
	" inoremap <F12><Tab> <C-O>:syntax match SpecialKey "\t"<CR>

	" Uses color `SpecialKey' to highlight tabs, trailing spaces, etc.
	set lcs=tab:»-,trail:·,eol:¶
	map <F12> :set list!<CR>

	" Toggle paste-mode with <F7>
	set pastetoggle=<F7>

	" Highlight current line in insert mode.
	autocmd InsertEnter * se cul
	autocmd InsertLeave * se nocul

	" Use UTF-8 everywhere
	set enc=utf-8
	set fenc=utf-8
	set termencoding=utf-8

	" Show line numbers
	set number

	" Do not create backup files
	set nobackup

	" Turn off message "Thanks for flying vim"
	" set notitle

	" Show current mode
	set showmode

	" HTML code may contain CSS
	let html_use_css = 1

	" Show the line number in the ruler
	set ruler

	" Lines
	map ,l maH:let x="Shown range: Lines ".line(".")<CR>L:let x=x." - ".line(".")<CR>:echo x<CR>

	" Switch between header and source file
	map ,a <Esc>:A<CR>

	" Highlight variable under cursor
	autocmd CursorMoved * silent! exe printf('match HighlightMatches /\<%s\>/', expand('<cword>'))

	" Show filename in status bar
	set ls=2

	set statusline=%<%f\ %h%w%m%r%y%=L:%l/%L\ (%p%%)\ C:%c%V\ B:%o\ F:%{foldlevel('.')}

	" Change cursor when exiting insert mode
	:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" }}}

" {{{ Search
	" See also http://linuxcommando.blogspot.com/2008/06/smart-case-insensitive-incremental.html
	set ignorecase
	set smartcase
	set incsearch

	" Highlight search results
	set hlsearch

	" Set working directory to current file
	" set autochdir
" }}}

" {{{ Browser
function! Browser()
	let line0 = getline(".")
	let line = matchstr(line0, "http[^ ]*")

	:if line == ""
		let line = matchstr(line0, "ftp[^ ]*")
	:endif

	:if line == ""
		let line = matchstr(line0, "file[^ ]*")
	:endif

	let line = escape(line, "#?&;|%!)")

	exec ':silent !chromium ' . line . ' &'
endfunction

map ,w :call Browser ()<CR>
" }}}

" {{{ Spell checking
	" Specify the dictionaries for use in spell checking
	set spelllang=de,en,pl,fr

	" Keep spell checking disabled by default
	set nospell

	" Toggle spell checking functionality with ,s
	inoremap ,s <C-o>:set spell! <bar> echo "Spell check: " . (&spell ? "On" : "Off")<CR>
	nnoremap ,s :set spell! <bar> echo "Spell check: " . (&spell ? "On" : "Off")<CR>

	" Syntax highlighting
	" map ,s :if has("syntax_items")<CR>syntax off<CR>else<CR>syntax on<CR>endif<CR><CR>
" }}}

" {{{ Git
	autocmd FileType gitcommit set textwidth=68
" }}}

" {{{ Tabs
	" Switch between the last two visited tabs
	autocmd TabLeave * let g:last_tab = tabpagenr()
	imap ,f :execute 'normal '.g:last_tab.'gt'<CR>
	nmap ,f :execute 'normal '.g:last_tab.'gt'<CR>

	" Next tab
	map ,n :tabnext<CR>
	imap ,n <ESC>:tabnext<CR>i
	vmap ,n <ESC>:tabnext<CR>v

	" Previous tab
	map ,p :tabprev<CR>
	imap ,p <ESC>:tabprev<CR>i
	vmap ,p <ESC>:tabprev<CR>v

	" New tab
	map ,c :tabnew
	imap ,c <ESC>":tabnew
	vmap ,c <ESC>":tabnew
" }}}

" {{{ Indention
	set autoindent
	set smartindent

	set tabstop=4
	set shiftwidth=4

	" Enable word wrapping after 80 characters
	set textwidth=80
	set colorcolumn=+1

	" Don't break words
	" Disable automatic text wrapping by leaving out 't'.
	set formatoptions=qwl

	" Automatic formatting of paragraphs
	" set formatoptions+=a

	" Automatic formatting in comments
	" set formatoptions+=c

	set formatoptions+=r

	" Automatically add the current comment leader when hitting Enter (in
	" insert mode) or o/O in normal mode
	set formatoptions+=o

	set linebreak
	set showbreak=¶
" }}}