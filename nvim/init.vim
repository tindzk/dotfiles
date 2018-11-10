" {{{ Plugins
	call plug#begin('~/.config/nvim/plugged')
	Plug 'KeitaNakamura/neodark.vim'
	Plug 'airblade/vim-gitgutter'
	Plug 'cespare/vim-toml'
	Plug 'cocopon/vaffle.vim'
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'derekwyatt/vim-scala'
	Plug 'dhruvasagar/vim-table-mode', { 'for': ['markdown'] }
	Plug 'itchyny/lightline.vim'
	Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim'
	Plug 'junegunn/vim-easy-align'
	Plug 'justinmk/vim-gtfo'
	Plug 'luochen1990/rainbow'
	Plug 'mhartington/oceanic-next'
	Plug 'mhinz/vim-startify'
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'othree/html5.vim'
	Plug 'reedes/vim-wheel'
	Plug 'ryanoasis/vim-devicons'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'tpope/vim-fugitive'
	Plug 'vim-pandoc/vim-pandoc'
	Plug 'vim-pandoc/vim-pandoc-syntax'
	Plug 'vimwiki/vimwiki'
	Plug 'reasonml-editor/vim-reason-plus'
	Plug 'autozimu/LanguageClient-neovim', {
		\ 'branch': 'next',
		\ 'do': 'bash install.sh',
		\ }
	Plug 'junegunn/fzf'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'romainl/vim-tinyMRU'
	call plug#end()
" }}}
" {{{ General
	" Enable mouse
	set mouse=a

	" Show matching bracket
	set showmatch

	" Toggle paste mode
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

	" Show filename and path in window title
	set title
" }}}
" {{{ Colours
	" Select colour scheme
	" colorscheme asmanian_blood
	" colorscheme bclear
	" colorscheme lucius
	" colorscheme vanzan_color
	" colorscheme molokai
	" colorscheme wombat

	" let g:oceanic_next_terminal_bold   = 1
	" let g:oceanic_next_terminal_italic = 1
	" colorscheme OceanicNext

	let g:neodark#use_256color = 1
	let g:neodark#terminal_transparent = 1
	colorscheme neodark

	if $TERM != ''
		" Transparent background in TUI
		au ColorScheme * hi Normal ctermbg=none guibg=none
	endif

	" Enable support for colours in TUI
	set termguicolors

	" Turn syntax highlighting on
	syntax on

	" Get rid of highlighted text after searching by pressing <F1>
	map <F1> :noh<CR>

	" Underline current line in insert mode.
	autocmd InsertEnter * se cul
	autocmd InsertLeave * se nocul
" }}}
" {{{ Distraction-free writing
	" Also change font and restore default when leaving
	let g:GoyoFont = ''

	function! OnGoyoEnter()
		if exists('g:GuiFont')
			let g:GoyoFont = g:GuiFont
			call GuiWindowFullScreen(1)
			call GuiFont('Ubuntu Mono:h14')
			call GuiLinespace(8)
		endif

		" Only highlight current paragraph
		Limelight
	endfunction

	function! OnGoyoLeave()
		if exists('g:GuiFont')
			call GuiFont(g:GoyoFont)
			call GuiLinespace(0)
			call GuiWindowFullScreen(0)
		endif
		Limelight!
	endfunction

	autocmd! User GoyoEnter call OnGoyoEnter()
	autocmd! User GoyoLeave call OnGoyoLeave()

	" On window resize, if goyo is active, do <c-w>= to resize the window
	" https://github.com/junegunn/goyo.vim/issues/159#issuecomment-342417487
	autocmd VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
" }}}
" {{{ Whitespace characters
	" Show trailing whitepace characters (e.g. spaces, tabs)
	" Provided by vim-better-whitespace
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
			\ { 'd': '~/dev' },
			\ { 'l': '~/dotfiles' }
			\ ]

	let g:startify_session_dir         = '~/.nvim/session'
	let g:startify_change_to_vcs_root  = 1
	let g:startify_fortune_use_unicode = 1
" }}}
" {{{ Rainbow
	let g:rainbow_active = 1
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
		exec ':silent !firefox ' . shellescape(line) . ' &'
	endfunction

	function! BrowserSearch()
		let line = getline(".")
		exec ':silent !firefox "https://www.google.com/search?q=' . shellescape(line) . '" &'
	endfunction

	" Open links in browser
	map <C-space> :call Browser()<CR>

	" Search line in browser
	map <C-g> :call BrowserSearch()<CR>
" }}}
" {{{ Spell checking
	" Specify the dictionaries for use in spell checking
	set spelllang=en,de,pl,fr,uk,ru

	" Keep spell checking disabled by default
	set nospell

	" Toggle spell checking
	inoremap <c-s> <C-o>:set spell! <bar> echo "Spell check: " . (&spell ? "On" : "Off")<CR>
	nnoremap <c-s>      :set spell! <bar> echo "Spell check: " . (&spell ? "On" : "Off")<CR>
" }}}
" {{{ Git
	autocmd FileType gitcommit set textwidth=68
	autocmd FileType gitcommit set spell
" }}}
" {{{ Indention
	set tabstop=2
	set shiftwidth=2
	set softtabstop=2

	autocmd FileType scala set expandtab
" }}}
" {{{ Line breaks
	" Enable word wrapping
	set textwidth=80
	set linebreak
	set showbreak=¶

	" Disable automatic text wrapping
	set formatoptions-=t

	" Show ruler
	set colorcolumn=+1
" }}}
" {{{ Folds
	" Detect folds correctly in this file
	autocmd BufRead *.vim set foldmethod=marker
" }}}
" {{{ Windows
	" Split window vertically with |
	map <Bar> <C-W>v<C-W><Right>

	" Split window horizontally with -
	map - <C-W>s<C-W><Down>
" }}}
" {{{ Tabs
	nnoremap <C-t>c :tabnew<CR>
	nnoremap <C-t>d :tabclose<CR>
	nnoremap <C-t>j :tabprevious<CR>
	nnoremap <C-t>k :tabnext<CR>
	nnoremap <C-t>1 :tabn 1<CR>
	nnoremap <C-t>2 :tabn 2<CR>
	nnoremap <C-t>3 :tabn 3<CR>
	nnoremap <C-t>4 :tabn 4<CR>
	nnoremap <C-t>5 :tabn 5<CR>
	nnoremap <C-t>6 :tabn 6<CR>
	nnoremap <C-t>7 :tabn 7<CR>
	nnoremap <C-t>8 :tabn 8<CR>
	nnoremap <C-t>9 :tabn 9<CR>
" }}}
" {{{ Terminal
	" Exit terminal with Ctrl-w
	tnoremap <C-w> <C-\><C-n>
" }}}
" {{{ Lightline
	" Configuration for vim-devicons
	let g:lightline = {
		\ 'component_function': {
		\   'filetype': 'MyFiletype',
		\   'fileformat': 'MyFileformat',
		\ }
		\ }

	function! MyFiletype()
		return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
	endfunction

	function! MyFileformat()
		return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
	endfunction
" }}}
" {{{ CtrlP
	nnoremap <C-b> :CtrlPBuffer<CR>
" }}}
" {{{ Vimwiki
	set nocompatible
	filetype plugin on
	let g:vimwiki_list = [{'path': '~/Notes/', 'ext': '.txt'}]
	autocmd FileType vimwiki set nonumber
	nmap <leader>- <Plug>VimwikiRemoveHeaderLevel
	nmap <leader>di <Plug>VimwikiDiaryIndex
	nmap <leader>du <Plug>VimwikiDiaryGenerateLinks
	nmap <leader>do <Plug>VimwikiMakeDiaryNote
	nmap <leader>dj <Plug>VimwikiDiaryPrevDay
	nmap <leader>dk <Plug>VimwikiDiaryNextDay
	let g:vimwiki_url_maxsave=0
" }}}
" {{{ gtfo
	let g:gtfo#terminals = { 'unix': 'termite -d' }
" }}}
" {{{ Mails
" Adapted from https://github.com/vim-scripts/Search-in-Addressbook/blob/master/plugin/address-search.vim
fun! CompleteEmails(findstart, base)
	if a:findstart
		let line = getline('.')
		let start = col('.') - 1
		while start > 0 && line[start - 1] =~ '[^:,]'
			let start -= 1
		endwhile
		return start + 1
	else
		let res = []
		for m in split(system('khard email --remove-first-line --parsable ' . shellescape(a:base)), '\n')
			let parts = split(m, '\t')
			if parts[1] == ' '
				call add(res, parts[0])
			else
				call add(res, parts[1] . ' <' . parts[0] . '>')
			endif
		endfor
		return res
	endif
endfun

fun! UserComplete(findstart, base)
	let line = getline(line('.'))
	if line =~ '^\(To\|Cc\|Bcc\|From\|Reply-To\):'
		return CompleteEmails(a:findstart, a:base)
	endif
endfun

autocmd FileType mail set omnifunc=UserComplete
" }}}
" {{{ Clipboard
  " Use system clipboard
  set clipboard+=unnamedplus
" }}}
" {{{ Language client
	let g:LanguageClient_autoStart = 1
	let g:LanguageClient_serverCommands = {
		\ 'reason': ['/home/tim/bin/reason-language-server.exe'],
		\ }
	let g:deoplete#enable_at_startup = 1

	nnoremap <silent> <A-r> :call LanguageClient#textDocument_rename()<CR>
	nnoremap <silent> <cr> :call LanguageClient#textDocument_hover()<cr>
	nnoremap <silent> gd :call LanguageClient#textDocument_definition()<cr>
	nnoremap <silent> gf :call LanguageClient#textDocument_formatting()<cr>
	nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
" }}}
