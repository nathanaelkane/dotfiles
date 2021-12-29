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

    map("n", "f", "<Cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true})<CR>")
    map("n", "F", "<Cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true})<CR>")
    map("o", "f", "<Cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true})<CR>")
    map("o", "F", "<Cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true})<CR>")
    map("", "t", "<Cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true})<CR>")
    map("", "T", "<Cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true})<CR>")
  end
}
