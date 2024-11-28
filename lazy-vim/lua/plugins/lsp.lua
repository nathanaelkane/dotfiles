return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      -- workaround: shouldn't have to map these here
      keys[#keys + 1] = { "<leader>cf", ":let @*=expand('%')<CR>", { silent = true, desc = "Copy file path" } }
      keys[#keys + 1] = { "<leader>cl", ":let @*=expand('%').':'.line('.')<cr>", { silent = true, desc = "Copy file path with line number" } } -- override
    end,
  },
}
