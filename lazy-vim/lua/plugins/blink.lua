return  {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "mikavilpas/blink-ripgrep.nvim",
    },
    version = "*",
    opts = {
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "buffer", "path", "snippets" },
        providers = {
          lsp = {
            fallbacks = {}, -- without this override, buffer results aren't included
          },
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            opts = {
              prefix_min_len = 3,
              context_size = 5,
              max_filesize = "1M",
              project_root_marker = ".git",
              search_casing = "--ignore-case",
              additional_rg_options = {},
              fallback_to_regex_highlighting = true,
              debug = false,
              future_features = {
                kill_previous_searches = true,
              },
            },
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                item.labelDetails = {
                  description = "(rg)",
                }
              end
              return items
            end,
          },
        },
      },
      completion = {
        list = {
          selection = { preselect = false, auto_insert = true },
        },
        trigger = { show_in_snippet = false },
      },
      keymap = {
        preset = "super-tab",
        ["<C-y>"] = { "select_and_accept" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = {
          function(cmp)
            local selected_item = cmp.get_selected_item()
            if type(selected_item) == "table" and selected_item.source_id == "snippets" then
              return cmp.select_and_accept()
            end
          end,
          "fallback",
        },
        ["<C-r>"] = {
          function()
            require("blink-cmp").show({ providers = { "ripgrep" } })
          end,
        },
      },
    },
    opts_extend = { "sources.default" },
  }
}
