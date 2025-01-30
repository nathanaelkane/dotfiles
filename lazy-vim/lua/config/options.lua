-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.g.autoformat = false
vim.g.lazyvim_picker = "snacks"
vim.g.root_spec = { "cwd" } -- prevent LSP and others from changing the root dir
vim.opt.cursorlineopt = "number"
vim.opt.relativenumber = false
vim.opt.clipboard = ""
vim.opt.foldexpr = ""
vim.opt.foldmethod = "indent"
vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
