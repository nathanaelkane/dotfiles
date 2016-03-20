runtime colors/clear_colors_light.vim

let colors_name = 'clear_colors_light_nate'

let g:indent_guides_auto_colors = 0
hi IndentGuidesEven ctermbg=255 guibg=#EEEEEE
hi IndentGuidesOdd ctermbg=NONE guibg=NONE

hi GitGutterAdd ctermbg=254 ctermfg=107 guibg=#E4E4E4 guifg=#87AF5F
hi GitGutterChange ctermbg=254 ctermfg=173 guibg=#E4E4E4 guifg=#D7875F
hi GitGutterDelete ctermbg=254 ctermfg=167 guibg=#E4E4E4 guifg=#D75F5F
hi GitGutterChangeDelete ctermbg=254 ctermfg=139 guibg=#E4E4E4 guifg=#AF8787

hi link EasyMotionTarget Number
hi link EasyMotionShade Comment
hi link EasyMotionTarget2First Constant
hi link EasyMotionTarget2Second Constant

hi diffAdded ctermfg=DarkGreen guifg=#005F00
hi diffRemoved ctermfg=DarkRed guifg=#5F0000
