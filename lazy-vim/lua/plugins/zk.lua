return {
  {
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup({
        picker = "snacks_picker",
        lsp = {
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
          },
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          },
        },
      })
    end,
    keys = {
      {
        "<leader>zn",
        "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
        desc = "Create a new note",
      },
      {
        "<leader>zz",
        "<Cmd>ZkNotes { sort = { 'modified' } }<CR>",
        desc = "Search for notes",
      },
    },
  },
}
