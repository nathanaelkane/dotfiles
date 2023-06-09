return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000, -- load before other plugins
  enabled = false,

  config = function()
    vim.cmd("colorscheme nightfox")
  end,
}
