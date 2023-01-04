return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-lua/plenary.nvim",

    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-u>"] = false,
              ["<Esc>"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
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
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }

      require("telescope").load_extension("fzf")

      function _G.telescope_find_files_from_current_file_directory()
        dir = vim.fn.expand("%:h")

        if dir ~= "" then
          require("telescope.builtin").find_files({
            cwd = dir,
            prompt_title = "Find Files: " .. dir .. "/",
          })
        end
      end

      function _G.telescope_find_files_with_custom_command(find_command, prompt_title)
        require("telescope.builtin").find_files({
          find_command = {find_command},
          prompt_title = prompt_title,
        })
      end

      function _G.telescope_live_grep_from_entered_directory()
        local dir = vim.fn.input({
          prompt = "Enter a directory: ",
          completion = "dir",
        })

        if dir ~= "" then
          require("telescope.builtin").live_grep({
            prompt_title = "Live Grep: " .. dir,
            cwd = dir,
          })
        end
      end

      function _G.telescope_grep_selected_string()
        local selected_text = _G.get_selected_text()

        if string.find(selected_text, "\n") then
          print("Error: The selected text contains a newline char.")
        else
          require("telescope.builtin").grep_string({
            prompt_title = "Grep String: " .. selected_text,
            search = selected_text,
          })
        end
      end

      local map = require("utils").map

      -- Buffers
      map("n", "<Leader>l", ":lua require('telescope.builtin').buffers()<CR>", {silent = true})

      -- Find files
      map("n", "<Leader>t", ":lua require('telescope.builtin').find_files()<CR>", {silent = true})
      map("n", "<Leader>d", ":call v:lua.telescope_find_files_from_current_file_directory()<CR>", {silent = true})
      map("n", "<Leader>o", ":lua require('telescope.builtin').oldfiles()<CR>", {silent = true})
      map("n", "<Leader>m", ":call v:lua.telescope_find_files_with_custom_command('modified.sh', 'Modified Files')<CR>", {silent = true})
      map("n", "<Leader>M", ":call v:lua.telescope_find_files_with_custom_command('branch_modified.sh', 'Branch Modified Files')<CR>", {silent = true})

      -- Live grep
      map("n", "<Leader>f", ":lua require('telescope.builtin').live_grep()<CR>", {silent = true})
      map("n", "<Leader>F", ":call v:lua.telescope_live_grep_from_entered_directory()<CR>", {silent = true})
      map("n", "<Leader>H", "<Leader>h:lua require('telescope.builtin').grep_string()<CR>", {noremap = false, silent = true})
      map("v", "<Leader>H", "<Leader>h:<C-U>call v:lua.telescope_grep_selected_string()<CR>", {noremap = false, silent = true})

      -- LSP
      map("n", "gd", ":lua require('telescope.builtin').lsp_definitions()<CR>", {silent = true})
      map("n", "gr", ":lua require('telescope.builtin').lsp_references()<CR>", {silent = true})
      map("n", "<Leader>cd", ":lua require('telescope.builtin').lsp_document_diagnostics()<CR>", {silent = true})
      map("n", "<Leader>cw", ":lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>", {silent = true})
      map("n", "<Leader>ca", ":lua require('telescope.builtin').lsp_code_actions()<CR>", {silent = true})
      map("v", "<Leader>ca", ":<C-U>lua require('telescope.builtin').lsp_range_code_actions()<CR>", {silent = true})
    end,
  },
}
