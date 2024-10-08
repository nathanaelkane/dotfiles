return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",
  enabled = false,

  config = function()
    require("no-neck-pain").setup {
      autocmds = {
        enableOnVimEnter = true,
      },
      width = 135,
      buffers = {
        colors = {
          background = "#131a24", -- nightfox
        },
        right = {
          enabled = false,
        },
        scratchPad = {
          enabled = true,
        },
        bo = {
          filetype = "md",
        },
      },
    }
  end,
}
