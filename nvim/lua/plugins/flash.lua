return {
  "folke/flash.nvim",
  event = "VeryLazy",
  enabled = false,

  opts = {
    modes = {
      search = {
        enabled = false,
      }
    },
  },

  keys = {
    {
      "<leader>e",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
  },
}
