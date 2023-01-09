return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "v2.x",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },

  config = function()
    local map = require("utils").map

    vim.cmd([[let g:neo_tree_remove_legacy_commands = 1]])

    require("neo-tree").setup({
      window = {
        mappings = {
          ["w"] = "",
        },
      },
    })
  end,

  keys = {
    {"<Leader>n", "<Cmd>Neotree position=left toggle=true<CR>"},
    {"<Leader>N", "<Cmd>Neotree source=buffers position=left toggle=true<CR>"},
    {"<Leader>.", "<Cmd>Neotree position=left reveal=true<CR>"},
    {"-", "<Cmd>Neotree position=current toggle=true reveal=true<CR>"},
  },
}
