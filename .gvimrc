" GUI
"-------------------------------------------------
if has("gui_running")
  colorscheme vilight " Awesome theme, was: rdark
  set guioptions-=T   " Hide the tool bar
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
  set guifont=Menlo:h13

  " PeepOpen - stop Cmd-T from opening a new tab
  macmenu &File.New\ Tab key=<nop>
  map <unique> <silent> <D-t> <Plug>PeepOpen

  " Stop Cmd+W from closing window
  macmenu &File.Close key=<nop>
  map <unique> <silent> <D-w> :BD<CR>

  " Stop Cmd+Shift+W from closing vim
  macmenu &File.Close\ Window key=<nop>

  " Fullscreen
  set fuoptions=maxvert,maxhorz
  au GUIEnter * set fullscreen
endif

" CUSTOMISE THE COLORSCHEME
"-------------------------------------------------
hi Cursor guifg=black guibg=green
hi iCursor guifg=black guibg=green
set guicursor=a:blinkon0 " turn off cursor blink
hi StatusLine guifg=white guibg=#a3190c gui=none
hi LineNr guifg=#424242 guibg=#111111

