return {
  "Pocco81/auto-save.nvim",

  config = function()
    require("auto-save").setup {
      enabled = true,
      execution_message = {
        message = function()
          return ""
        end,
      },
    }
  end,
}
