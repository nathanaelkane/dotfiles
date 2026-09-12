-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.ignorecase = true -- ignore case by default when searching
vim.opt.smartcase = true -- switch to case sensitive mode if needle contains uppercase characters

-- Setup lazy.nvim
require("lazy").setup({
  {

    "smoka7/hop.nvim",
    version = "*",
    opts = {
      keys = "fjdksleirughtyvncmxzwaqpob",
    },
    keys = {
      { "<Leader>ew", [[<Cmd>HopWordAC<CR>]], desc = "Jump forwards to word" },
      { "<Leader>eb", [[<Cmd>HopWordBC<CR>]], desc = "Jump backwards to word" },
      { "<Leader>ej", [[<Cmd>HopLineStartAC<CR>]], desc = "Jump forwards to line start" },
      { "<Leader>ek", [[<Cmd>HopLineStartBC<CR>]], desc = "Jump backwards to line start" },
    },
  },
})

if vim.g.vscode then
  -- code actions
  vim.keymap.set("n", "<Leader>ca", [[<Cmd>lua require('vscode').action('editor.action.quickFix')<CR>]]) -- gra
  vim.keymap.set("n", "<Leader>cr", [[<Cmd>lua require('vscode').action('editor.action.rename')<CR>]]) -- grn

  -- jump to start/end of line
  vim.keymap.set("", "H", "^")
  vim.keymap.set("", "L", "$")

  -- next/prev change
  vim.keymap.set("n", "[h", [[<Cmd>lua require('vscode').action('workbench.action.editor.previousChange')<CR>]])
  vim.keymap.set("n", "]h", [[<Cmd>lua require('vscode').action('workbench.action.editor.nextChange')<CR>]])

  -- next/prev error
  vim.keymap.set("n", "[d", [[<Cmd>lua require('vscode').action('editor.action.marker.next')<CR>]])
  vim.keymap.set("n", "]d", [[<Cmd>lua require('vscode').action('editor.action.marker.prev')<CR>]])

  -- next/prev search result
  -- vim.keymap.set("n", "]q", "<Cmd>call VSCodeCall('search.action.focusNextSearchResult')<CR>")
  -- vim.keymap.set("n", "[q", "<Cmd>call VSCodeCall('search.action.focusPreviousSearchResult')<CR>")

  -- clear search
  vim.keymap.set("n", "<Esc>", "<Cmd>nohls<CR>", { silent = true })

  -- jump between current and previous buffers (equivalent to CTRL-^)
  -- vim.keymap.set("n", "<Leader>`", [[<Cmd>lua require('vscode').action('extension.goto-previous-buffer')<CR>]])

  -- copy file path
  -- vim.keymap.set("n", "<Leader>cf", [[<Cmd>lua require('vscode').action('copy-relative-path-and-line-numbers.path-only')<CR>]])
  -- vim.keymap.set("n", "<Leader>cl", [[<Cmd>lua require('vscode').action('copy-relative-path-and-line-numbers.both')<CR>]])

  -- folds
  vim.keymap.set("n", "<Tab>", [[<Cmd>lua require('vscode').action('editor.toggleFold')<CR>]])
  vim.keymap.set("n", "zR", [[<Cmd>lua require('vscode').action('editor.unfoldAll')<CR>]])

  -- -- open file at cursor
  -- vim.keymap.set("n", "gf", "<Cmd>call VSCodeCall('seito-openfile.openFileFromText')<CR>")

  -- vim.keymap.set("n", "<Leader>H", "<Cmd>call VSCodeNotify('workbench.action.findInFiles', {'query': expand('<cword>')})<CR>")
  -- vim.keymap.set("v", "<Leader>H", "<Cmd>call VSCodeNotifyVisual('workbench.action.findInFiles', 0)<CR>")

  -- vim.keymap.set("n", "<Leader>H", "<Cmd>call VSCodeNotify('search.action.openNewEditor')<CR>")
  -- vim.keymap.set("v", "<Leader>H", "<Cmd>call VSCodeNotify('search.action.openNewEditor', 0)<CR>")

  -- explorer
  vim.keymap.set("n", "<Leader>n", [[<Cmd>lua require('vscode').action('workbench.view.explorer')<CR>]])
  vim.keymap.set(
    "n",
    "<Leader>.",
    [[<Cmd>lua require('vscode').action('workbench.files.action.showActiveFileInExplorer')<CR>]]
  )

  -- reselect visual block after indent or outdent
  vim.keymap.set("v", "<", "<gv")
  vim.keymap.set("v", ">", ">gv")

  -- show all editors
  vim.keymap.set("n", "<Leader>l", [[<Cmd>lua require('vscode').action('workbench.action.showAllEditors')<CR>]])

  -- select all
  vim.keymap.set("n", "<Leader>a", [[<Cmd>lua require('vscode').action('editor.action.selectAll')<CR>]])

  -- yank and put to/from system pasteboard
  vim.keymap.set("", "<Leader>y", '"*y')
  vim.keymap.set("n", "<Leader>yy", '"*yy')
  vim.keymap.set("", "<Leader>p", '"*p')
  vim.keymap.set("", "<Leader>P", '"*P')

  -- toggles
  vim.keymap.set("n", "yow", [[<Cmd>lua require('vscode').action('editor.action.toggleWordWrap')<CR>]])

  -- testing
  vim.keymap.set("n", "<Leader>tt", [[<Cmd>lua require('vscode').action('testing.runAtCursor')<CR>]])
  vim.keymap.set("n", "<Leader>tc", [[<Cmd>lua require('vscode').action('testing.runAll')<CR>]])
  vim.keymap.set("n", "<Leader>tc", [[<Cmd>lua require('vscode').action('testing.debugAtCursor')<CR>]])

  vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
      vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
  })
end

require("vscode").notify("neovim config loaded…")
