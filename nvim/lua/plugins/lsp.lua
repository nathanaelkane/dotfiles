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

    -- Source: https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#print-diagnostics-in-status-line
    function PrintDiagnostics(opts, bufnr, line_nr, client_id)
      opts = opts or {}

      bufnr = bufnr or 0
      line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)

      local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
      if vim.tbl_isempty(line_diagnostics) then return end

      local diagnostic_message = ""
      for i, diagnostic in ipairs(line_diagnostics) do
        diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
        print(diagnostic_message)
        if i ~= #line_diagnostics then
          diagnostic_message = diagnostic_message .. "\n"
        end
      end
      vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
    end

    vim.o.updatetime = 250
    vim.cmd [[autocmd CursorHold * lua PrintDiagnostics()]]

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

use {
  "williamboman/nvim-lsp-installer",

  config = function()
    local lsp_installer = require("nvim-lsp-installer")

    lsp_installer.on_server_ready(function(server)
      local opts = {}

      -- (optional) Customize the options passed to the server
      -- if server.name == "tsserver" then
      --   opts.root_dir = function() ... end
      -- end

      -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
      server:setup(opts)
      vim.cmd [[do User LspAttachBuffers]]
    end)
  end,
}
