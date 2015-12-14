hi clear

if exists("syntax_on")
  syntax reset
endif

set background=dark

hi Normal       guifg=#b4b0b0 guibg=#080404 gui=none
hi NonText      guifg=#b4b0b0 guibg=#181414 gui=none
hi SpecialKey   guifg=#b4b0b0 guibg=#282424 gui=bold

hi Comment      guifg=#686460               gui=none
hi Todo         guifg=#c81414 guibg=#080404 gui=bold
hi Search       guifg=#000000 guibg=#f0f000 gui=underline,italic
hi Visual                     guibg=#282020
hi MatchParen   guifg=#ffffff guibg=#904030 gui=none

hi HighlightMatches guifg=#a06050 gui=bold

hi Title        guifg=#ffffff guibg=#202020 gui=underline
hi Underlined   guifg=#b4b0b0               gui=underline

hi CursorColumn guifg=#f4f0f0 guibg=#201c1c gui=none
hi CursorLine   guifg=#f4f0f0 guibg=#201c1c gui=none

hi StatusLine   guifg=#f8e0d0 guibg=#301810 gui=bold
hi StatusLineNC guifg=#503830 guibg=#200800 gui=none
hi VertSplit    guifg=#200800 guibg=#301810 gui=none
hi LineNr       guifg=#848070 guibg=#181414 gui=none
hi Folded       guifg=#484040               gui=bold,italic

hi Define       guifg=#607080               gui=italic
hi Function     guifg=#f4a460               gui=none
hi PreProc      guifg=#a090a0               gui=italic
hi Define       guifg=#806080               gui=italic
hi Identifier   guifg=#c0b060               gui=italic

hi Statement    guifg=#506090               gui=bold
hi Repeat       guifg=#906050               gui=bold
hi Conditional  guifg=#f0dfaf               gui=bold
hi Exception    guifg=#903020               gui=underline

hi String       guifg=#a06050               gui=italic
hi Special      guifg=#a06050               gui=none
hi Number       guifg=orange                gui=none
hi Constant     guifg=#60d060               gui=none

hi ExtraWhitespace guibg=#c81414

" ---
" Taken the following parts from Alan Budden's Bandit colour scheme.
" ---

" Operators (+, =, -, % etc): not defined by default C syntax
hi Operator     guifg=#CCCCFF

" Types/storage classes etc are shades of orangey-red
" hi Type         guifg=#705850 guibg=#080404 gui=bold
hi Type            guifg=#ff8000 guibg=#080404 gui=none
hi StorageClass    guifg=#ff4040 " static, register, volatile, etc.
hi Structure       guifg=#ff8080 " struct, union, enum, etc.

" Special additions created by mktypes.py are shades of Purple or Grey
hi Class              guifg=Purple
hi DefinedName        guifg=#ee82ee
hi EnumerationValue   guifg=#c000c0
hi EnumerationName    guifg=#ff22ff
hi Member             guifg=DarkGrey
hi Union              guifg=Grey
hi LocalVariable      guifg=#c2590e gui=none
hi GlobalVariable     guifg=#c2590e gui=bold
hi GlobalConstant     guifg=#bbbb00

hi! link MoreMsg        Comment
hi! link ErrorMsg       Visual
hi! link WarningMsg     ErrorMsg
hi! link Question       Comment
hi  link Boolean        Number
hi  link Float          Number
hi  link Keyword        Statement
hi  link Typedef        Type
hi  link SpecialComment Special
hi  link Debug          Special
