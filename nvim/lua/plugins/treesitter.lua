local use = require("packer").use

use {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  requires = {
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
  },

  config = function()
    local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
    parser_configs.http = {
      install_info = {
        url = "https://github.com/NTBBloodbath/tree-sitter-http",
        files = {"src/parser.c"},
        branch = "main",
      },
    }

    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "bash",
        "dockerfile",
        "html",
        "http",
        "javascript",
        "json",
        "lua",
        "query",
        "rst",
        "ruby",
        "typescript",
        "vim",
        "yaml",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = false,
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },
    }

    require("treesitter-context").setup {
      patterns = {
        yaml = {
          "block_mapping_pair",
        },
      },
    }
  end,
}
