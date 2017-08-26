" {{{ Plugins
	call plug#begin('~/.config/nvim/plugged')
	Plug 'equalsraf/neovim-gui-shim'
	Plug 'airblade/vim-gitgutter'
	Plug 'vim-airline/vim-airline'
	Plug 'derekwyatt/vim-scala'
	Plug 'luochen1990/rainbow'
	Plug 'Shougo/unite.vim'
	Plug 'Shougo/vimfiler.vim'
	Plug 'junegunn/vim-easy-align'
	Plug 'ntpeters/vim-better-whitespace'
	call plug#end()

	let g:rainbow_active = 1
" }}}

" {{{ Colours and syntax highlighting
	if !has("gui_running")
		" Enable support for 256 colors
		set t_Co=256

		" Select the color scheme
		" colorscheme wombat
		" colorscheme asmanian_blood
		" colorscheme bclear
		" colorscheme vanzan_color

		" Disable mouse
		set mouse=
	endif

	" Turn syntax highlighting on
	syntax on

	" Show red column indicating line length
	hi ColorColumn ctermbg=5

	" Get rid of highlighted text after searching by pressing <F1>
	map <F1> :noh<CR>

	" Underline current line in insert mode.
	autocmd InsertEnter * se cul
	autocmd InsertLeave * se nocul
" }}}

" {{{ Whitespace characters
	" Show trailing whitepace characters (e.g. spaces, tabs)
	" Can be removed with :StripWhitespace
	" Feature provided by vim-better-whitespace
	highlight ExtraWhitespace ctermbg=darkred guibg=darkred

	" Highlight tabs and EOL when pressing F12
	set lcs=tab:»-,trail:·,eol:¶
	map <F12> :set list!<CR>
" }}}

" {{{ Vimfiler
	let g:vimfiler_as_default_explorer = 1

	" Open Vimfiler	explorer when no arguments were specified
	autocmd VimEnter * if !argc() | VimFilerExplorer | endif

	" Close NeoVim if the only window left open is a vimfiler buffer
	autocmd BufEnter * if (!has('vim_starting') && winnr('$') == 1
		\ && &filetype ==# 'vimfiler') | quit | endif
" }}}

" {{{ General
	" Show matching bracket
	set showmatch

	" Toggle paste-mode with <F7>
	set pastetoggle=<F7>

	" Incremental substitutions
	set inccommand=split

	" Use UTF-8 everywhere
	set enc=utf-8
	set fenc=utf-8
	set termencoding=utf-8

	" Show line numbers
	set number

	" Do not create backup files
	set nobackup

	" Show the line number in the ruler
	set ruler

	" Change cursor when exiting insert mode
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" }}}

" {{{ Search
	" See also http://linuxcommando.blogspot.com/2008/06/smart-case-insensitive-incremental.html
	set ignorecase
	set smartcase
	set incsearch

	" Highlight search results
	set hlsearch
" }}}

" {{{ Browser
	function! Browser()
		let line0 = getline(".")
		let line = matchstr(line0, "http[^ ]*")

		if line == ""
			let line = matchstr(line0, "ftp[^ ]*")
		endif

		if line == ""
			let line = matchstr(line0, "file[^ ]*")
		endif

		let line = escape(line, "#?&;|%!)")

		exec ':silent !chromium ' . line . ' &'
	endfunction

	" Open links in browser by pressing <Ctrl-o>
	map <c-o> :call Browser ()<CR>
" }}}

" {{{ Spell checking
	" Specify the dictionaries for use in spell checking
	set spelllang=de,en,pl,fr,uk,ru

	" Keep spell checking disabled by default
	set nospell

	" Toggle spell checking with <Ctrl-s>
	inoremap <c-s> <C-o>:set spell! <bar> echo "Spell check: " . (&spell ? "On" : "Off")<CR>
	nnoremap <c-s>      :set spell! <bar> echo "Spell check: " . (&spell ? "On" : "Off")<CR>
" }}}

" {{{ Git
	autocmd FileType gitcommit set textwidth=68
" }}}

" {{{ Tabs
	" Switch between the last two visited tabs with <Ctrl-Tab>
	let g:last_tab = 0
	autocmd TabLeave * let g:last_tab = tabpagenr()
	" Terminal
	nmap <c-i>   :execute 'normal '.g:last_tab.'gt'<CR>
	" GUI
	nmap <c-tab> :execute 'normal '.g:last_tab.'gt'<CR>

	" New tab
	map <c-n> :tabnew<CR>
" }}}

" {{{ Indention and line breaks
	set tabstop=2
	set shiftwidth=2
	set softtabstop=2

	autocmd FileType scala set expandtab

	set autoindent
	set smartindent

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
