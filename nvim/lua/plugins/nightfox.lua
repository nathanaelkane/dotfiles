local use = require("packer").use

use {
  "EdenEast/nightfox.nvim",

  config = function()
    vim.cmd("colorscheme nightfox")
  end,
}
