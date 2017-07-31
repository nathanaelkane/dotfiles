Plug 'machakann/vim-highlightedyank'

let g:highlightedyank_highlight_duration = 250

map y <Plug>(highlightedyank)

" Yank from the cursor to the end of the line, to be consistent with C and D
nmap Y <Plug>(highlightedyank)$
