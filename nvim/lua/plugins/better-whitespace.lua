return {
  "ntpeters/vim-better-whitespace",

  init = function()
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
    vim.g.current_line_whitespace_disabled_soft = 1
  end,

  config = function()
    local map = require("utils").map

    -- trim & save
    map("n", "<Leader>sw", ":StripWhitespace<CR>:up<CR>")
  end,
}
