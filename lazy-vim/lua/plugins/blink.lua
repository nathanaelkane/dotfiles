return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.sources.default = { "buffer", "path", "snippets" } -- exclude "lsp" for now as including "lsp" will disable "buffer" as soon as LSP becomes enabled in a buffer

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
      }
    end,
  },
}
