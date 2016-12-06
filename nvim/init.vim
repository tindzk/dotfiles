" {{{ Plugins
	call plug#begin('~/.config/nvim/plugged')
	Plug 'scrooloose/nerdtree'
	Plug 'jistr/vim-nerdtree-tabs'
	Plug 'airblade/vim-gitgutter'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'derekwyatt/vim-scala'
	Plug 'ensime/ensime-vim'
	Plug 'luochen1990/rainbow'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'Shougo/echodoc'
	call plug#end()

	let g:rainbow_active                        = 1
	let g:nerdtree_tabs_open_on_console_startup = 1
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

	" Show trailing whitepace and spaces before a tab
	highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
	match ExtraWhitespace /\s\+$\| \+\ze\t/

	" Show red column indicating line length
	hi ColorColumn ctermbg=5

	" Get rid of highlighted text after searching by pressing <F1>
	map <F1> :noh<CR>

	" Highlight current line in insert mode.
	autocmd InsertEnter * se cul
	autocmd InsertLeave * se nocul

	" Highlight variable under cursor
	autocmd CursorMoved * silent! exe printf('match HighlightMatches /\<%s\>/', expand('<cword>'))
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
	set spelllang=de,en,pl,fr,uk,ru

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

" {{{ Scala
	" See https://github.com/ensime/ensime-vim/issues/282
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#omni#input_patterns={}
	let g:deoplete#omni#input_patterns.scala = [
	  \ '[^. *\t]\.\w*',
	  \ '[:\[,] ?\w*',
	  \ '^import .*'
	  \]

	autocmd FileType scala,java
		\ nnoremap <buffer> <silent> <LocalLeader>t :EnType<CR>             |
		\ nnoremap <buffer> <silent> <LocalLeader>T :EnTypeCheck<CR>        |
		\ nnoremap <buffer> <silent> gb             :e#<CR>                 |
		\ nnoremap <buffer> <silent> gd             :EnDeclaration<CR>      |
		\ nnoremap <buffer> <silent> gD             :EnDeclarationSplit<CR> |
		\ nnoremap <buffer> <silent> <LocalLeader>i :EnSuggestImport<CR>    |
		\ nnoremap <buffer> <silent> <LocalLeader>r :EnRename<CR>           |
		\ inoremap                   <S-Tab>        <C-x><C-o>
" }}}
