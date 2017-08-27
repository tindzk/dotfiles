" {{{ Plugins
	call plug#begin('~/.config/nvim/plugged')
	Plug 'equalsraf/neovim-gui-shim'
	Plug 'airblade/vim-gitgutter'
	Plug 'vim-airline/vim-airline'
	Plug 'derekwyatt/vim-scala'
	Plug 'luochen1990/rainbow'
	Plug 'junegunn/vim-easy-align'
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'tpope/vim-eunuch'
	Plug 'cocopon/vaffle.vim'
	Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim'
	Plug 'itchyny/vim-cursorword'
	Plug 'mhinz/vim-startify'
	call plug#end()
" }}}

" {{{ Colours and syntax highlighting
	" Select colour scheme
	" colorscheme asmanian_blood
	" colorscheme bclear
	" colorscheme lucius
	" colorscheme vanzan_color
	" colorscheme molokai
	colorscheme wombat

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

" {{{ Distraction-free writing
	" Enter distraction-free mode with :Goyo

	" Only highlight current paragraph with Limelight
	" Also change font and restore default when leaving
	let g:goyo_font = ''

	function! OnGoyoEnter()
		if exists('g:GuiFont')
			let g:goyo_font = g:GuiFont
			call GuiFont('Ubuntu Mono:h14')
		endif
		Limelight
	endfunction

	function! OnGoyoLeave()
		if exists('g:GuiFont')
			call GuiFont(g:goyo_font)
		endif
		Limelight!
	endfunction

	autocmd! User GoyoEnter call OnGoyoEnter()
	autocmd! User GoyoLeave call OnGoyoLeave()
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

" {{{ Startify
	let g:startify_list_order = [
		\ ['Bookmarks:'],
		\ 'bookmarks',
		\ ['Open recent files:'],
		\ 'files',
		\ ['Sessions:'],
		\ 'sessions'
		\ ]

	let g:startify_bookmarks = [
			\ { 'n': '~/Notes' },
			\ { 'w': '~/Notes/Work.txt' },
			\ { 'd': '~/dev' },
			\ { 'l': '~/dotfiles' }
			\ ]

	let g:startify_fortune_use_unicode = 1
	let g:startify_change_to_vcs_root  = 1
	let g:startify_session_persistence = 1
" }}}

" {{{ Rainbow
	let g:rainbow_active = 1
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
" }}}

" {{{ TUI
	" Enable support for colours in TUI
	set termguicolors

	" Use block cursor in normal mode
	set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

	" Disable mouse in TUI; will be overridden in ginit.vim
	set mouse=
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
	map <c-n> :tabnew %:p:h<CR>
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
