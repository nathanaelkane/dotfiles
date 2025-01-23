return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    opts = {
      window = {
        mappings = {
          ["-"] = "close_window",
        },
      },
    },
    keys = function()
      return {
        {
          "-",
          function()
            require("neo-tree.command").execute({ position = "current", reveal = true })
          end,
          desc = "Explorer NeoTree",
        },
      }
    end,
  },
}
