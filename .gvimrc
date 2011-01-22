" GUI
"-------------------------------------------------
if has("gui_running")
  colorscheme bclear
  set background=light
  set guioptions-=T " Hide the tool bar
end

" GNOME GUI
"-------------------------------------------------
if has("gui_gtk")
  set guifont=DejaVu\ Sans\ Mono\ 9

  " Ack Plugin Settings
  let g:ackprg="ack-grep -H --nocolor --nogroup --column"

  " Command-T
  nmap <silent> <leader>t :CommandT<CR>
end

" MAC OSX GUI
"-------------------------------------------------
if has("gui_macvim")
  set guifont=DejaVu\ Sans\ Mono:h13

  " PeepOpen - stop Cmd-T from opening a new tab
  macmenu &File.New\ Tab key=<nop>
  map <unique> <silent> <D-t> <Plug>PeepOpen

  " Stop Cmd+W from closing window
  macmenu &File.Close key=<nop>
  map <unique> <silent> <D-w> :BD<CR>

  " Stop Cmd+Shift+W from closing vim
  macmenu &File.Close\ Window key=<nop>

  " Fullscreen
  set lines=100
  set columns=300
  au GUIEnter * set fullscreen

  " Using set lines= & set columns= instead of set fuoptions=
  " This is because maxvert and maxhorz don't always calculate correctly
  " set fuoptions=maxvert,maxhorz
endif

" CUSTOMISE THE COLORSCHEME
"-------------------------------------------------
hi Cursor guifg=black guibg=green
hi iCursor guifg=black guibg=green
set guicursor=a:blinkon0 " turn off cursor blink

" PERFORM SOME ACTIONS WHEN ENTERING VIM
"-------------------------------------------------
au VimEnter * :NERDTreeToggle
au VimEnter * :wincmd p

" COLOR COLUMNS
"-------------------------------------------------
set colorcolumn=80,120
hi ColorColumn guibg=#FAFAFA

