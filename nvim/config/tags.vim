" Additional config on top of @jasoncodes' vim/config/tags.vim

if executable('ripper-tags') && executable('ripper-tags-wrapper')
  let g:gutentags_ctags_executable_ruby = 'ripper-tags-wrapper --ignore-unsupported-options'
endif

au FileType gitcommit,gitrebase let g:gutentags_enabled=0
