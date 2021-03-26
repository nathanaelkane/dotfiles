runtime colors/palenight.vim

let colors_name = 'palenight_nate'
let g:lightline.colorscheme = 'palenight'
let g:indent_blankline_char_highlight = 'SpecialKey'

hi LineNr guibg=#242836
hi SignColumn guibg=#242836

hi DiffText guifg=#292D3E guibg=#82B1FF " changed text within a changed line
hi DiffChange guifg=NONE guibg=NONE " changed line

hi ALEErrorSign guifg=#ff5370 guibg=#242836
hi ALEWarningSign guifg=#ffcb6b guibg=#242836

hi GitGutterAdd guifg=#c3e88d guibg=#242836
hi GitGutterChange guifg=#ffcb6b guibg=#242836
hi GitGutterDelete guifg=#ff5370 guibg=#242836
hi GitGutterChangeDelete guifg=#ffcb6b guibg=#242836
