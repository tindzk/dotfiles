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
	Plug 'mhinz/vim-startify'
	Plug 'dhruvasagar/vim-table-mode', { 'for': ['markdown'] }
	Plug 'vim-pandoc/vim-pandoc'
	Plug 'vim-pandoc/vim-pandoc-syntax'
	Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
	Plug 'mhartington/oceanic-next'
	Plug 'ryanoasis/vim-devicons'
	Plug 'othree/html5.vim'
	Plug 'cespare/vim-toml'
	Plug 'vimoutliner/vimoutliner'
	call plug#end()
" }}}

" {{{ Colours and syntax highlighting
	" Select colour scheme
	" colorscheme asmanian_blood
	" colorscheme bclear
	" colorscheme lucius
	" colorscheme vanzan_color
	" colorscheme molokai
	" colorscheme wombat

	let g:oceanic_next_terminal_bold = 1
	let g:oceanic_next_terminal_italic = 1
	let g:airline_theme='oceanicnext'
	colorscheme OceanicNext

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
			call GuiWindowFullScreen(1)
			call GuiFont('Ubuntu Mono:h14')
			call GuiLinespace(8)
			call Goyo('80x85%')  " Force recalculating as we changed the dimensions
		endif
		Limelight
	endfunction

	function! OnGoyoLeave()
		if exists('g:GuiFont')
			call GuiFont(g:goyo_font)
			call GuiLinespace(0)
			call GuiWindowFullScreen(0)
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
			\ { 'd': '~/dev' },
			\ { 'l': '~/dotfiles' }
			\ ]

	let g:startify_fortune_use_unicode = 1
	let g:startify_change_to_vcs_root  = 1
	let g:startify_session_persistence = 1
	let g:startify_session_dir = '~/.nvim/session'
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

	" Better auto-completion
	set wildmenu
	set wildmode=longest:list,full
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

		exec ':silent !firefox ' . line . ' &'
	endfunction

	function! BrowserSearch()
		let line = getline(".")
		exec ':silent !firefox "https://www.google.de/search?q=' . line . '" &'
	endfunction

	" Open links in browser by pressing <Ctrl> + o
	map <c-o> :call Browser ()<CR>

	" Search line in browser by pressing <Ctrl> + g
	map <c-g> :call BrowserSearch ()<CR>
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
	autocmd FileType gitcommit set spell
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

" {{{ Folds
  " Collapse all folds in VimOutliner files by default
  autocmd BufRead *.otl normal zM
" }}}

" {{{ Markdown
	" Enable table formatting with :TableModeEnable
	let g:pandoc#modules#disabled = ["folding"]
" }}}

" {{{ LeaderF
	let g:Lf_ShortcutF  = '<C-F>'
	let g:Lf_ShortcutB  = '<C-B>'
	let g:Lf_CommandMap = {'<C-C>': ['<Esc>', '<C-C>']}
	map <c-m> :LeaderfMru<CR>
" }}}

" {{{ Buffers
	" See https://vi.stackexchange.com/questions/2768/how-do-you-open-a-new-buffer-in-the-current-window
	set hidden

	" Default key combinations listed here:
	" http://codeincomplete.com/posts/split-windows-and-tabs-in-vim/

	"nnoremap <S-Tab> :bprev!<CR>

	" Switch panes with <Tab>
	map <Tab> <C-W>w

	" Split window vertically with |
	map <Bar> <C-W>v<C-W><Right>

	" Split window horizontally with -
	map - <C-W>s<C-W><Down>

	" Cycle buffers with <Shift> + <Tab>
	nnoremap <S-Tab> :bnext!<CR>

	" New buffer with <Ctrl> + n
	nnoremap <C-N> :ene<CR>

	" New buffer with <Ctrl> + q
	nnoremap <C-Q> :bdelete<CR>
" }}}

" {{{ Airline
	" Enable the list of buffers
	let g:airline#extensions#tabline#enabled = 1

	" Show just the filename
	let g:airline#extensions#tabline#fnamemod = ':t'
" }}}

" {{{ Terminal
	" Exit terminal with Ctrl-w
	tnoremap <C-w> <C-\><C-n>
" }}}
