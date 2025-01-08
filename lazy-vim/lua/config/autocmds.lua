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

-- Source: https://github.com/shortcuts/no-neck-pain.nvim/blob/5d91f31a2d583a367df97a4654be028fbe13f2d2/lua/no-neck-pain/init.lua#L110
vim.api.nvim_create_augroup("NoNeckPainVimEnterAutocmd", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      if _G.NoNeckPain.state ~= nil and _G.NoNeckPain.state.enabled then
        return
      end

      -- This is the only difference from the source version
      if string.match(vim.bo.filetype, "^git") then
        return
      end

      NoNeckPain.enable()

      require("no-neck-pain.util.api").debounce("enable_on_vim_enter", function()
        if _G.NoNeckPain.state ~= nil then
          pcall(vim.api.nvim_del_augroup_by_name, "NoNeckPainVimEnterAutocmd")
        end
      end, 20)
    end)
  end,
  group = "NoNeckPainVimEnterAutocmd",
  desc = "Triggers until it finds the correct moment/buffer to enable NoNeckPain for.",
})
