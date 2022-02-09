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
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {{"filename", path = 1}},
        lualine_x = {"location"},
        lualine_y = {},
        lualine_z = {}
      },
      sections = {
        lualine_a = {"mode" },
        lualine_b = {"diagnostics"},
        lualine_c = {{"filename", path = 1}},
        lualine_x = {"encoding", "fileformat", "filetype"},
        lualine_y = {"progress"},
        lualine_z = {"location"}
      },
    }
  end,
}
