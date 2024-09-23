return {
  "rafcamlet/tabline-framework.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",

  config = function()
    vim.cmd "set showtabline=2"

    local Marked = require("harpoon.mark")
    local Config = require("tabline_framework.config")
    local Highlights = require("tabline_framework.highlights")
    local superscript_numbers = {"¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹"}

    local unpinned_buffers_tab = function(selected)
      local hl

      if selected then
        hl = Config.hl_sel
      else
        hl = Config.hl
      end

      return {"  ", fg = hl.fg, bg = hl.bg}
    end

    local pinned_buffer_tab = function(index, selected)
      local file_path = Marked.get_marked_file_name(index)
      local file_name = vim.fn.fnamemodify(file_path, ":t")
      local short_file_path = vim.fn.pathshorten(vim.fn.fnamemodify(file_path, ":~:."))
      local text = " " .. superscript_numbers[index] .. " " .. short_file_path .. " "
      local hl

      if selected then
        hl = Config.hl_sel
      else
        hl = Config.hl
      end

      return {text, fg = hl.fg, bg = hl.bg}
    end

    Marked.on("changed", function()
      vim.cmd ":redrawtabline"
    end)

    local render = function(f)
      local current_buffer_pinned_index = Marked.get_index_of(vim.fn.expand("%"))

      local selected = current_buffer_pinned_index == nil
      f.add(unpinned_buffers_tab(selected))
      f.add(" ")

      if vim.fn.tabpagenr("$") > 1 then
        f.make_tabs(function(info)
          f.add(" ")
          f.add(info.filename or "[no name]")
          f.add(" ")
          f.add({" ", bg = Highlights.get_hl("TablineFill").bg})
        end)
      else
        for index = 1, Marked.get_length() do
          local selected = index == current_buffer_pinned_index
          f.add(pinned_buffer_tab(index, selected))
          f.add(" ")
        end
      end
    end

    require("tabline_framework").setup({render = render})
  end,
}
