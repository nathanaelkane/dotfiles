" MACVIM SETTINGS

set guifont=Menlo:h15

" Cmd+T for Command-T
macmenu &File.New\ Tab key=<nop>
nmap <D-t> :CommandT<CR>
imap <D-t> <Esc>:CommandT<CR>

" Cmd+F for Ack
macmenu &Edit.Find.Find\.\.\. key=<nop>
nmap <D-f> :Ack<Space>
imap <D-f> <Esc>:Ack<Space>

" Stop Cmd+W from closing window
macmenu &File.Close key=<nop>
nmap <D-w> :BD<CR>
imap <D-w> <Esc>:BD<CR>

" Stop Cmd+Shift+W from closing Vim
macmenu &File.Close\ Window key=<nop>

" Hide MacVim when the window closes
au VimLeave * maca hide:
