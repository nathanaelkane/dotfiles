-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local options = {
  cmdheight = 2, -- make the command line a little taller
  conceallevel = 0, -- turn off conceal
  hidden = true, -- allow hiding buffers with unsaved changes
  ignorecase = true, -- ignore case by default when searching
  number = true, -- line numbers
  relativenumber = false, -- relative line numbers
  cursorline = true, -- highlight the current line/number
  cursorlineopt = "number", -- default: number,line
  scrolloff = 3, -- number of screen lines to keep above and below the cursor
  showmode = false, -- already shown in statusline
  sidescrolloff = 3, -- number of screen columns to keep to the left and right of the cursor
  signcolumn = "yes", -- always show
  smartcase = true, -- switch to case sensitive mode if needle contains uppercase characters
  smartindent = true, -- smart autoindenting when starting a new line
  swapfile = false, -- disable creation of *.swp files
  termguicolors = true, -- enable 24-bit RGB color in the tui
  timeoutlen = 500, -- time in milliseconds to wait for a mapped sequence to complete
  wrap = false, -- display lines as one long line

  -- indentation
  autoindent = true, -- keep the indent when creating a new line
  cindent = true, -- recommended setting for automatic c-style indentation
  expandtab = true, -- indent with spaces instead of tabs
  shiftwidth = 2, -- number of spaces to use in each autoindent step
  smarttab = true, -- use shiftwidth and softtabstop to insert or delete (on <BS>) blanks
  softtabstop = 2, -- number of spaces to skip or insert when <BS>ing or <Tab>ing
  tabstop = 2, -- insert 2 spaces for a tab

  -- undo
  undofile = true,
  undolevels = 1000,
  undoreload = 10000,

  -- fold
  foldmethod = "indent",
  foldnestmax = 10,
  foldenable = false,
  foldlevel = 99, -- expand all folds by default
  foldminlines = 0,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
