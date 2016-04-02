Plug 'gcmt/taboo.vim'

let g:taboo_tab_format = ' %N: %f%m '
let g:taboo_renamed_tab_format = ' %N: %l%m '
let g:taboo_unnamed_tab_label = '[No Name]'

" Tabline colors (roughly matches the lightline colours)
autocmd VimEnter,Colorscheme * :hi TabLine guifg=#FFFFFF guibg=#585858 gui=none
autocmd VimEnter,Colorscheme * :hi TabLineFill guibg=#303030 gui=none
autocmd VimEnter,Colorscheme * :hi TabLineSel guifg=#085E0B guibg=#B0DD2C gui=none
