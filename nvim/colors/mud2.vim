set background=light
hi clear
syntax reset
let g:colors_name="mud"

hi Normal   guifg=#ffffcc	 guibg=#330000 
hi LineNr   guifg=white guibg=#330000 
hi Statusline    gui=none guibg=#993300 guifg=#ffffff
hi StatuslineNC    gui=none guibg=#660000 guifg=#ffffff
hi VertSplit    gui=none guibg=#330000 guifg=#ffffff
hi Cursor    gui=none guibg=DodgerBlue guifg=#ffffff

hi Title    guifg=black	 guibg=white gui=bold
" hi lCursor  guibg=cyan   guifg=none

" syntax highlighting groups
hi Comment    gui=none guifg=#996666
hi Operator   guifg=#ff0000

hi Identifier    guifg=#33ff99 gui=none

hi Statement	 guifg=#cc9966 gui=none
hi TypeDef       guifg=#c000c8 gui=none
hi Type          guifg=#ccffff gui=none
hi Boolean       guifg=#ff00aa gui=none

hi String        guifg=#99ccff gui=none
hi Number        guifg=#66ff66 gui=none
hi Constant      guifg=#f0f000 gui=none

hi Function      gui=none      guifg=#fffcfc 
hi PreProc       guifg=#cc6600 gui=none
hi Define        gui=bold guifg=#f0f0f0 
hi Special       gui=none guifg=#cccccc 
hi BrowseDirectory  gui=none guifg=#FFFF00 

hi Keyword       guifg=#ff8088 gui=none
hi Search        gui=none guibg=#ffff00 guifg=#330000 
hi IncSearch     gui=none guifg=#fcfcfc guibg=#8888ff
hi SpecialKey    gui=none guifg=#fcfcfc guibg=#8888ff
hi NonText       gui=none guifg=#fcfcfc 
hi Directory     gui=none guifg=#999900
