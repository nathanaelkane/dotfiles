Plug 'ervandew/supertab'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}

  let g:deoplete#enable_at_startup = 1
  let g:SuperTabDefaultCompletionType = "<C-n>"
else
  Plug 'szw/vim-kompleter'

  let g:kompleter_replace_standard_mappings = 0 " Keep default <C-n> and <C-p> completion mappings
  let g:kompleter_case_sensitive = 3 " Smartcase
  let g:SuperTabDefaultCompletionType = '<C-x><C-u>'
endif
