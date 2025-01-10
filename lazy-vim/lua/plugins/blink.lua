return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "mikavilpas/blink-ripgrep.nvim",
    },
    opts = function(_, opts)
      opts.sources.default = { "buffer", "path", "snippets" } -- exclude "lsp" for now as including "lsp" will disable "buffer" as soon as LSP becomes enabled in a buffer

      opts.sources.providers = {
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
      }

      opts.completion.ghost_text.enabled = false

      opts.completion.trigger = opts.completion.trigger or {}
      opts.completion.trigger.show_in_snippet = false

      opts.completion.list = opts.completion.list or {}
      opts.completion.list.selection = { preselect = false, auto_insert = true }

      opts.keymap = {
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
        ["<C-l>"] = {
          function()
            require("blink-cmp").show({ providers = { "lsp" } })
          end,
        },
        ["<C-r>"] = {
          function()
            require("blink-cmp").show({ providers = { "ripgrep" } })
          end,
        },
      }
    end,
  },
}
