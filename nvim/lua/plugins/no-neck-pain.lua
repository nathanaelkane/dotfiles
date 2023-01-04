return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",

  config = function()
    require("no-neck-pain").setup {
      enableOnVimEnter = true,
      width = 135,
      buffers = {
        backgroundColor = "#131a24",
        right = {
          enabled = false,
        },
      },
    }
  end,
}
