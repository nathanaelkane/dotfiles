-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.cmd("autocmd FileType ruby setlocal indentkeys-=.")

-- TODO: The following works, but there has to be a better way via config options...
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Open Neo-tree on first buffer open",
  once = true,
  callback = function()
    if vim.bo.filetype ~= "gitcommit" then
      vim.defer_fn(
        function()
          vim.cmd("Neotree show left")
        end,
        10
      )
    end
  end,
})
