return {
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    opts = {
      width = 150,
      autocmds = {
        enableOnVimEnter = true,
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
