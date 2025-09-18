return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      -- netcoredbg has no native macOS arm64 build, have to compile manually
      for i, v in ipairs(opts.ensure_installed) do
        if v == "netcoredbg" then
          table.remove(opts.ensure_installed, i)
          break
        end
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "Issafalcon/neotest-dotnet",
    },
    opts = {
      adapters = {
        ["neotest-dotnet"] = {
          discovery_root = "solution",
        },
      },
    },
  },
}
