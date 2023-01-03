local use = require("packer").use

use {
  "hrsh7th/nvim-cmp",

  requires = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
  },

  config = function()
    vim.cmd "set completeopt=menu,menuone,noselect"

    local cmp = require("cmp")
    cmp.setup({
      mapping = {
        ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "s"}),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "s"}),
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "s"}),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
      },
      sources = cmp.config.sources({
        {name = "nvim_lsp"},
        {name = "buffer"},
      }),
    })
  end,
}
