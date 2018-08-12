" {{{ Plugins
	call plug#begin('~/.config/nvim/plugged')
	Plug 'airblade/vim-gitgutter'
	Plug 'cespare/vim-toml'
	Plug 'cocopon/vaffle.vim'
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'derekwyatt/vim-scala'
	Plug 'dhruvasagar/vim-table-mode', { 'for': ['markdown'] }
	Plug 'itchyny/lightline.vim'
	Plug 'junegunn/limelight.vim'
	Plug 'junegunn/vim-easy-align'
	Plug 'justinmk/vim-gtfo'
	Plug 'luochen1990/rainbow'
	Plug 'mhartington/oceanic-next'
	Plug 'mhinz/vim-startify'
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'othree/html5.vim'
	Plug 'reedes/vim-wheel'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'tpope/vim-fugitive'
	Plug 'vim-pandoc/vim-pandoc'
	Plug 'vim-pandoc/vim-pandoc-syntax'
	Plug 'vimwiki/vimwiki'
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
	autocmd FileType pandoc set nonumber

	" Do not create backup files
	set nobackup
" }}}
" {{{ Colours
	" Select colour scheme
	" colorscheme asmanian_blood
	" colorscheme bclear
	" colorscheme lucius
	" colorscheme vanzan_color
	" colorscheme molokai
	" colorscheme wombat

	let g:oceanic_next_terminal_bold   = 1
	let g:oceanic_next_terminal_italic = 1
	colorscheme OceanicNext

	" Turn syntax highlighting on
	syntax on

	" Get rid of highlighted text after searching by pressing <F1>
	map <F1> :noh<CR>

	" Underline current line in insert mode.
	autocmd InsertEnter * se cul
	autocmd InsertLeave * se nocul
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
" {{{ TUI
	" Enable support for colours in TUI
	set termguicolors

	" Use block cursor in normal mode
	set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
" }}}
" {{{ Search
	" See also http://linuxcommando.blogspot.com/2008/06/smart-case-insensitive-incremental.html
	set ignorecase
	set smartcase
	set incsearch

	" Highlight search results
	set hlsearch
" }}}
" {{{ Spell checking
	" Specify the dictionaries for use in spell checking
	"set spelllang=en,de,pl,fr,uk,ru

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
" }}}
""" {{{ gtfo
	let g:gtfo#terminals = { 'unix': 'termite -d' }
""" }}}

