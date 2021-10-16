local use = require("packer").use

use {
  "NTBBloodbath/rest.nvim",
  requires = "nvim-lua/plenary.nvim",

  config = function()
    require("rest-nvim").setup {
      -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = false,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      -- Jump to request line on run
      jump_to_request = false,
    }

    local map = require("utils").map

    map("n", "<Leader>xx", "<Plug>RestNvim", {noremap = false})
    map("n", "<Leader>xp", "<Plug>RestNvimPreview", {noremap = false})
    map("n", "<Leader>xl", "<Plug>RestNvimLast", {noremap = false})

    vim.cmd "autocmd FileType http nmap <buffer> <Enter> <Plug>RestNvim"
  end,
}
