" {{{ Plugins
	call plug#begin('~/.config/nvim/plugged')

	Plug 'airblade/vim-gitgutter'
	Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim'
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'luochen1990/rainbow'
	Plug 'lambdalisue/session.vim'
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'ryanoasis/vim-devicons'
	Plug 'rickhowe/diffchar.vim'
	Plug 'sgur/vim-editorconfig'
	Plug 'tomtom/tcomment_vim'
	Plug 'godlygeek/tabular'
	Plug 'justinmk/vim-sneak'
	Plug 'alvan/vim-closetag'
	Plug 'sbdchd/neoformat'
	Plug 'tpope/vim-eunuch'

	" Colour schemes
	Plug 'KeitaNakamura/neodark.vim'
	Plug 'mhartington/oceanic-next'
	Plug 'lifepillar/vim-gruvbox8'
	Plug 'jonathanfilip/vim-lucius'
	Plug 'vim-scripts/bclear'

	Plug 'norcalli/nvim-colorizer.lua'

	" Language support
	Plug 'cespare/vim-toml'
	Plug 'othree/html5.vim'
	Plug 'derekwyatt/vim-scala'
	Plug 'plasticboy/vim-markdown'
	Plug 'chrisbra/csv.vim'
	Plug 'lervag/vimtex'
	Plug 'rust-lang/rust.vim'

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

	" Do not create backup files
	set nobackup

	" Show filename and path in window title
	set title

	" Display completion matches using pop-up menu
	set wildoptions=pum

	" Set transparency for pop-up menus
	set pumblend=20

	" Save files with Ctrl-s
	noremap  <silent> <C-S> :update<CR>
	vnoremap <silent> <C-S> <C-C>:update<CR>
	inoremap <silent> <C-S> <C-O>:update<CR>

	" Change current working directory
	noremap  <silent> <leader>cd :lcd%:p:h<CR>
	vnoremap <silent> <leader>cd <C-C>:lcd%:p:h<CR>
	inoremap <silent> <leader>cd <C-O>:lcd%:p:h<CR>

	" Edit nvim configuration
	nnoremap <silent> <leader>vi :tabnew ~/dotfiles/nvim/init.vim<cr>

	" Jump back and fourth between buffers
	nnoremap H <C-o><CR>
	nnoremap L <C-i><CR>

	" Detect file changes
	" From https://github.com/neovim/neovim/issues/1936
	set autoread
	au FocusGained * :checktime
" }}}
" {{{ Colours
	" Select colour scheme

	" let g:oceanic_next_terminal_bold   = 1
	" let g:oceanic_next_terminal_italic = 1
	" colorscheme OceanicNext

	" let g:neodark#use_256color = 1
	" let g:neodark#terminal_transparent = 1
	" colorscheme neodark

	" colorscheme bclear

	" let g:gruvbox_italic = 1
	" colorscheme gruvbox8

	colorscheme lucius

	" if $TERM != ''
	" 	" Transparent background in TUI
	" 	au ColorScheme * hi Normal ctermbg=none guibg=none
	" endif

	" Enable support for colours in TUI
	set termguicolors

	" Turn syntax highlighting on
	syntax on

	" Clear search highlights by pressing <Escape>
	nnoremap <silent> <Esc> :noh<CR>

	" Underline current line in insert mode
	autocmd InsertEnter * se cul
	autocmd InsertLeave * se nocul

	" Highlight CSS colours
	lua require'colorizer'.setup()
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
" {{{ Sessions
	let g:session_dir = '~/.cache/nvim/sessions'
	cnoreabbrev So SessionOpen
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
	inoremap <silent> <c-c> <C-o>:set spell! <bar> echo "Spell check: " . (&spell ? "On" : "Off")<CR>
	nnoremap <silent> <c-c>      :set spell! <bar> echo "Spell check: " . (&spell ? "On" : "Off")<CR>

	autocmd FileType gitcommit set spell
" }}}
" {{{ Line breaks
	" Enable word wrapping
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
	" Open new split panes to right and bottom, which feels more natural
	set splitbelow
	set splitright

	" Split window vertically with |
	map <Bar> <C-W>v<C-W><Right>

	" Split window horizontally with _
	map _ <C-W>s<C-W><Down>

	" Readjust splits when window is resized
	autocmd VimResized * wincmd =
" }}}
" {{{ Tabs
	nnoremap <silent> <C-t>n :tabnew<CR>
	nnoremap <silent> <C-t>d :tabclose<CR>
	nnoremap <silent> <C-t>h :tabprevious<CR>
	nnoremap <silent> <C-t>l :tabnext<CR>
	nnoremap <silent> <C-t>1 :tabn 1<CR>
	nnoremap <silent> <C-t>2 :tabn 2<CR>
	nnoremap <silent> <C-t>3 :tabn 3<CR>
	nnoremap <silent> <C-t>4 :tabn 4<CR>
	nnoremap <silent> <C-t>5 :tabn 5<CR>
	nnoremap <silent> <C-t>6 :tabn 6<CR>
	nnoremap <silent> <C-t>7 :tabn 7<CR>
	nnoremap <silent> <C-t>8 :tabn 8<CR>
	nnoremap <silent> <C-t>9 :tabn 9<CR>
" }}}
" {{{ Terminal
	" Exit terminal with Ctrl-w
	tnoremap <silent> <C-w> <C-\><C-n>
" }}}
" {{{ Fuzzy Path Matching
	nnoremap <silent> <C-p> :<C-u>FZF<CR>
" }}}
" {{{ Clipboard
	" Use system clipboard
	set clipboard+=unnamedplus

	" Workaround from https://github.com/neovim/neovim/issues/10223
	if exists('$WAYLAND_DISPLAY')
		" clipboard on wayland with newline fix
		let g:clipboard = {
			\   'name': 'WL-Clipboard with ^M Trim',
			\   'copy': {
			\      '+': 'wl-copy --foreground --type text/plain',
			\      '*': 'wl-copy --foreground --type text/plain --primary',
			\    },
			\   'paste': {
			\      '+': {-> systemlist('wl-paste --no-newline --type "text/plain;charset=utf-8" 2>/dev/null | sed -e "s/\r$//"', '', 1)},
			\      '*': {-> systemlist('wl-paste --no-newline --type "text/plain;charset=utf-8" --primary 2>/dev/null | sed -e "s/\r$//"', '', 1)},
			\   },
			\   'cache_enabled': 1,
			\ }
	endif
" }}}
" {{{ Markdown
	let g:vim_markdown_math = 1
	let g:vim_markdown_toml_frontmatter = 1
	let g:vim_markdown_new_list_item_indent = 0
	let g:vim_markdown_edit_url_in = 'vsplit'
	let g:vim_markdown_toc_autofit = 1
	let g:vim_markdown_follow_anchor = 1

	" See https://github.com/plasticboy/vim-markdown/issues/414
	let g:vim_markdown_folding_disabled = 1
" }}}
" {{{ vim-closetag
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'"
" }}}
" {{{ Language support
	" From http://vim.1045645.n5.nabble.com/set-iminsert-why-global-not-local-td5729890.html
	inoremap <silent> <expr> <S-Tab> &keymap == ""
		\ ? '<C-o>:setlocal keymap=ru<CR>'
		\ : '<C-o>:setlocal keymap=<CR>'
" }}}
" {{{ Status line
	" From https://github.com/haorenW1025/dotfiles/blob/master/nvim/config/status-line.vim
	function! InactiveLine()
		return luaeval("require'status-line'.inActiveLine()")
	endfunction

	function! ActiveLine()
		return luaeval("require'status-line'.activeLine()")
	endfunction

	" Change status line automatically
	augroup Statusline
	  autocmd!
	  autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveLine()
	  autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveLine()
	augroup END

	function! TabLine()
		return luaeval("require'status-line'.TabLine()")
	endfunction

	set tabline=%!TabLine()
" }}}
" {{{ Octave
	let s:octaveJob    = -1
	let s:octaveWindow = -1

	" Adapted from https://gist.github.com/ram535/b1b7af6cd7769ec0481eb2eed549ea23
	function! RunOctave(name)
		if win_gotoid(s:octaveWindow)
			bd! Octave
		end
		" Create new named window
		new octave
		" Move window to new tab
		wincmd T
		"vertical resize 80
		let s:octaveJob    = termopen('octave ' . a:name, { 'detach': 1 })
		let s:octaveWindow = win_getid()
		" Rename the buffer
		silent file Octave
		" Go to next tab
		execute "normal 1gt"
	endfunction

	autocmd FileType matlab nnoremap <silent> <F8> :w<cr>:call RunOctave(expand('%'))<cr>
	autocmd FileType matlab inoremap <silent> <F8> <esc>:w<cr>:call RunOctave(expand('%'))<cr>
" }}}
" {{{ Font settings
	let g:Font         = 'Ubuntu\ Mono'
	let g:FontSize     = 16
	let g:FontSizeMin  = 12
	let g:FontSizeIncr = 2

	function! FontChange()
		let g:guifont = g:Font . ':h' . g:FontSize
		execute 'set' 'guifont=' . g:guifont
	endfunction

	call FontChange()

	function! FontSizeDecr()
		if g:FontSize > g:FontSizeMin
			let g:FontSize = g:FontSize - g:FontSizeIncr
			call FontChange()
		endif
	endfunction

	function! FontSizeIncr()
		let g:FontSize = g:FontSize + g:FontSizeIncr
		call FontChange()
	endfunction

	map <C-=> :call FontSizeIncr()<CR>
	map <C--> :call FontSizeDecr()<CR>
" }}}
" {{{ vimtex
	let g:tex_flavor = 'latex'
" }}}
