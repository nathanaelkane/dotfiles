return {
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    opts = {
      width = 150,
      autocmds = {
        enableOnVimEnter = false, -- see custom NoNeckPainVimEnterAutocmd autocmd instead
      },
      buffers = {
        right = {
          enabled = false,
        },
        scratchPad = {
          enabled = true,
          fileName = "scratch",
        },
        bo = {
          filetype = "md",
        },
      },
    },
  },
}
