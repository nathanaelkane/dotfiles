local use = require("packer").use

use {
  "lukas-reineke/indent-blankline.nvim",

  config = function()
    vim.g.indent_blankline_context_patterns = {
      "class",
      "^func",
      "method",
      "^if",
      "while",
      "for",
      "with",
      "try",
      "except",
      "arguments",
      "argument_list",
      "object",
      "dictionary",
      "element",
      "table",
      "tuple",
      "do_block",

      -- Ruby
      "unless",
      "when",
      "else",
      "pair",
      "hash",
      "module",
      "assignment",
      "call",
    }

    require("indent_blankline").setup {
      char = "│",
      show_first_indent_level = true,
      show_trailing_blankline_indent = false,
      show_current_context = true,
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
