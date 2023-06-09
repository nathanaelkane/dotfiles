return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",

  config = function()
    require("no-neck-pain").setup {
      autocmds = {
        enableOnVimEnter = true,
      },
      width = 135,
      buffers = {
        colors = {
          background = "#221f22", -- monokai-pro
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
