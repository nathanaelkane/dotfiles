if !has('nvim')
  Plug 'ervandew/supertab'
  Plug 'szw/vim-kompleter'

  let g:kompleter_replace_standard_mappings = 0 " Keep default <C-n> and <C-p> completion mappings
  let g:kompleter_case_sensitive = 3 " Smartcase
  let g:SuperTabDefaultCompletionType = '<C-x><C-u>'
endif
