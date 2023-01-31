return {
  "nvim-tree/nvim-tree.lua",
  version = "nightly", -- updated weekly
  lazy = false,

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("nvim-tree").setup {
      view = {
        width = 40,
      },
    }

    local function open_nvim_tree(data)
      -- buffer is a [No Name]
      local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

      if not no_name then
        return
      end

      -- open the tree, find the file but don't focus it
      require("nvim-tree.api").tree.toggle({focus = false, find_file = true})
    end

    vim.api.nvim_create_autocmd({"VimEnter"}, {callback = open_nvim_tree})

    -- quit if nvim-tree is the last buffer
    vim.api.nvim_create_autocmd("BufEnter", {
      nested = true,
      callback = function()
        if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
          vim.cmd "quit"
        end
      end
    })
  end,

  keys = {
    {"<Leader>n", "<Cmd>NvimTreeToggle<CR>"},
    {"<Leader>.", "<Cmd>NvimTreeFindFile<CR>"},
  },
}
