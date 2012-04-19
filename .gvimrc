" GVIMRC

set background=dark
colorscheme jellybeans
set guioptions-=T  " Hide the tool bar
set guioptions-=rL " Hide scrollbars

" Forcefully disable balloon tooltips
autocmd BufEnter * set noballooneval

" gVim
if has("gui_gtk")
  source $HOME/.vim/gui_gtk.vim
end

" MacVim
if has("gui_macvim")
  source $HOME/.vim/gui_macvim.vim
endif

" VimEnter
if isdirectory(argv(0))
  au VimEnter * :NERDTreeToggle
  au VimEnter * :wincmd p
endif

" Cursor
hi Cursor guifg=black guibg=green
hi iCursor guifg=black guibg=green
set guicursor=a:blinkon0 " turn off cursor blink

" Jellybeans
if g:colors_name == 'jellybeans'
  let g:indent_guides_auto_colors = 0
  hi ColorColumn guibg=#222222
  hi LineNr guibg=#222222
endif
