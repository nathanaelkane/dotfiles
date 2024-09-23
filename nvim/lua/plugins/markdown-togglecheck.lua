return {
  "nfrid/markdown-togglecheck",
  dependencies = "nfrid/treesitter-utils",
  ft = "markdown",

  keys = {
    {"<C-Space>", ":lua require('markdown-togglecheck').toggle()<CR>", silent = true},
  },
}

