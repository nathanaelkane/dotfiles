return {
  {
    "nvim-mini/mini.trailspace",
    opts = {},
    keys = {
      { "<leader>ct", ":lua MiniTrailspace.trim()<cr>:up<cr>", desc = "Trim trailing whitespace", silent = true },
    },
  },
}
