-- Add dashes to the list of 'word characters'
vim.cmd [[autocmd Filetype * setlocal iskeyword+=-]]

-- Turn on spell checking for git commits
vim.cmd [[autocmd FileType gitcommit setlocal spell]]
