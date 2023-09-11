-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","

vim.opt.ignorecase = true -- ignore case by default when searching
vim.opt.smartcase = true -- switch to case sensitive mode if needle contains uppercase characters

-- plugins
require("lazy").setup({
  {
    "phaazon/hop.nvim",
    version = "v1",
    opts = {},
    keys = {
      {"<Leader>ew", mode = "", "<Cmd>HopWordAC<CR>"},
      {"<Leader>eb", mode = "", "<Cmd>HopWordBC<CR>"},
      {"<Leader>ek", mode = "", "<Cmd>HopLineStartBC<CR>"},
      {"<Leader>ej", mode = "", "<Cmd>HopLineStartAC<CR>"},
    },
  },
  {
    "tpope/vim-surround",
  },
  {
    "tpope/vim-repeat",
  },
})

-- jump to start/end of line
vim.keymap.set("", "H", "^")
vim.keymap.set("", "L", "$")

-- toggle comments
vim.keymap.set("x", "gc", "<Plug>VSCodeCommentary")
vim.keymap.set("n", "gcc", "<Plug>VSCodeCommentaryLine")

-- next/prev change
vim.keymap.set("n", "]d", "<Cmd>call VSCodeCall('workbench.action.editor.nextChange')<CR>")
vim.keymap.set("n", "[d", "<Cmd>call VSCodeCall('workbench.action.editor.previousChange')<CR>")

-- next/prev search result
vim.keymap.set("n", "]q", "<Cmd>call VSCodeCall('search.action.focusNextSearchResult')<CR>")
vim.keymap.set("n", "[q", "<Cmd>call VSCodeCall('search.action.focusPreviousSearchResult')<CR>")

-- clear search
vim.keymap.set("", "<Leader>/", "<Cmd>nohls<CR>", {silent = true})

-- jump between current and previous buffers (equivalent to CTRL-^)
vim.keymap.set("n", "<Leader><Leader>", "<Cmd>call VSCodeCall('extension.goto-previous-buffer')<CR>")

-- copy file path
vim.keymap.set("n", "<Leader>cf", "<Cmd>call VSCodeCall('copy-relative-path-and-line-numbers.path-only')<CR>")
vim.keymap.set("n", "<Leader>cl", "<Cmd>call VSCodeCall('copy-relative-path-and-line-numbers.both')<CR>")

-- fix j/k with folds
-- fixes issue: https://github.com/vscode-neovim/vscode-neovim/issues/58
-- solution: https://github.com/vscode-neovim/vscode-neovim/issues/58#issuecomment-1229279216
local function moveCursor(direction)
  if (vim.fn.reg_recording() == "" and vim.fn.reg_executing() == "") then
    return ("g" .. direction)
  else
    return direction
  end
end

vim.keymap.set({"n", "v"}, "k", function()
  return moveCursor("k")
end, {expr = true, remap = true})
vim.keymap.set({"n", "v"}, "j", function()
  return moveCursor("j")
end, {expr = true, remap = true})

-- folds
vim.keymap.set("n", "zM", "<Cmd>call VSCodeNotify('editor.foldAll')<CR>")
vim.keymap.set("n", "zR", "<Cmd>call VSCodeNotify('editor.unfoldAll')<CR>")
vim.keymap.set("n", "zc", "<Cmd>call VSCodeNotify('editor.fold')<CR>")
vim.keymap.set("n", "zC", "<Cmd>call VSCodeNotify('editor.foldRecursively')<CR>")
vim.keymap.set("n", "zo", "<Cmd>call VSCodeNotify('editor.unfold')<CR>")
vim.keymap.set("n", "zO", "<Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>")
vim.keymap.set("n", "za", "<Cmd>call VSCodeNotify('editor.toggleFold')<CR>")

-- open file at cursor
vim.keymap.set("n", "gf", "<Cmd>call VSCodeCall('seito-openfile.openFileFromText')<CR>")

vim.cmd [[
" Search for selected text, forwards or backwards.
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Highlight word/selection at cursor without changing position
map <silent> <Leader>h :
  \:let view=winsaveview()<CR>
  \*
  \:call winrestview(view)<CR>
vmap <silent> <Leader>h :
  \:<C-U>let view=winsaveview()<CR>
  \gv*
  \:<C-U>call winrestview(view)<CR>
]]

vim.keymap.set("n", "<Leader>H", "<Cmd>call VSCodeNotify('workbench.action.findInFiles', {'query': expand('<cword>')})<CR>")
vim.keymap.set("v", "<Leader>H", "<Cmd>call VSCodeNotifyVisual('workbench.action.findInFiles', 0)<CR>")

-- explorer
vim.keymap.set("n", "<Leader>n", "<Cmd>call VSCodeCall('workbench.view.explorer')<CR>")
vim.keymap.set("n", "<Leader>.", "<Cmd>call VSCodeCall('workbench.files.action.showActiveFileInExplorer')<CR>")

-- reselect visual block after indent or outdent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- show all editors
vim.keymap.set("n", "<Leader>l", "<Cmd>call VSCodeNotify('workbench.action.showAllEditors')<CR>")

-- yank from cursor to end of line
vim.keymap.set("", "Y", "y$")

-- yank and put to/from system pasteboard
vim.keymap.set("", "<Leader>y", '"*y')
vim.keymap.set("n", "<Leader>yy", '"*yy')
vim.keymap.set("", "<Leader>p", '"*p')
vim.keymap.set("", "<Leader>P", '"*P')

-- bubble line up/down
vim.keymap.set("n", "<A-j>", "<Cmd>call VSCodeNotify('editor.action.moveLinesDownAction')<CR>")
vim.keymap.set("n", "<A-k>", "<Cmd>call VSCodeNotify('editor.action.moveLinesUpAction')<CR>")

-- commands
vim.api.nvim_create_user_command("A", "call VSCodeCall('alternateFile.alternateFile')", {})
