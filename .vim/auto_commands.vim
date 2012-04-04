" AUTO COMMANDS

" Ruby files
autocmd FileType ruby,rails,haml,eruby,yaml,ru,cucumber set ai sw=2 sts=2 et

" Set color column for features
autocmd BufWinEnter *.feature set cc+=11
autocmd BufWinLeave *.feature set cc-=11

" Markdown files
autocmd BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown

" Add dashes to the list of 'word characters'
autocmd Filetype * setlocal iskeyword+=-

" Save on FocusLost
autocmd FocusLost * nested :silent! wall

" Set colorcolumn to the current textwidth or fallback to 80
autocmd BufWinEnter * call ColorColumnAtTextWidth(80)
