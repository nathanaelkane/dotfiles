-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- select all
vim.keymap.set("n", "<leader>a", "ggVG")

-- yank from cursor to end of line
vim.keymap.set("", "Y", "y$")

-- yank and put to/from system pasteboard
vim.keymap.set("", "<leader>y", '"*y')
vim.keymap.set("n", "<leader>yy", '"*yy')
vim.keymap.set("", "<leader>p", '"*p')
vim.keymap.set("", "<leader>P", '"*P')

-- override old leader key
vim.keymap.set("", ",", "<cmd>echoerr 'Use SPACE instead!'<cr>")

-- jump to start/end of line
vim.keymap.set("", "H", "^")
vim.keymap.set("", "L", "$")

-- tab to toggle folds
vim.keymap.set("n", "<tab>", "za")

-- copy file path
vim.keymap.set("n", "<leader>cf", ":let @*=expand('%')<CR>", { silent = true, desc = "Copy file path" })
vim.keymap.set("n", "<leader>cl", ":let @*=expand('%').':'.line('.')<cr>", { silent = true, desc = "Copy file path with line number" })

-- highlight word/selection without changing position
vim.keymap.set("n", "<leader>h", ":let view=winsaveview()<CR>*:call winrestview(view)<CR>", { remap = true, silent = true })
vim.keymap.set("v", "<leader>h", ":<C-U>let view=winsaveview()<CR>gv*:<C-U>call winrestview(view)<CR>", { remap = true, silent = true })

-- window navigation
vim.keymap.set("", "<C-h>", "<C-w>h")
vim.keymap.set("", "<C-j>", "<C-w>j")
vim.keymap.set("", "<C-k>", "<C-w>k")
vim.keymap.set("", "<C-l>", "<C-w>l")

-- don't bubble lines in insert mode
vim.keymap.set("i", "<A-j>", "<Nop>")
vim.keymap.set("i", "<A-k>", "<Nop>")
