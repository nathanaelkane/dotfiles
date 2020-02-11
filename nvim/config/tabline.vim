Plug 'gcmt/taboo.vim'

let g:taboo_tab_format = ' %N: %f%m '
let g:taboo_renamed_tab_format = ' %N: %l%m '
let g:taboo_unnamed_tab_label = '[No Name]'

" Tabline colors (roughly matches the lightline colours)
autocmd VimEnter,Colorscheme * :hi TabLine guifg=#FFFFFF guibg=#585858 gui=none
autocmd VimEnter,Colorscheme * :hi TabLineFill guibg=#303030 gui=none
autocmd VimEnter,Colorscheme * :hi TabLineSel guifg=#085E0B guibg=#B0DD2C gui=none

noremap [t :tabprevious<CR>
noremap ]t :tabnext<CR>
noremap [T :tabfirst<CR>
noremap ]T :tablast<CR>
noremap <leader>` :tabnew<CR>
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
