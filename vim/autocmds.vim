autocmd FileType ruby,rails,haml,eruby,yaml,ru,cucumber set ai sw=2 sts=2 et
autocmd BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown
autocmd BufRead,BufNewFile *.hamlc set ft=haml

" Add dashes to the list of 'word characters'
autocmd Filetype * setlocal iskeyword+=-

" Save on FocusLost
autocmd FocusLost * nested :silent! wall
