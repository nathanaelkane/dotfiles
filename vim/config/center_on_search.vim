nnoremap n nzzzv
nnoremap N Nzzzv

" On / or ?
let g:centeronsearch = "zzzv"
autocmd InsertEnter * let g:centeronsearch = "\<C-O>zz\<C-O>zv"
autocmd InsertLeave * let g:centeronsearch = "zzzv"
cnoremap <expr> <CR> "\<CR>" . ( getcmdtype() =~ "[/?]" ? g:centeronsearch : "" )
