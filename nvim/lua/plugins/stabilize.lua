local use = require("packer").use

use {
  "luukvbaal/stabilize.nvim",

  config = function()
    require("stabilize").setup()
  end,
}
