local use = require("packer").use

use {
  "Pocco81/AutoSave.nvim",

  config = function()
    require("autosave").setup {
      enabled = true,
    }
  end,
}
