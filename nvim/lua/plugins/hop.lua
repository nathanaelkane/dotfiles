local use = require("packer").use

use {
  "phaazon/hop.nvim",
  branch = "v1",

  config = function()
    require("hop").setup()

    local map = require("utils").map

    map("", "<Leader>ee", "<Cmd>HopChar2<CR>")
    map("", "<Leader>ew", "<Cmd>HopWordAC<CR>")
    map("", "<Leader>eb", "<Cmd>HopWordBC<CR>")
    map("", "<Leader>ek", "<Cmd>HopLineStartBC<CR>")
    map("", "<Leader>ej", "<Cmd>HopLineStartAC<CR>")
  end
}
