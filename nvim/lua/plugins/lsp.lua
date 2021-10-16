local use = require("packer").use

use {
  "neovim/nvim-lspconfig",

  -- diagnostic signs

  config = function()
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

    -- solargraph

    require("lspconfig").solargraph.setup {
      autoformat = false,
      checkGemVersion = false,
      folding = false,
      formatting = false,
      hover = false,
      useBundler = true,
    }
  end,
}
