local use = require("packer").use

use {
  "ntpeters/vim-better-whitespace",

  setup = function()
    vim.g.better_whitespace_filetypes_blacklist = {
      "diff",
      "git",
      "gitcommit",
      "unite",
      "qf",
      "help",
      "markdown",
      "fugitive",
      "TelescopePrompt",
    }

    vim.g.better_whitespace_enabled = 1
  end,

  config = function()
    local map = require("utils").map

    -- trim & save
    map("n", "<Leader>sw", ":StripWhitespace<CR>:up<CR>")
  end,
}
