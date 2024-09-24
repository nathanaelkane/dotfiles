return {
  {
    "epwalsh/obsidian.nvim",
    enabled = false,
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "Personal",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal",
        },
      },
      daily_notes = {
        folder = "Daily Notes",
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
    },
  },
}
