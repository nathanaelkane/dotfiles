return {
  "kazhala/close-buffers.nvim",

  config = function()
    -- Closes the quickfix window if it's open, otherwise the focused buffer.
    function _G.close_window()
      for _, win in pairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
          vim.cmd("cclose")
          return
        end
      end
      vim.cmd("BDelete this")
    end

    local map = require("utils").map

    map("n", "<Leader>q", ":call v:lua.close_window()<CR>", {silent = true})
    map("n", "<Leader>Q", ":BDelete all<CR>", {silent = true})
  end,
}
