return {
  "lewis6991/gitsigns.nvim",
  dependencies = "nvim-lua/plenary.nvim",

  config = function()
    require("gitsigns").setup({
      keymaps = {},
      signs = {
        add = {hl = 'GitSignsAdd' , text = '▎', numhl='GitSignsAddNr' , linehl='GitSignsAddLn'},
        change = {hl = 'GitSignsChange', text = '▎', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      },
    })

    _G.toggle_gitsigns_mode = function()
      if vim.g.gitsigns_diff_base == nil then
        vim.g.gitsigns_diff_base = vim.fn.trim(vim.fn.system("git merge-base origin/HEAD HEAD"))
      else
        vim.g.gitsigns_diff_base = nil
      end

      require("gitsigns").change_base(vim.g.gitsigns_diff_base, true)
    end

    local map = require("utils").map

    map("n", "]d", [[&diff ? "]c" : "<Cmd>lua require('gitsigns.actions').next_hunk()<CR>"]], {expr = true})
    map("n", "[d", [[&diff ? "[c" : "<Cmd>lua require('gitsigns.actions').prev_hunk()<CR>"]], {expr = true})
    map("n", "cog", "<Cmd>call v:lua.toggle_gitsigns_mode()<CR>")
  end,
}
