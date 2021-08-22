Plug 'AndrewRadev/splitjoin.vim'

" Mappings:
" - gS to split a one-liner into multiple lines
" - gJ (with the cursor on the first line of a block) to join a block into a single-line statement.

let g:splitjoin_ruby_curly_braces = v:false
let g:splitjoin_ruby_heredoc_type = '<<~'
let g:splitjoin_ruby_trailing_comma = v:true
let g:splitjoin_ruby_hanging_args = v:false
let g:splitjoin_ruby_do_block_split = v:true
let g:splitjoin_ruby_options_as_arguments = v:true
