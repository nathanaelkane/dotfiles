-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/ruby.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ruby",
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ruby-lsp",
        "solargraph",
        -- "standardrb",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          cmd = { "bundle", "exec", "ruby-lsp" },
        },
        solargraph = {
          cmd = { "bundle", "exec", "solargraph", "stdio" },
        },
        -- standardrb = {},
      },
      document_highlight = {
        enabled = false,
      },
    },
  },
  -- {
  --   "mfussenegger/nvim-dap",
  --   optional = true,
  --   dependencies = {
  --     "suketa/nvim-dap-ruby",
  --     config = function()
  --       require("dap-ruby").setup()
  --     end,
  --   },
  -- },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "olimorris/neotest-rspec",
    },
    opts = {
      adapters = {
        ["neotest-rspec"] = {
          rspec_cmd = function()
            return vim.tbl_flatten({ "bin/rspec" })
          end,
        },
      },
    },
  },
}
