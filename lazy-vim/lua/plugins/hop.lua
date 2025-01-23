return {
  {
    "smoka7/hop.nvim",
    version = "*",
    opts = {},
    keys = {
      { "<leader>ee", ":HopPattern<cr>", desc = "Make an arbitrary search akin to / and go to any occurrences", silent = true },
      { "<leader>eb", ":HopWordBC<cr>", desc = "Go to any word before the cursor", silent = true },
      { "<leader>ew", ":HopWordAC<cr>", desc = "Go to any word after the cursor", silent = true },
      { "<leader>ek", ":HopLineStartBC<cr>", desc = "Go to any line start before the cursor", silent = true },
      { "<leader>ej", ":HopLineStartAC<cr>", desc = "Go to any line start after the cursor", silent = true },
    },
  },
}
