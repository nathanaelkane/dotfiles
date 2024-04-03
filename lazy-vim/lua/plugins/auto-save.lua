return {
  "Pocco81/auto-save.nvim",
  opts = {
    execution_message = {
      message = function()
        return ""
      end,
    },
    condition = function(buf)
      local fn = vim.fn
      local utils = require("auto-save.utils.data")

      local excluded_filetypes = {
        "oil",
      }

      if fn.getbufvar(buf, "&modifiable") == 1 and
        utils.not_in(fn.getbufvar(buf, "&filetype"), excluded_filetypes)
      then
        return true -- met condition(s), can save
      end

      return false -- can't save
    end,
  },
}
