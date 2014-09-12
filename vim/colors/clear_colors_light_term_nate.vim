runtime colors/clear_colors_light.vim

let colors_name = 'clear_colors_light_term_nate'

let g:indent_guides_auto_colors = 0
hi IndentGuidesEven ctermbg=255
hi IndentGuidesOdd ctermbg=NONE

hi GitGutterAdd ctermbg=254 ctermfg=107
hi GitGutterChange ctermbg=254 ctermfg=173
hi GitGutterDelete ctermbg=254 ctermfg=167
hi GitGutterChangeDelete ctermbg=254 ctermfg=139

hi link EasyMotionTarget Number
hi link EasyMotionShade Comment
hi link EasyMotionTarget2First Constant
hi link EasyMotionTarget2Second Constant

hi diffAdded ctermfg=DarkGreen
hi diffRemoved ctermfg=DarkRed
