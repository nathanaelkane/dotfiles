return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-u>"] = false,
            ["<Esc>"] = require("telescope.actions").close,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
        },
        git_files = {
          theme = "dropdown",
          previewer = false,
        },
        oldfiles = {
          theme = "dropdown",
          previewer = false,
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
          ignore_current_buffer = true,
          sort_mru = true,
        },
        live_grep = {
          previewer = false,
        }
      },
    },
    keys = {
      {
        "<leader>m",
        function()
          require("telescope.builtin").find_files({
            find_command = {"modified.sh"},
            prompt_title = "Modified Files",
          })
        end,
        desc = "Modified Files",
        silent = true,
      },
      {
        "<leader>M",
        function()
          require("telescope.builtin").find_files({
            find_command = {"branch_modified.sh"},
            prompt_title = "Branch Modified Files",
          })
        end,
        desc = "Branch Modified Files",
        silent = true,
      },
      {
        "<leader>l",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
    },
  }
}
