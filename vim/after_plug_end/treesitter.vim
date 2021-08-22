if has('nvim')
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    -- ensure_installed = "maintained",
    highlight = {
      enable = true,
      disable = {"ruby"},
    },
    indent = {
      enable = false,
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
    },
  }
EOF
endif
