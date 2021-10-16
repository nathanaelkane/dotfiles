local fn = vim.fn

-- Install Packer
local packer_install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(packer_install_path)) > 0 then
  fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_install_path})
  vim.cmd "packadd packer.nvim"
end

-- Install Plenary
local plenary_install_path = fn.stdpath("data") .. "/site/pack/packer/start/plenary.nvim"
if fn.empty(fn.glob(plenary_install_path)) > 0 then
  fn.system({"git", "clone", "--depth", "1", "https://github.com/nvim-lua/plenary.nvim", plenary_install_path})
  vim.cmd "packadd plenary.nvim"
end

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim"

  local plugin_dir = fn.stdpath("config") .. "/lua/plugins"
  local plugin_files = require("plenary.scandir").scan_dir(plugin_dir, {depth = 1})

  for _, plugin_file in ipairs(plugin_files) do
    local plugin = string.match(plugin_file, plugin_dir .. "/([a-z-]+).lua")
    require("plugins." .. plugin)
  end

  use "AndrewRadev/linediff.vim"
  use "bogado/file-line"
end)
