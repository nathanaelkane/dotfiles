return {
  {
    "tummetott/unimpaired.nvim",
    event = "VeryLazy",
    opts = {
      default_keymaps = true,
      keymaps = {
        previous_file = {
          mapping = "[[",
          description = "Previous file in directory. :colder in qflist",
          dot_repeat = true,
        },
        next_file = {
          mapping = "]]",
          description = "Next file in directory. :cnewer in qflist",
          dot_repeat = true,
        },
      },
    },
  },
}
