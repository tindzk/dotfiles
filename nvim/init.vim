" {{{ Plugins
	call plug#begin('~/.config/nvim/plugged')
	Plug 'KeitaNakamura/neodark.vim'
	Plug 'airblade/vim-gitgutter'
	Plug 'cespare/vim-toml'
	Plug 'derekwyatt/vim-scala'
	Plug 'dhruvasagar/vim-table-mode', { 'for': ['markdown'] }
	Plug 'itchyny/lightline.vim'
	Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim'
	Plug 'junegunn/vim-easy-align'
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
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
	Plug 'romainl/vim-tinyMRU'
	Plug 'gcavallanti/vim-noscrollbar'
	Plug 'rickhowe/diffchar.vim'
	Plug 'ap/vim-css-color'
	Plug 'machakann/vim-sandwich'
	Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'sgur/vim-editorconfig'
	Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
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

	" Underline current line in insert mode
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
	" Split window vertically with |
	map <Bar> <C-W>v<C-W><Right>

	" Split window horizontally with -
	map - <C-W>s<C-W><Down>

	" Readjust splits when window is resized
	autocmd VimResized * wincmd =
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
		\ 'active': {
		\   'left': [ [ 'mode', 'paste' ],
		\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
		\ },
		\ 'component_function': {
      		\   'cocstatus': 'coc#status',
		\   'filetype': 'MyFiletype',
		\   'fileformat': 'MyFileformat',
		\   'percent': 'NoScrollbarForLightline'
		\ }
		\ }

	" Instead of % show NoScrollbar horizontal scrollbar
	function! NoScrollbarForLightline()
		return noscrollbar#statusline()
	endfunction

	function! MyFiletype()
		return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
	endfunction

	function! MyFileformat()
		return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
	endfunction
" }}}
" {{{ Fuzzy Path Matching
	nnoremap <C-p> :<C-u>FZF<CR>
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
	nmap <Leader>wn <Plug>VimwikiNextLink
	let g:vimwiki_url_maxsave=0
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
" {{{ Defx
  " From https://github.com/kristijanhusak/neovim-config/blob/master/nvim/partials/defx.vim
  autocmd FileType defx call s:defx_mappings()

  function! s:defx_mappings() abort
    nnoremap <silent><buffer><expr> o defx#do_action('drop')
    nnoremap <silent><buffer><expr> <CR> defx#do_action('drop')
    nnoremap <silent><buffer><expr> <2-LeftMouse> defx#do_action('drop')
    nnoremap <silent><buffer><expr> s defx#do_action('open', 'botright vsplit')
    nnoremap <silent><buffer><expr> R defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <Backspace> defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> u defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> nf defx#do_action('new_file')
    nnoremap <silent><buffer><expr> nd defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> c defx#do_action('copy')
    nnoremap <silent><buffer><expr> m defx#do_action('move')
    nnoremap <silent><buffer><expr> p defx#do_action('paste')
    " requires python-send2trash
    nnoremap <silent><buffer><expr> d defx#do_action('remove_trash')
    nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
    nnoremap <silent><buffer><expr> H defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> q defx#do_action('quit')
    nnoremap <silent><buffer><expr> gh defx#do_action('cd', [getcwd()])
    nnoremap <silent><buffer><expr> r defx#do_action('redraw')

    nnoremap <silent><buffer><expr> h
      \ defx#is_directory() ?
      \ defx#do_action('close_tree') : 1
    nnoremap <silent><buffer><expr> l
      \ defx#is_directory() ?
      \ defx#do_action('open_tree') . 'j' : defx#do_action('drop')
    nnoremap <silent><buffer><expr> L
      \ defx#is_directory() ?
      \ defx#do_action('open_tree_recursive') . 'j' : defx#do_action('drop')

    hi link Defx_mark_root Directory
    hi link Defx_mark_directory Directory
  endfunction

  call defx#custom#option('_', {
	\ 'winwidth': 25,
	\ 'split': 'vertical',
	\ 'direction': 'leftabove',
	\ 'show_ignored_files': 0,
	\ 'buffer_name': '',
	\ 'resume': 1
  \ })

  " Open file panel
  nnoremap <silent><Leader>f :call execute('Defx -toggle=1')<CR>

  " Jump to current file
  nnoremap <silent><Leader>cf :call execute(printf('Defx -search=%s %s', expand('%:p'), expand('%:p:h')))<CR>
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
	nnoremap <silent> <expr> <c-i> CocAction('showSignatureHelp')
	inoremap <silent> <expr> <c-i> CocAction('showSignatureHelp')

	" Show type
	nnoremap <silent> <expr> t CocAction('doHover')

	function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
	" Coc only does snippet and additional edit on confirm.
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

	" Use `[c` and `]c` for navigate diagnostics
	nmap <silent> [c <Plug>(coc-diagnostic-prev)
	nmap <silent> ]c <Plug>(coc-diagnostic-next)

	nmap <silent> gd <Plug>(coc-definition)
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
