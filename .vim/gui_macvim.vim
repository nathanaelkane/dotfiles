" MACVIM SETTINGS

set guifont=Menlo:h15

" Cmd+T for Command-T
macmenu &File.New\ Tab key=<nop>
nmap <D-t> :CommandT<CR>
imap <D-t> <Esc>:CommandT<CR>

" Cmd+R for Command-T Cache Flush
nmap <D-r> :CommandTFlush<CR>
imap <D-r> <Esc>:CommandTFlush<CR>

" Cmd+F for Ack
macmenu &Edit.Find.Find\.\.\. key=<nop>
nmap <D-f> :Ack<Space>
imap <D-f> <Esc>:Ack<Space>

" Cmd+W for Command-W
macmenu &File.Close key=<nop>
nmap <D-w> :CommandW<CR>
imap <D-w> <Esc>:CommandW<CR>

" Cmd+K for bufkill
nmap <D-k> :BD<CR>
imap <D-k> <Esc>:BD<CR>

" Cmd+L for BufExplorer
macmenu &Tools.List\ Errors key=<nop>
nmap <D-l> :BufExplorer<CR>
imap <D-l> <Esc>:BufExplorer<CR>

" Stop Cmd+Shift+W from closing Vim
" macmenu &File.Close\ Window key=<nop>
" nmap <D-W> :qall<CR>
" imap <D-W> <Esc>:qall<CR>
