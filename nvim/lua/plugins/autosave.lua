local use = require("packer").use

use {
  "Pocco81/auto-save.nvim",

  config = function()
    require("auto-save").setup {
      enabled = true,
    }
  end,
}
