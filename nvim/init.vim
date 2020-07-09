" {{{ Plugins
	call plug#begin('~/.config/nvim/plugged')

	Plug 'airblade/vim-gitgutter'
	Plug 'itchyny/lightline.vim'
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
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'godlygeek/tabular'
	Plug 'justinmk/vim-sneak'
	Plug 'alvan/vim-closetag'

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

	" Show line numbers
	set number

	" Do not create backup files
	set nobackup

	" Show filename and path in window title
	set title

	" Display completion matches using pop-up menu
	set wildoptions=pum

	" Set transparency for pop-up menus
	set pumblend=20

	" Swap arrow keys in pop-up menu
	cnoremap <expr> <Up>    pumvisible() ? "\<C-p>"  : "\<Up>"
	cnoremap <expr> <Down>  pumvisible() ? "\<C-n>"  : "\<Down>"
	cnoremap <expr> <Left>  pumvisible() ? "\<Up>"   : "\<Left>"
	cnoremap <expr> <Right> pumvisible() ? "\<Down>" : "\<Right>"

	" Save files with Ctrl-s
	noremap  <silent> <C-S> :update<CR>
	vnoremap <silent> <C-S> <C-C>:update<CR>
	inoremap <silent> <C-S> <C-O>:update<CR>

	" Change current working directory
	noremap  <silent> <leader>cd :lcd%:p:h<CR>
	vnoremap <silent> <leader>cd <C-C>:lcd%:p:h<CR>
	inoremap <silent> <leader>cd <C-O>:lcd%:p:h<CR>
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
	colorscheme lucius

	"let g:gruvbox_italic = 1
	"colorscheme gruvbox8

"	if $TERM != ''
"		" Transparent background in TUI
"		au ColorScheme * hi Normal ctermbg=none guibg=none
"	endif

	" Enable support for colours in TUI
	set termguicolors

	" Turn syntax highlighting on
	syntax on

	" Clear search highlights by pressing <Escape>
	map <silent> <Esc> :noh<CR>

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
	nnoremap <silent> <C-t>c :tabnew<CR>
	nnoremap <silent> <C-t>d :tabclose<CR>
	nnoremap <silent> <C-t>j :tabprevious<CR>
	nnoremap <silent> <C-t>k :tabnext<CR>
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
" {{{ Lightline
	" Configuration for vim-devicons
	let g:lightline = {
		\ 'active': {
		\   'left': [ [ 'mode', 'paste' ],
		\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
		\ },
		\ 'component_function': {
		\   'cocstatus': 'coc#status',
		\   'filetype': 'MyFiletype',
		\   'filename': 'MyFilename',
		\   'fileformat': 'MyFileformat'
		\ }
		\ }

	function! MyFiletype()
		return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
	endfunction

	function! MyFilename()
		return fnamemodify(expand("%"), ":~:.")
	endfunction

	function! MyFileformat()
		return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
	endfunction
" }}}
" {{{ Fuzzy Path Matching
	nnoremap <silent> <C-p> :<C-u>FZF<CR>
" }}}
" {{{ Clipboard
	" Use system clipboard
	set clipboard+=unnamedplus

	" Workaround for https://github.com/neovim/neovim/issues/10223
	" From https://github.com/NicholasAsimov/dotfiles/commit/c69b0f513208c9555f139b57d872632a317203bf
	let g:clipboard = {
		  \   'name': 'wayland-strip-carriage',
		  \   'copy': {
		  \      '+': 'wl-copy --foreground --type text/plain',
		  \      '*': 'wl-copy --foreground --type text/plain --primary',
		  \    },
		  \   'paste': {
		  \      '+': {-> systemlist('wl-paste | tr -d "\r"')},
		  \      '*': {-> systemlist('wl-paste --primary | tr -d "\r"')},
		  \   },
		  \   'cache_enabled': 1,
		  \ }
" }}}
" {{{ Language client
	" if hidden is not set, TextEdit might fail.
	set hidden

	" Better display for messages
	set cmdheight=2

	" Smaller updatetime for CursorHold & CursorHoldI
	set updatetime=300

	" don't give |ins-completion-menu| messages.
	set shortmess+=c

	" always show signcolumns
	set signcolumn=yes

	" Use tab for trigger completion with characters ahead and navigate.
	" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
	inoremap <silent><expr> <TAB>
	      \ pumvisible() ? "\<C-n>" :
	      \ <SID>check_back_space() ? "\<TAB>" :
	      \ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	" Show signature
	nnoremap <silent> <expr> <leader>i  CocAction('showSignatureHelp')
	inoremap <silent> <expr> <leader>i  CocAction('showSignatureHelp')

	" Show type
	nnoremap <silent> <expr> t CocAction('doHover')

	function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
	" Coc only does snippet and additional edit on confirm.
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

	" Use `[d` and `]d` for navigate diagnostics
	nmap <silent> [d <Plug>(coc-diagnostic-prev)
	nmap <silent> ]d <Plug>(coc-diagnostic-next)

	nmap <silent> gd            <Plug>(coc-definition)
	nmap <silent> <C-LeftMouse> <Plug>(coc-definition)

	nmap <silent> gD <Plug>(coc-references)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-rename)
	vmap <silent> gf <Plug>(coc-format-selected)
	nmap <silent> gf <Plug>(coc-format-selected)

	" Highlight symbol under cursor on CursorHold
	autocmd CursorHold * silent call CocActionAsync('highlight')

	augroup mygroup
	  autocmd!
	  " Setup formatexpr specified filetype(s).
	  autocmd FileType scala setl formatexpr=CocAction('formatSelected')
	  " Update signature help on jump placeholder
	  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
	vmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	" Remap for do codeAction of current line
	" nmap <leader>ac  <Plug>(coc-codeaction)
	" Fix autofix problem of current line
	" nmap <leader>qf  <Plug>(coc-fix-current)

	" Use `:Format` for format current buffer
	command! -nargs=0 Format :call CocAction('format')

	" Use `:Fold` for fold current buffer
	command! -nargs=? Fold   :call CocAction('fold', <f-args>)

	" Using CocList
	" Show all diagnostics
	nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
	" Manage extensions
	nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
	" Show commands
	nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
	" Find symbol of current document
	nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
	" Search workspace symbols
	nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
	nnoremap <silent> <space>j  :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
	" Resume latest coc list
	nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
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

	autocmd FileType markdown nmap <buffer> <enter> <Plug>Markdown_EditUrlUnderCursor
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
