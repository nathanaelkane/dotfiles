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
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          cmd = { os.getenv("HOME") .. "/.local/share/mise/shims/ruby-lsp" },
        },
      },
      document_highlight = {
        enabled = false,
      },
    },
  },
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
            return { "bin/rspec" }
          end,
        },
      },
    },
  },
}
