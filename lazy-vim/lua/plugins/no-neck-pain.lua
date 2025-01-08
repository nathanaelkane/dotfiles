return {
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    opts = {
      width = 150,
      autocmds = {
        enableOnVimEnter = false, -- see custom NoNeckPainVimEnterAutocmd autocmd instead
        skipEnteringNoNeckPainBuffer = true,
      },
      buffers = {
        right = {
          enabled = false,
        },
        scratchPad = {
          enabled = false,
        },
        bo = {
          filetype = "md",
        },
      },
    },
  },
}
