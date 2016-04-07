Plug 'Shougo/deoplete.nvim'

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#disable_auto_complete = 1

" <Tab>: completion in forward direction
" <S-Tab>: completion in reverse direction
inoremap <silent><expr><Tab> pumvisible() ? "\<C-n>" : (<SID>check_back_space() ? "\<Tab>" : deoplete#mappings#manual_complete())
inoremap <silent><expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" <C-h>, <BS>: close popup, insert candidate and delete backword char
inoremap <expr><C-h> deoplete#mappings#close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#mappings#close_popup()."\<C-h>"

" <CR>: close popup and insert candidate
inoremap <silent><expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"
