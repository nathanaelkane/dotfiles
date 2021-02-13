Plug 'janko-m/vim-test'
Plug 'tpope/vim-dispatch'

let test#strategy = 'dispatch'
let test#ruby#rspec#options = '--format progress'

" Fix dispatch + tmux + quickfix issue: https://github.com/tpope/vim-dispatch/issues/192#issuecomment-253543883
set shellpipe+=" "

nmap <silent> tn :TestNearest<CR>
nmap <silent> tf :TestFile<CR>
nmap <silent> ts :TestSuite<CR>
nmap <silent> tl :TestLast<CR>
nmap <silent> tg :TestVisit<CR>

autocmd FileType qf setlocal wrap
