return {
  {
    "ibhagwan/fzf-lua",
    keys = {
      {
        "<leader>m",
        function()
          require("fzf-lua").files({
            cmd = "modified.sh",
            actions = require("fzf-lua").defaults.actions.files,
            winopts = {
              preview = {
                hidden = "nohidden",
              },
              title = " Modified files ",
              title_pos = "center",
            },
          })
        end,
        desc = "Modified files",
        silent = true,
      },
      {
        "<leader>M",
        function()
          require("fzf-lua").files({
            cmd = "branch_modified.sh",
            actions = require("fzf-lua").defaults.actions.files,
            winopts = {
              preview = {
                hidden = "nohidden",
              },
              title = " Branch modified files ",
              title_pos = "center",
            },
          })
        end,
        desc = "Branch modified files",
        silent = true,
      },
    },
  },
}
