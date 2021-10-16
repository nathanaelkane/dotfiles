local use = require("packer").use

use {
  "Lokaltog/vim-easymotion",

  setup = function()
    vim.g.EasyMotion_leader_key = "<Leader>e"
  end,
}
