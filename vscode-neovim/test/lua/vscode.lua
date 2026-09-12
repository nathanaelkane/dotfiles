-- Stand-in for vscode-neovim's `vscode` Lua module, so the mappings in
-- ../vscode-fold-motions.lua can be driven in headless Neovim with no VS Code.
--
-- It models the only two things they depend on:
--
--   * `eval` answers the three JS snippets by synthesising `visibleRanges` from
--     _G.FOLDS the way VS Code would -- contiguous spans of visible lines with
--     each collapsed region's body cut out.
--   * `call` applies `editor.unfold` by dropping the named regions from
--     _G.FOLDS, and records them in _G.UNFOLDED so tests can assert on them.
--
-- _G.FOLDS is a list of {header, last} pairs, 1-indexed and inclusive, where
-- `header` stays visible and header+1..last are hidden.

local M = {}
_G.FOLDS = {}
_G.UNFOLDED = {} -- 0-indexed header lines passed to editor.unfold

local function visible_ranges()
  local hidden = {}
  for _, f in ipairs(_G.FOLDS) do
    for l = f[1] + 1, f[2] do hidden[l] = true end
  end
  local ranges, start = {}, nil
  local total = vim.api.nvim_buf_line_count(0)
  for l = 1, total do
    if hidden[l] then
      if start then table.insert(ranges, { start - 1, l - 2 }); start = nil end
    else
      start = start or l
    end
  end
  if start then table.insert(ranges, { start - 1, total - 1 }) end
  return ranges -- 0-indexed {startLine, endLine}
end

function M.eval(code, opts, _timeout)
  local rs = visible_ranges()
  if code:find("out%.push") then -- JS_COLLAPSED
    local out = {}
    for i = 1, #rs - 1 do
      if rs[i + 1][1] > rs[i][2] + 1 then table.insert(out, rs[i][2]) end
    end
    return out
  end
  local line = opts.args.line -- 0-indexed
  if code:find("i %+ 1") then
    for i = 1, #rs - 1 do
      if rs[i][2] == line and rs[i + 1][1] > line + 1 then return rs[i + 1][1] end
    end
  else
    for i = 2, #rs do
      if rs[i][1] == line and rs[i - 1][2] < line - 1 then return rs[i - 1][2] end
    end
  end
  return nil
end

function M.call(name, opts)
  if name ~= "editor.unfold" then return end
  local args = opts.args
  if vim.islist(args) then args = args[1] end
  for _, header0 in ipairs(args.selectionLines or {}) do
    table.insert(_G.UNFOLDED, header0)
    for i = #_G.FOLDS, 1, -1 do
      if _G.FOLDS[i][1] == header0 + 1 then table.remove(_G.FOLDS, i) end
    end
  end
end

function M.action(_name, _opts) end
function M.notify(_msg) end
return M
