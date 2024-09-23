return {
  "ThePrimeagen/harpoon",
  dependencies = "nvim-lua/plenary.nvim",

  config = function()
    local map = require("utils").map

    map("n", "<Leader>bb", ":lua require('harpoon.mark').toggle_file()<CR>")
    map("n", "<Leader>ba", ":lua require('harpoon.mark').add_file()<CR>")
    map("n", "<Leader>br", ":lua require('harpoon.mark').rm_file()<CR>")
    map("n", "<Leader>bC", ":lua require('harpoon.mark').clear_all()<CR>")
    map("n", "<Leader>bl", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
    map("n", "<Leader>bn", ":lua require('harpoon.ui').nav_next()<CR>")
    map("n", "<Leader>bp", ":lua require('harpoon.ui').nav_prev()<CR>")

    map("n", "<Leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>")
    map("n", "<Leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>")
    map("n", "<Leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>")
    map("n", "<Leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>")
    map("n", "<Leader>5", ":lua require('harpoon.ui').nav_file(5)<CR>")
    map("n", "<Leader>6", ":lua require('harpoon.ui').nav_file(6)<CR>")
    map("n", "<Leader>7", ":lua require('harpoon.ui').nav_file(7)<CR>")
    map("n", "<Leader>8", ":lua require('harpoon.ui').nav_file(8)<CR>")
    map("n", "<Leader>9", ":lua require('harpoon.ui').nav_file(9)<CR>")
  end,
}
