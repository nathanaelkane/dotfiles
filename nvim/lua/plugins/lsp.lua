local use = require("packer").use

use {
  "neovim/nvim-lspconfig",

  config = function()
    -- diagnostic signs

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = true,
      underline = false,
      update_in_insert = false,
    })

    vim.fn.sign_define("DiagnosticSignError", {
      text = " ",
      texthl = "LspDiagnosticsSignError",
      numhl = "LspDiagnosticsLineNrError",
    })

    vim.fn.sign_define("DiagnosticSignWarn", {
      text = " ",
      texthl = "LspDiagnosticsSignWarning",
      numhl = "LspDiagnosticsLineNrWarning",
    })

    vim.fn.sign_define("DiagnosticSignHint", {
      text = " ",
      texthl = "LspDiagnosticsSignHint",
      numhl = "LspDiagnosticsLineNrHint",
    })

    vim.fn.sign_define("DiagnosticSignInfo", {
      text = " ",
      texthl = "LspDiagnosticsSignInformation",
      numhl = "LspDiagnosticsLineNrInformation",
    })

    vim.o.updatetime = 250
    vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

    -- solargraph

    require("lspconfig").solargraph.setup {
      autoformat = false,
      checkGemVersion = false,
      folding = false,
      formatting = false,
      hover = false,
      useBundler = true,
      capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }
  end,
}
