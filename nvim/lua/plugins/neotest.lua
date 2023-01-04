return {
  "nvim-neotest/neotest",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "olimorris/neotest-rspec",
  },

  config = function()
    local map = require("utils").map

    require("neotest").setup({
      adapters = {
        require("neotest-rspec")({
          runner = "rspec",
        }),
      },
    })

    map("n", "<Leader>rr", ':lua require("neotest").run.run()<CR>') -- Run the nearest test
    map("n", "<Leader>rf", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>') -- Run the current file
    map("n", "<Leader>rl", ':lua require("neotest").run.run_last()<CR>') -- Run the last test
    map("n", "<Leader>ro", ':lua require("neotest").output.open()<CR>')
    map("n", "<Leader>rO", ':lua require("neotest").output.open({short = true})<CR>')
    map("n", "<Leader>rs", ':lua require("neotest").summary.toggle()<CR>')
  end,
}
