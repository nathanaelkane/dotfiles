local use = require("packer").use

use {
  "hrsh7th/nvim-cmp",

  requires = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    vim.cmd "set completeopt=menu,menuone,noselect"

    local cmp = require("cmp")
    local cmp_buffer = require("cmp_buffer")

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "s"}),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
      },
      sources = cmp.config.sources({
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs() -- all buffers
            end,
          },
        },
        {name = "nvim_lsp"},
        {name = "luasnip"},
      }),
      sorting = {
        comparators = {
          function(...)
            -- sort completion results based on the distance of the word from the cursor line
            return cmp_buffer:compare_locality(...)
          end,
        },
      },
    })
  end,
}
