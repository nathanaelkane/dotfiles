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

" Cmd+L for BufExplorer
macmenu &Tools.List\ Errors key=<nop>
nmap <D-l> :BufExplorer<CR>
imap <D-l> <Esc>:BufExplorer<CR>

" Stop Cmd+Shift+W from closing Vim
macmenu &File.Close\ Window key=<nop>

" Cmd+R to flush Command-T cache
nmap <D-r> :CommandTFlush<CR>
imap <D-r> <Esc>:CommandTFlush<CR>

" Hide MacVim when the window closes
au VimLeave * maca hide:

" Create new menu item 'Close Instance'
" In OS X you can create an application specific keyboard shortcut to use with this new menu item.
menu File.Close\ Instance :qa<CR>
inoremenu File.Close\ Instance <C-O>:qa<CR>
