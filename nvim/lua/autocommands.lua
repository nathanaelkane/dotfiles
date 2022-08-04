-- Add dashes to the list of 'word characters'
vim.cmd [[autocmd Filetype * setlocal iskeyword+=-]]

-- Turn on spell checking for git commits
vim.cmd [[autocmd FileType gitcommit setlocal spell]]

-- Highlight on yank
vim.cmd [[autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup = "IncSearch", timeout = 250}]]
