return {
  {
    "stevearc/oil.nvim",
    enabled = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      delete_to_trash = true,
      keymaps = {
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
        ["<Esc>"] = "actions.close",
        ["q"] = "actions.close",
      },
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      {
        "-",
        "<cmd>Oil<cr>",
        desc = "Open file explorer"
      },
    },
  },
}
