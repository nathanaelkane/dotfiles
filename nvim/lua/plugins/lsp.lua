local use = require("packer").use

use {
  "glepnir/lspsaga.nvim",

  requires = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },

  branch = "main",

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

    require("lspsaga").init_lsp_saga()

    -- show diagnostic
    vim.keymap.set("n", "<Leader>cd", require("lspsaga.diagnostic").show_line_diagnostics, {silent = true, noremap = true})

    -- jump to diagnostic
    vim.keymap.set("n", "[e", require("lspsaga.diagnostic").goto_prev, {silent = true, noremap = true})
    vim.keymap.set("n", "]e", require("lspsaga.diagnostic").goto_next, {silent = true, noremap = true})

    -- jump to error
    vim.keymap.set("n", "[E", function()
      require("lspsaga.diagnostic").goto_prev({severity = vim.diagnostic.severity.ERROR})
    end, {silent = true, noremap = true})
    vim.keymap.set("n", "]E", function()
      require("lspsaga.diagnostic").goto_next({severity = vim.diagnostic.severity.ERROR})
    end, {silent = true, noremap = true})

    -- show hover doc and press twice will jumpto hover window
    vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, {silent = true})

    -- scroll in hover doc or definition preview
    vim.keymap.set("n", "<C-f>", function()
      require("lspsaga.action").smart_scroll_with_saga(1)
    end, {silent = true})
    vim.keymap.set("n", "<C-b>", function()
      require("lspsaga.action").smart_scroll_with_saga(-1)
    end, {silent = true})

    -- rename
    vim.keymap.set("n", "gr", require("lspsaga.rename").lsp_rename, {silent = true})
  end,
}
