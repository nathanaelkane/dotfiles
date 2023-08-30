return {
  "loctvl842/monokai-pro.nvim",
  lazy = false,
  priority = 1000,
  enabled = false,

  config = function()
    require("monokai-pro").setup()
    vim.cmd("colorscheme monokai-pro")
  end,
}
