Bundle 'rking/vim-ruby-refactoring'

let g:ruby_refactoring_map_keys = 0

nnoremap <Leader>Lap :RAddParameter<CR>
nnoremap <Leader>Lcpc :RConvertPostConditional<CR>
nnoremap <Leader>Lel :RExtractLet<CR>
vnoremap <Leader>Lec :RExtractConstant<CR>
vnoremap <Leader>Lelv :RExtractLocalVariable<CR>
nnoremap <Leader>Lit :RInlineTemp<CR>
vnoremap <Leader>Lrlv :RRenameLocalVariable<CR>
vnoremap <Leader>Lriv :RRenameInstanceVariable<CR>
vnoremap <Leader>Lem :RExtractMethod<CR>
