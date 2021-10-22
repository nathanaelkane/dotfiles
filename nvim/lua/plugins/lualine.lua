local use = require("packer").use

use {
  "nvim-lualine/lualine.nvim",
  requires = "kyazdani42/nvim-web-devicons",

  config = function()
    require("lualine").setup {
      options = {
        theme = "nightfox",
        section_separators = "",
        component_separators = "",
      },
    }
  end,
}
