-- brew install --HEAD universal-ctags/universal-ctags/universal-ctags
-- gem install CoffeeTags

local use = require("packer").use

use {
  "ludovicchabant/vim-gutentags",

  setup = function()
    vim.g.gutentags_cache_dir = "/tmp"
    vim.g.gutentags_generate_on_empty_buffer = 1
    vim.g.gutentags_define_advanced_commands = 1

    if vim.fn.executable('rg') == 1 then
      vim.g.gutentags_file_list_command = "rg --files"
    end
  end,
}
