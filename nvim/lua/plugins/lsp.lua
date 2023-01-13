return {
  "glepnir/lspsaga.nvim",

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },

  version = "main",

  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup {
      ensure_installed = {
        "yamlls",
      }
    }

    require("lspconfig").solargraph.setup {
      autoformat = false,
      checkGemVersion = false,
      folding = false,
      formatting = false,
      hover = false,
      useBundler = true,
      capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }

    require("lspconfig").yamlls.setup {
      capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }

    require("lspsaga").setup({})

    -- show diagnostic
    vim.keymap.set("n", "<Leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>")

    -- jump to diagnostic
    vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

    -- jump to error
    vim.keymap.set("n", "[E", function()
      require("lspsaga.diagnostic").goto_prev({severity = vim.diagnostic.severity.ERROR})
    end)
    vim.keymap.set("n", "]E", function()
      require("lspsaga.diagnostic").goto_next({severity = vim.diagnostic.severity.ERROR})
    end)

    -- show hover doc and press twice will jumpto hover window
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")

    -- rename
    vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>")
  end,
}
