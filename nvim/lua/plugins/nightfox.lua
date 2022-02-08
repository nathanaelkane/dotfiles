local use = require("packer").use

use {
  "EdenEast/nightfox.nvim",

  config = function()
    local nightfox = require("nightfox")

    nightfox.setup {
      fox = "nightfox",
      hlgroups = {
        LineNr = {fg = "#526175", bg = "#111B24"},
        CursorLineNr = {fg = "#9D79D6", bg = "#111B24"},
        SignColumn = {bg = "#111B24"},
        GitSignsAdd = {bg = "#111B24"},
        GitSignsChange = {bg = "#111B24"},
        GitSignsDelete = {bg = "#111B24"},
        IndentBlanklineChar = {fg = "#393B44"},
        DiagnosticSignError = {fg = "#C94F6D", bg = "#111B24"},
        DiagnosticSignWarn = {fg = "#DBC074", bg = "#111B24"},
        DiagnosticSignHint = {fg = "#63CDCF", bg = "#111B24"},
        DiagnosticSignInfo = {fg = "#719CD6", bg = "#111B24"},
        HopNextKey = {fg = "#D67AD2"},
        HopNextKey1 = {fg = "#9D79D6"},
        HopNextKey2 = {fg = "#B8A1E3"},
      }
    }

    nightfox.load()
  end,
}
