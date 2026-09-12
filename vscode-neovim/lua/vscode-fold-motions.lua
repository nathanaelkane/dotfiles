-- vscode-fold-motions.lua
--
-- Fold-aware motions and operators for vscode-neovim.
--
-- =============================================================================
-- THE PROBLEM
-- =============================================================================
--
-- vscode-neovim force-disables folding inside Neovim (see its
-- runtime/lua/vscode/force-options.lua: foldenable=false, foldmethod=manual).
-- That is deliberate -- Neovim's buffer must stay a flat, line-for-line mirror
-- of VS Code's -- but it means Neovim has no idea that any fold exists.
--
-- So with lines 10..15 collapsed, `j` from line 10 moves to line 11. VS Code
-- then scrolls the cursor into view, which pops the fold open. In Visual mode
-- nothing is revealed, so instead you press `j` five times into the void. And
-- `dd` on the fold line deletes one line rather than the whole fold.
--
-- =============================================================================
-- THE APPROACH
-- =============================================================================
--
-- VS Code's `TextEditor.visibleRanges` splits into several ranges whenever
-- something is collapsed: the gaps between consecutive ranges ARE the hidden
-- line spans. We read that over `vscode.eval`, then issue plain Neovim keys
-- (`6j`, `V5jd`) computed from it.
--
-- Neovim therefore stays authoritative for every motion and operator, which is
-- why Visual mode, registers, counts, undo and dot-repeat keep working
-- natively. The alternative -- driving VS Code's own `cursorMove` command, as
-- most workarounds do -- moves VS Code's cursor instead, and cannot express a
-- Visual selection or an operator range at all.
--
-- Two invariants matter:
--
--   1. The cursor must never come to REST inside a fold. vscode-neovim calls
--      `editor.revealRange()` on every cursor move (cursor_manager.ts), which is
--      precisely what expands a fold. Every sequence below is issued as one
--      atomic `nvim_feedkeys` and settles on a visible line.
--
--   2. A fold whose lines get deleted must be expanded FIRST. VS Code anchors a
--      collapsed region to the lines it was created on; delete them from
--      Neovim's side and the region survives as a stale ellipsis that now hides
--      whatever followed. See unfold_within().
--
-- =============================================================================
-- WHAT THIS MAPS
-- =============================================================================
--
--   j k          n, x, o   step over a closed fold instead of expanding it.
--                          In operator-pending mode `j` runs to the fold's far
--                          side, so `dj` above a fold removes the fold too.
--
--   d y c x      x         operate on the whole fold when the selection touches
--   p P J gJ               one (`:h fold-behavior`). Registers are preserved.
--   < > gu gU gq
--
--   dd yy cc     n         same, for the doubled linewise forms.
--   << >> guu
--   gUU gqq
--
--   p            n         paste a LINEWISE register after the whole fold
--                          rather than after its header line.
--
--   za zc zC zo  n         Vim's fold keys -> VS Code's folding commands.
--   zO zM zR zj zk
--   zf           x         create a manual fold from the selection.
--   zE           n         remove all manual folds.
--
-- Deliberately NOT mapped, because real Vim does not treat a closed fold as a
-- unit for them (verified against Vim's own folding, see the test suite):
--
--   J, gJ in normal mode  join only the next line, fold or not.
--   P     in normal mode  already pastes before the fold, since that is before
--                         the header line too.
--   p     with a charwise or blockwise register  pastes inline into the header.
--
-- =============================================================================
-- REQUIREMENTS AND COST
-- =============================================================================
--
-- Requires vscode-neovim >= 1.8.0, which is where `vscode.eval()` landed
-- (vscode-neovim#1854). Nothing here needs a recent VS Code: `visibleRanges`
-- long predates the problem, and the `cursorMove by:"foldedLine"` unit added in
-- VS Code 1.111 is deliberately NOT used, since it can only move the cursor.
--
-- Every fold query is a synchronous RPC round-trip to the extension host --
-- typically a few milliseconds. One per `j`/`k` (two in operator-pending mode),
-- two or three per operator. Held-down `j` is the worst case; if that ever feels
-- sluggish, the cheap normal-mode-only alternative is:
--
--   vim.keymap.set("n", "j", function()
--     require("vscode").action("cursorMove",
--       { args = { to = "down", by = "foldedLine", value = vim.v.count1 } })
--   end, { silent = true })
--
-- =============================================================================
-- KNOWN LIMITATIONS
-- =============================================================================
--
-- All three trace to the same root cause: VS Code exposes no API for "which
-- regions are currently collapsed" (microsoft/vscode#22276, #81498 -- the
-- latter was closed in 2026 by adding a cursorMove unit, not the API). All we
-- have is the viewport, via visibleRanges.
--
--   1. A fold whose header is the BOTTOM-MOST VISIBLE LINE has no range after
--      it, so the gap is invisible and everything falls back to plain Vim.
--      Scrolling down one line is enough to fix it.
--
--   2. Only folds ON SCREEN can be seen, so a collapsed region far below the
--      viewport inside a very large selection is not expanded before a delete,
--      and can be left stranded.
--
--   3. An operator that STARTS on a fold header and moves outward the other way
--      (`dk`, `d{`, `dG`) covers only the header line, not the fold body: the
--      fold sits outside the range the two cursor positions describe, and
--      Neovim has no folds here to widen it against. `dd`, `Vd` and `dj` are
--      exact.
--
-- =============================================================================
-- TESTS
-- =============================================================================
--
--   nvim --headless -u NONE -i NONE -l test/fold_motions_spec.lua
--   nvim --headless -u NONE -i NONE -l test/vim_reference.lua
--
-- The first drives these mappings against a stubbed `vscode` module. The second
-- pins down what real Vim folding does, so the expectations in the first are
-- verified rather than assumed. Both exit non-zero on failure.

if not vim.g.vscode then
  return
end

local vscode = require("vscode")

-- ---------------------------------------------------------------------------
-- Reading VS Code's fold state
--
-- All three snippets run in the extension host with the VS Code API in scope.
-- Line numbers crossing this boundary are 0-indexed, matching the API; Neovim
-- line numbers are 1-indexed. Conversions are marked at each call site.
-- ---------------------------------------------------------------------------

-- Given `args.line` is the header of a collapsed region, the first visible line
-- AFTER that region. nil if `args.line` is not a collapsed fold header.
local JS_BELOW = [[
  const ed = vscode.window.activeTextEditor;
  if (!ed) { return null; }
  const rs = ed.visibleRanges;
  for (let i = 0; i < rs.length - 1; i++) {
    if (rs[i].end.line === args.line && rs[i + 1].start.line > args.line + 1) {
      return rs[i + 1].start.line;
    }
  }
  return null;
]]

-- Given `args.line` is the first visible line after a collapsed region, the
-- header line of that region. nil if nothing is collapsed just above.
local JS_ABOVE = [[
  const ed = vscode.window.activeTextEditor;
  if (!ed) { return null; }
  const rs = ed.visibleRanges;
  for (let i = 1; i < rs.length; i++) {
    if (rs[i].start.line === args.line && rs[i - 1].end.line < args.line - 1) {
      return rs[i - 1].end.line;
    }
  }
  return null;
]]

-- Header lines of every collapsed region currently on screen.
local JS_COLLAPSED = [[
  const ed = vscode.window.activeTextEditor;
  if (!ed) { return []; }
  const rs = ed.visibleRanges;
  const out = [];
  for (let i = 0; i < rs.length - 1; i++) {
    if (rs[i + 1].start.line > rs[i].end.line + 1) { out.push(rs[i].end.line); }
  }
  return out;
]]

-- Generous: a slow extension host should degrade to plain Vim behaviour, never
-- hang the editor. Every caller treats a timeout as "no fold here".
local TIMEOUT_MS = 200

-- The visible line adjacent to `line` (0-indexed) across a collapsed region,
-- or nil when no region is collapsed in that direction.
local function neighbour(line, down)
  local ok, res = pcall(vscode.eval, down and JS_BELOW or JS_ABOVE, { args = { line = line } }, TIMEOUT_MS)
  if ok and type(res) == "number" then
    return res
  end
  return nil
end

-- ---------------------------------------------------------------------------
-- Motions
-- ---------------------------------------------------------------------------

local function move(down)
  local key = down and "j" or "k"

  -- With an explicit count Vim counts a closed fold as one line, which we
  -- cannot express as a single jump without walking fold by fold. Counts are
  -- usually aimed at a line the user can see, so plain `5j` is the better
  -- guess -- and it costs no round-trip.
  if vim.v.count > 0 then
    return key
  end

  local cur = vim.fn.line(".") - 1 -- to 0-indexed
  local target = neighbour(cur, down)

  -- mode(1) is "no"/"nov"/"noV" while an operator is pending.
  if down and vim.fn.mode(1):sub(1, 2) == "no" then
    -- Vim swallows a whole closed fold that a motion lands on, so `dj` from the
    -- line above a fold removes the fold as well. Run the motion to the fold's
    -- last line rather than stopping on its header.
    --
    -- `neighbour` returns the first line AFTER the fold, which in 0-indexed
    -- terms is the same number as the fold's last line in 1-indexed terms --
    -- hence the -1 to land on the last folded line.
    local landing = target or (cur + 1)
    local after = neighbour(landing, true)
    if after then
      target = after - 1
    end
  end

  if not target then
    return key
  end

  -- A delta of 0 or 1 is what plain j/k would do anyway; returning the bare key
  -- keeps curswant and `:h 'startofline'` behaviour untouched.
  local delta = math.abs(target - cur)
  if delta < 2 then
    return key
  end
  return delta .. key
end

-- expr mappings: `replace_keycodes` defaults to true alongside `expr`, and the
-- returned string ("6j") is fed as if typed.
local opts = { expr = true, silent = true, desc = "Fold-aware motion" }
vim.keymap.set({ "n", "x", "o" }, "j", function() return move(true) end, opts)
vim.keymap.set({ "n", "x", "o" }, "k", function() return move(false) end, opts)

-- ---------------------------------------------------------------------------
-- Operators
--
-- Vim expands an operator's range to cover a whole closed fold (`:h
-- fold-behavior`), so `Vd` and `dd` on a fold line remove all of it. We widen
-- the range ourselves, then hand plain keys back to Neovim.
-- ---------------------------------------------------------------------------

-- 1-indexed last line of the collapsed region headed by `line` (1-indexed), or
-- nil when `line` is not a closed fold header. The index bases cancel out: the
-- 0-indexed first line after the fold equals the 1-indexed last line in it.
local function fold_last(line)
  return neighbour(line - 1, true)
end

-- Widen [l1, l2] so a closed fold touching either end is covered in full.
-- Folds strictly inside the range need no handling -- they are already spanned,
-- hidden lines included.
local function expanded_last(l1, l2)
  local target = l2
  local last = fold_last(l2)
  if last and last > target then
    target = last
  end
  if l1 ~= l2 then
    last = fold_last(l1)
    if last and last > target then
      target = last
    end
  end
  return target
end

-- Expand every collapsed region within [first, last] before an operator removes
-- those lines, so VS Code is left with no region anchored to deleted text.
--
-- `editor.unfold` with a large `levels` does exactly what
-- `editor.unfoldRecursively` does, and additionally honours `selectionLines`:
-- unfoldRecursively reads the editor's own selection, which is not necessarily
-- where we are operating. One call handles every fold in range.
local function unfold_within(first, last)
  local ok, headers = pcall(vscode.eval, JS_COLLAPSED, {}, TIMEOUT_MS)
  if not ok or type(headers) ~= "table" then
    return
  end
  local selection = {}
  for _, header in ipairs(headers) do
    if header + 1 >= first and header + 1 <= last then -- header is 0-indexed
      table.insert(selection, header)
    end
  end
  if #selection > 0 then
    pcall(vscode.call, "editor.unfold", {
      args = { levels = 9999, selectionLines = selection },
    })
  end
end

-- { operator,
--   normal-mode doubled form (nil = Visual only),
--   accepts a register prefix (`"ad`),
--   changes the line count, so any fold in range must be expanded first }
local OPERATORS = {
  { "d", "dd", true, true },
  { "y", "yy", true, false },
  { "c", "cc", true, true },
  { "x", nil, true, true },
  { "p", nil, true, true },
  { "P", nil, true, true },
  { "J", nil, false, true },
  { "gJ", nil, false, true },
  { "<", "<<", false, false },
  { ">", ">>", false, false },
  { "gu", "guu", false, false },
  { "gU", "gUU", false, false },
  { "gq", "gqq", false, true },
}

-- Read at keypress time, not setup time: v:register holds whatever `"a` the
-- user just typed. Operators that take no register must not be given one.
local function register_prefix(takes_register)
  return takes_register and ('"' .. vim.v.register) or ""
end

local function visual_operator(key, takes_register, drops_lines)
  return function()
    local anchor, active = vim.fn.line("v"), vim.fn.line(".")
    local l1, l2 = math.min(anchor, active), math.max(anchor, active)
    local target = expanded_last(l1, l2)
    if drops_lines then
      unfold_within(l1, target)
    end

    local keys = ""
    if target > l2 then
      -- `o` first when the cursor sits at the TOP of the selection, so the end
      -- we are about to extend is the one under the cursor.
      if active < anchor then
        keys = "o"
      end
      keys = keys .. (target - l2) .. "j"
    end

    -- "n" = no remapping, so this cannot recurse through these same mappings.
    -- "i" = insert at the FRONT of the typeahead, so the keys cannot land
    -- behind input that is already queued (during a macro, say). Deliberately
    -- not "x", which forces immediate execution and cut short the insert mode
    -- that `c` needs to enter.
    vim.api.nvim_feedkeys(keys .. register_prefix(takes_register) .. key, "ni", false)
  end
end

-- `dd` / `yy` / `>>` / `guu` ... on a closed fold act on the whole fold.
local function linewise_operator(key, doubled, takes_register, drops_lines)
  return function()
    local count = vim.v.count > 0 and tostring(vim.v.count) or ""
    local register = register_prefix(takes_register)
    local line = vim.fn.line(".")

    -- With a count, "n lines" means "n folds-or-lines" in Vim; leave that to
    -- Neovim rather than guessing, and only expand the folds it will swallow.
    local last = count == "" and fold_last(line) or nil
    if not last then
      if drops_lines then
        unfold_within(line, line + math.max(vim.v.count, 1) - 1)
      end
      vim.api.nvim_feedkeys(count .. register .. doubled, "ni", false)
      return
    end

    if drops_lines then
      unfold_within(line, last)
    end
    -- Select the fold linewise, then apply the single-key operator to it.
    vim.api.nvim_feedkeys("V" .. (last - line) .. "j" .. register .. key, "ni", false)
  end
end

for _, op in ipairs(OPERATORS) do
  local key, doubled, takes_register, drops_lines = op[1], op[2], op[3], op[4]
  vim.keymap.set("x", key, visual_operator(key, takes_register, drops_lines), {
    silent = true,
    desc = "Fold-aware " .. key,
  })
  if doubled then
    vim.keymap.set("n", doubled, linewise_operator(key, doubled, takes_register, drops_lines), {
      silent = true,
      desc = "Fold-aware " .. doubled,
    })
  end
end

-- Real Vim pastes a LINEWISE register after the whole closed fold, not after
-- its header line. A charwise or blockwise register goes inline into the header
-- instead, and `P` already lands before the fold, so neither needs help here.
--
-- No unfold_within: this only inserts lines below the fold, leaving the region
-- itself intact and correctly anchored.
vim.keymap.set("n", "p", function()
  local register = vim.v.register
  local keys = (vim.v.count > 0 and tostring(vim.v.count) or "") .. '"' .. register .. "p"

  -- "V" is linewise; "v" charwise and "\22" (CTRL-V) blockwise are unaffected.
  local line = vim.fn.line(".")
  local last = vim.fn.getregtype(register):sub(1, 1) == "V" and fold_last(line) or nil
  if not last then
    vim.api.nvim_feedkeys(keys, "ni", false)
    return
  end

  -- Step to the fold's last line and paste from there, inside one feedkeys so
  -- the transient cursor position never reaches VS Code.
  vim.api.nvim_feedkeys((last - line) .. "j" .. keys, "ni", false)
end, { silent = true, desc = "Fold-aware p" })

-- ---------------------------------------------------------------------------
-- Vim's z-fold keys -> VS Code's folding commands
--
-- Neovim's own fold commands are inert here (foldenable is forced off), so
-- these hand off to VS Code, which owns the folds.
-- ---------------------------------------------------------------------------

local function map_fold(lhs, command)
  vim.keymap.set("n", lhs, function() vscode.action(command) end, { silent = true })
end

map_fold("za", "editor.toggleFold")
map_fold("zc", "editor.fold")
map_fold("zC", "editor.foldRecursively")
map_fold("zo", "editor.unfold")
map_fold("zO", "editor.unfoldRecursively")
map_fold("zM", "editor.foldAll")
map_fold("zR", "editor.unfoldAll")
map_fold("zj", "editor.gotoNextFold")
map_fold("zk", "editor.gotoPreviousFold")

-- `zf` over a Visual selection creates a manual fold; `zE` removes them all.
vim.keymap.set("x", "zf", function() vscode.action("editor.createFoldingRangeFromSelection") end, { silent = true })
vim.keymap.set("n", "zE", function() vscode.action("editor.removeManualFoldingRanges") end, { silent = true })

