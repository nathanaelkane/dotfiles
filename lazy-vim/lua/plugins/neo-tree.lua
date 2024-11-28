return {
  {
    "nvim-neo-tree/neo-tree.nvim",
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
