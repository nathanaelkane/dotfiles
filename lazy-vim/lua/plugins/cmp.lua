return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.completion = {
        completeopt = "menu,menuone,noselect",
      }

      opts.mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

        ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          { "i", "c" }
        ),
      }

      opts.performance = {
        max_view_entries = 10,
      }

      opts.experimental = {
        ghost_text = false,
      }

      opts.sources = cmp.config.sources({
        { name = "path", max_item_count = 5 },
        { name = "buffer", max_item_count = 5 },
        { name = "nvim_lsp", max_item_count = 5 },
        { name = "snippets", max_item_count = 5 },
      })
    end,
  },
}
