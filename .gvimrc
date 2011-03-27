" GVIMRC

colorscheme rdark_nk
set background=dark
set guioptions-=T " Hide the tool bar

" gVim
if has("gui_gtk")
  source $HOME/.vim/gui_gtk.vim
end

" MacVim
if has("gui_macvim")
  source $HOME/.vim/gui_macvim.vim
endif

" VimEnter
if argv(0) == '.'
  au VimEnter * :NERDTreeToggle
  au VimEnter * :wincmd p
endif

" Cursor
hi Cursor guifg=black guibg=green
hi iCursor guifg=black guibg=green
set guicursor=a:blinkon0 " turn off cursor blink

" Color columns
hi ColorColumn guibg=#333333
