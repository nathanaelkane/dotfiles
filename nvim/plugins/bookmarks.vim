Plug 'MattesGroeger/vim-bookmarks'

let g:bookmark_sign = 'B'
let g:bookmark_annotation_sign = 'A'
let g:bookmark_no_default_key_mappings = 1

nmap <Leader>bb :BookmarkToggle<CR>
nmap <Leader>bi :BookmarkAnnotate<CR>
nmap <Leader>bn :BookmarkNext<CR>
nmap <Leader>bp :BookmarkPrev<CR>
nmap <Leader>ba :BookmarkShowAll<CR>
nmap <Leader>bc :BookmarkClear<CR>
nmap <Leader>bx :BookmarkClearAll<CR>
