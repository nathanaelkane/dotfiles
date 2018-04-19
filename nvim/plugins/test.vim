Plug 'janko-m/vim-test'
Plug 'benmills/vimux'

let test#strategy = "vimux"
let g:VimuxHeight = "40"

nmap <silent> tn :TestNearest<CR>
nmap <silent> tf :TestFile<CR>
nmap <silent> ts :TestSuite<CR>
nmap <silent> tl :TestLast<CR>
nmap <silent> tg :TestVisit<CR>
nmap <silent> tc :VimuxCloseRunner<CR>
