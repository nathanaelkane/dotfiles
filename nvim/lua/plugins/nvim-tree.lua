local use = require("packer").use

use {
  "kyazdani42/nvim-tree.lua",
  requires = "kyazdani42/nvim-web-devicons",
  commit = "67805502d2a126a4c40466059db8f1770a6625d4", -- before refactor

  setup = function()
    vim.g.nvim_tree_side = "right"
    vim.g.nvim_tree_hijack_cursor = 0
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_highlight_opened_files = 3
    vim.g.nvim_tree_follow_update_path = 1
    vim.g.nvim_tree_gitignore = 1
  end,

  config = function()
    local map = require("utils").map

    map("n", "<Leader>n", "<Cmd>NvimTreeToggle<CR>")
    map("n", "<Leader>.", "<Cmd>NvimTreeFindFile<CR>")
  end,
}
