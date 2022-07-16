local use = require("packer").use

use {
  "lukas-reineke/indent-blankline.nvim",

  config = function()
    require("indent_blankline").setup {
      char = "│",
      show_first_indent_level = true,
      show_trailing_blankline_indent = false,
      filetype_exclude = {
        "packer",
        "neo-tree",
      },
      buftype_exclude = {
        "terminal",
      },
    }
  end,
}
