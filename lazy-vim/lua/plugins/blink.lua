return  {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        providers = {
          lsp = {
            fallbacks = {}, -- without this override, buffer results aren't included
          },
        },
      },
      keymap = {
        ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },
    },
  }
}
