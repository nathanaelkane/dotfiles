return {
  {
    "matze/vim-move",

    init = function()
      vim.g.move_map_keys = 0
    end,

    config = function()
      local map = require("utils").map

      -- Use option-J/K to bubble lines up and down
      map("n", "˚", "<Plug>MoveLineUp", {noremap = false})
      map("n", "∆", "<Plug>MoveLineDown", {noremap = false})
      map("v", "˚", "<Plug>MoveBlockUp", {noremap = false})
      map("v", "∆", "<Plug>MoveBlockDown", {noremap = false})
    end,
  },

  {
    "AndrewRadev/sideways.vim",

    config = function()
      local map = require("utils").map

      -- Use option-H/L to bubble items (function arguments, etc) left and right
      map("n", "˙", ":SidewaysLeft<CR>", {silent = true})
      map("n", "¬", ":SidewaysRight<CR>", {silent = true})
    end,
  },
}
