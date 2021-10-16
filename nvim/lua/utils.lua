local M = {}

M.merge = function(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

M.map = function(modes, key, result, options)
  options = M.merge({
    noremap = true,
    silent = false,
    expr = false,
    nowait = false,
  }, options or {})
  local buffer = options.buffer
  options.buffer = nil

  if type(modes) ~= "table" then
    modes = {modes}
  end

  for i = 1, #modes do
    if buffer then
      vim.api.nvim_buf_set_keymap(0, modes[i], key, result, options)
    else
      vim.api.nvim_set_keymap(modes[i], key, result, options)
    end
  end
end

-- Source: https://vim.fandom.com/wiki/Search_for_visually_selected_text#Readable_equivalent
_G.get_selected_text = function()
  local old_register = vim.fn.getreg('"')
  local old_register_type = vim.fn.getregtype('"')
  vim.cmd [[silent norm gvy]]
  local selected_text = vim.fn.getreg('"')
  vim.fn.setreg('"', old_register, old_register_type)
  vim.cmd [[silent norm \<Esc>]]
  return selected_text
end

-- Source: https://github.com/nanotee/nvim-lua-guide#tips-3
function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

return M
