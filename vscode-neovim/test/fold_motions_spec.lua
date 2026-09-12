-- Tests for ../vscode-fold-motions.lua, driven in headless Neovim against the
-- stubbed `vscode` module in ./lua/vscode.lua (no VS Code required).
--
--   nvim --headless -u NONE -i NONE -l test/fold_motions_spec.lua
--
-- Exits 0 when everything passes, 1 otherwise, so it drops straight into CI or
-- a git hook. Set $FOLD_MOTIONS to test a file somewhere other than the
-- sibling default.
--
-- Expectations here mirror real Vim's fold behaviour, which ./vim_reference.lua
-- verifies independently against Neovim's own folds. Change one, check both.
--
-- Fixture unless a test says otherwise: a 20-line buffer "line1".."line20",
-- with lines 10..15 collapsed (line 10 is the visible header, 11..15 hidden).

local here = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])")
vim.opt.runtimepath:prepend(here) -- so require("vscode") finds the stub

-- Works whether the config sits beside test/ or in a sibling lua/ directory
-- (the layout Neovim's `require` wants). $FOLD_MOTIONS overrides both.
local target = vim.env.FOLD_MOTIONS
if not target then
  for _, candidate in ipairs({ "../vscode-fold-motions.lua", "../lua/vscode-fold-motions.lua" }) do
    if vim.fn.filereadable(here .. candidate) == 1 then
      target = here .. candidate
      break
    end
  end
end
if not target or vim.fn.filereadable(target) == 0 then
  io.stderr:write("cannot find vscode-fold-motions.lua (set $FOLD_MOTIONS)\n")
  vim.cmd("cq!")
end

vim.g.vscode = true
dofile(target)

-- ---------------------------------------------------------------------------
-- Harness
-- ---------------------------------------------------------------------------

local pass, fail = 0, 0

local function section(name)
  print("\n== " .. name .. " ==")
end

local function check(name, got, want)
  if got == want then
    pass = pass + 1
    print("  ok   " .. name)
  else
    fail = fail + 1
    print(("  FAIL %s\n         got:  %s\n         want: %s"):format(name, tostring(got), tostring(want)))
  end
end

-- `folds` is a list of {header, last}, 1-indexed inclusive. Defaults to one
-- fold over lines 10..15.
local function reset(folds)
  vim.cmd("silent! normal! \28\14") -- <C-\><C-n>: back to normal mode
  local lines = {}
  for i = 1, 20 do
    lines[i] = "line" .. i
  end
  -- undolevels=-1 around the seed keeps it out of the undo tree, so `u` in a
  -- test undoes only what that test did.
  local undolevels = vim.bo.undolevels
  vim.bo.undolevels = -1
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.bo.undolevels = undolevels
  vim.bo.textwidth = 0
  vim.bo.shiftwidth = 2
  vim.bo.expandtab = true
  _G.FOLDS = folds or { { 10, 15 } }
  _G.UNFOLDED = {}
end

local function feed(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "mx", false)
end

local function buf()
  return table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), ",")
end

-- 1-indexed inclusive slice of the buffer.
local function lines(first, last)
  return table.concat(vim.api.nvim_buf_get_lines(0, first - 1, last, false), ",")
end

-- 0-indexed header lines that were passed to editor.unfold.
local function unfolded()
  return table.concat(_G.UNFOLDED, ",")
end

local ABOVE = "line1,line2,line3,line4,line5,line6,line7,line8"
local BELOW = "line16,line17,line18,line19,line20"
local FOLD_GONE = ABOVE .. ",line9," .. BELOW
local WHOLE_FOLD = "line10\nline11\nline12\nline13\nline14\nline15\n"

-- ---------------------------------------------------------------------------

section("motions step over a fold")
reset(); vim.fn.cursor(9, 1); feed("j")
check("j onto the fold header", vim.fn.line("."), 10)
feed("j")
check("j off the header skips the body", vim.fn.line("."), 16)
reset(); vim.fn.cursor(16, 1); feed("k")
check("k lands on the header, not the last folded line", vim.fn.line("."), 10)
reset({}); vim.fn.cursor(9, 1); feed("j")
check("j with no folds", vim.fn.line("."), 10)

section("visual operators cover the whole fold")
reset(); vim.fn.cursor(10, 1); feed("Vd")
check("Vd deletes the whole fold", buf(), ABOVE .. ",line9," .. BELOW)
check("Vd leaves the cursor on a visible line", vim.fn.line("."), 10)
reset(); vim.fn.cursor(10, 1); feed("Vy")
check("Vy yanks the whole fold", vim.fn.getreg('"'), WHOLE_FOLD)
check("Vy leaves the cursor on a visible line", vim.fn.line("."), 10)
reset(); vim.fn.cursor(10, 1); feed('V"ay')
check("Vy honours an explicit register", vim.fn.getreg("a"), WHOLE_FOLD)
reset(); vim.fn.cursor(10, 1); feed("Vx")
check("Vx deletes the whole fold", buf(), ABOVE .. ",line9," .. BELOW)
reset(); vim.fn.cursor(10, 1); feed("VcNEW<Esc>")
check("Vc replaces the whole fold", buf(), ABOVE .. ",line9,NEW," .. BELOW)
reset(); vim.fn.cursor(9, 1); feed("Vjd")
check("Vjd from above covers the fold", buf(), ABOVE .. "," .. BELOW)
reset(); vim.fn.cursor(16, 1); feed("Vkd")
check("Vkd upward covers the fold", buf(), ABOVE .. ",line9,line17,line18,line19,line20")
reset(); vim.fn.cursor(10, 1); feed("V>")
check("V> indents the whole fold", lines(10, 16),
  "  line10,  line11,  line12,  line13,  line14,  line15,line16")
check("V> leaves the cursor on a visible line", vim.fn.line("."), 10)
reset(); vim.fn.cursor(10, 1); feed("VgU")
check("VgU uppercases the whole fold", lines(10, 16),
  "LINE10,LINE11,LINE12,LINE13,LINE14,LINE15,line16")
reset(); vim.fn.cursor(10, 1); feed("VgU"); feed("Vgu")
check("Vgu lowercases the whole fold", lines(10, 16),
  "line10,line11,line12,line13,line14,line15,line16")
reset(); vim.bo.textwidth = 200; vim.fn.cursor(10, 1); feed("Vgq")
check("Vgq formats the whole fold", lines(10, 11),
  "line10 line11 line12 line13 line14 line15,line16")
reset({}); vim.fn.cursor(10, 1); feed("Vd")
check("Vd with no folds deletes one line", buf(),
  ABOVE .. ",line9,line11,line12,line13,line14,line15," .. BELOW)

section("normal-mode doubled operators")
reset(); vim.fn.cursor(10, 1); feed("dd")
check("dd deletes the whole fold", buf(), ABOVE .. ",line9," .. BELOW)
reset(); vim.fn.cursor(10, 1); feed("yy")
check("yy yanks the whole fold", vim.fn.getreg('"'), WHOLE_FOLD)
check("yy leaves the cursor on a visible line", vim.fn.line("."), 10)
reset(); vim.fn.cursor(10, 1); feed("ccNEW<Esc>")
check("cc replaces the whole fold", buf(), ABOVE .. ",line9,NEW," .. BELOW)
reset(); vim.fn.cursor(10, 1); feed(">>")
check(">> indents the whole fold", lines(10, 16),
  "  line10,  line11,  line12,  line13,  line14,  line15,line16")
reset(); vim.fn.cursor(10, 1); feed(">>"); feed("<<")
check("<< outdents the whole fold", lines(10, 16),
  "line10,line11,line12,line13,line14,line15,line16")
reset(); vim.fn.cursor(10, 1); feed("gUU")
check("gUU uppercases the whole fold", lines(10, 16),
  "LINE10,LINE11,LINE12,LINE13,LINE14,LINE15,line16")
reset(); vim.fn.cursor(10, 1); feed("gUU"); feed("guu")
check("guu lowercases the whole fold", lines(10, 16),
  "line10,line11,line12,line13,line14,line15,line16")
reset(); vim.bo.textwidth = 200; vim.fn.cursor(10, 1); feed("gqq")
check("gqq formats the whole fold", lines(10, 11),
  "line10 line11 line12 line13 line14 line15,line16")
reset(); vim.fn.cursor(5, 1); feed("dd")
check("dd clear of a fold is untouched", buf(),
  "line1,line2,line3,line4,line6,line7,line8,line9,line10,line11,line12,line13,line14,line15," .. BELOW)
reset(); vim.fn.cursor(2, 1); feed("3dd")
check("3dd count still works", buf(),
  "line1,line5,line6,line7,line8,line9,line10,line11,line12,line13,line14,line15," .. BELOW)
reset({}); vim.fn.cursor(10, 1); feed("gUU")
check("gUU with no folds", lines(10, 11), "LINE10,line11")
reset({}); vim.fn.cursor(10, 1); feed("3>>")
check("3>> count with no folds", lines(10, 13), "  line10,  line11,  line12,line13")

section("operator + motion")
reset(); vim.fn.cursor(9, 1); feed("dj")
check("dj from above swallows the fold", buf(), ABOVE .. "," .. BELOW)
reset(); vim.fn.cursor(10, 1); feed("dj")
check("dj on the header takes fold + next line", buf(),
  ABOVE .. ",line9,line17,line18,line19,line20")
reset(); vim.fn.cursor(16, 1); feed("dk")
check("dk from below swallows the fold", buf(),
  ABOVE .. ",line9,line17,line18,line19,line20")
reset(); vim.fn.cursor(9, 1); feed("yj")
check("yj yanks the line plus the whole fold", vim.fn.getreg('"'), "line9\n" .. WHOLE_FOLD)
reset(); vim.fn.cursor(5, 1); feed("dj")
check("dj clear of folds is untouched", buf(),
  "line1,line2,line3,line4,line7,line8,line9,line10,line11,line12,line13,line14,line15," .. BELOW)

section("deleting a fold must not strand it in VS Code")
reset(); vim.fn.cursor(10, 1); feed("dd")
check("dd expands the region it is about to delete", unfolded(), "9")
check("dd leaves no stale fold", #_G.FOLDS, 0)
check("dd still deletes the right lines", buf(), FOLD_GONE)
reset(); vim.fn.cursor(10, 1); feed("Vd")
check("Vd expands the region", unfolded(), "9")
check("Vd leaves no stale fold", #_G.FOLDS, 0)
reset(); vim.fn.cursor(10, 1); feed("ccNEW<Esc>")
check("cc expands the region", unfolded(), "9")
reset(); vim.fn.cursor(10, 1); feed("Vx")
check("Vx expands the region", unfolded(), "9")

section("operators that keep the line count leave folds alone")
reset(); vim.fn.cursor(10, 1); feed("yy")
check("yy does not expand", unfolded(), "")
check("yy keeps the fold collapsed", #_G.FOLDS, 1)
reset(); vim.fn.cursor(10, 1); feed("Vy")
check("Vy does not expand", unfolded(), "")
reset(); vim.fn.cursor(10, 1); feed("V>")
check("V> does not expand", unfolded(), "")
reset(); vim.fn.cursor(10, 1); feed("gUU")
check("gUU does not expand", unfolded(), "")

section("folds inside a wider range, and counts")
reset({ { 5, 7 }, { 10, 15 } }); vim.fn.cursor(1, 1); feed("V"); vim.fn.cursor(20, 1); feed("d")
check("a selection spanning two folds expands both", unfolded(), "4,9")
check("...leaving none stale", #_G.FOLDS, 0)
reset({ { 5, 7 }, { 10, 15 } }); vim.fn.cursor(5, 1); feed("Vjjd")
check("Vjj across two folds deletes 5..9", buf(),
  "line1,line2,line3,line4,line10,line11,line12,line13,line14,line15," .. BELOW)
reset({ { 3, 6 } }); vim.fn.cursor(2, 1); feed("8dd")
check("a count spanning a fold expands it", unfolded(), "2")
reset({ { 12, 14 } }); vim.fn.cursor(2, 1); feed("3dd")
check("a count clear of a fold leaves it alone", unfolded(), "")
check("...and the fold survives", #_G.FOLDS, 1)
reset({}); vim.fn.cursor(10, 1); feed("dd")
check("dd with no folds issues no unfold", unfolded(), "")

section("miscellaneous")
reset(); vim.fn.cursor(10, 1); feed("Vd"); feed("u")
check("a single undo restores the whole fold", buf(),
  ABOVE .. ",line9,line10,line11,line12,line13,line14,line15," .. BELOW)
reset({ { 5, 7 }, { 10, 15 } }); vim.fn.cursor(5, 1); feed("dd")
check("dd on the first of two folds", buf(),
  "line1,line2,line3,line4,line8,line9,line10,line11,line12,line13,line14,line15," .. BELOW)

section("paste and join")
-- Every expectation here was derived from Vim's OWN folding, not assumed.
-- test/vim_reference.lua re-verifies them against a real closed fold.
local function linewise_reg()
  vim.fn.setreg("a", "PASTED\n", "V")
end
local function charwise_reg()
  vim.fn.setreg("a", "XX", "v")
end

reset(); linewise_reg(); vim.fn.cursor(10, 1); feed('"ap')
check("p pastes a linewise register AFTER the fold", lines(9, 17),
  "line9,line10,line11,line12,line13,line14,line15,PASTED,line16")
check("p does not disturb the fold", unfolded(), "")
reset(); linewise_reg(); vim.fn.cursor(10, 1); feed('3"ap')
check("3p pastes three copies after the fold", lines(15, 19),
  "line15,PASTED,PASTED,PASTED,line16")
reset(); charwise_reg(); vim.fn.cursor(10, 1); feed('"ap')
check("p with a charwise register goes inline", lines(10, 11), "lXXine10,line11")
reset(); linewise_reg(); vim.fn.cursor(10, 1); feed('"aP')
check("P already pastes before the fold", lines(9, 11), "line9,PASTED,line10")

reset(); linewise_reg(); vim.fn.cursor(10, 1); feed('V"ap')
check("Vp replaces the whole fold", buf(), ABOVE .. ",line9,PASTED," .. BELOW)
check("Vp expands the fold first", unfolded(), "9")
reset(); linewise_reg(); vim.fn.cursor(10, 1); feed('V"aP')
check("VP replaces the whole fold", buf(), ABOVE .. ",line9,PASTED," .. BELOW)

reset(); vim.fn.cursor(10, 1); feed("VJ")
check("VJ joins the whole fold", lines(10, 11),
  "line10 line11 line12 line13 line14 line15,line16")
check("VJ expands the fold first", unfolded(), "9")
reset(); vim.fn.cursor(10, 1); feed("VgJ")
check("VgJ joins the whole fold without spaces", lines(10, 11),
  "line10line11line12line13line14line15,line16")
reset(); vim.fn.cursor(9, 1); feed("VJ")
check("VJ on a plain line joins just the next", lines(9, 10), "line9 line10,line11")

reset(); vim.fn.cursor(10, 1); feed("J")
check("normal J joins only the next line, as Vim does", lines(10, 11), "line10 line11,line12")
check("normal J leaves the fold untouched", unfolded(), "")
reset(); vim.fn.cursor(10, 1); feed("gJ")
check("normal gJ joins only the next line", lines(10, 11), "line10line11,line12")

section("known limitations (asserted so a fix is noticed)")
-- A fold running to the end of the buffer has no visible range after it, so the
-- gap is invisible and we fall back to plain Vim. See LIMITATIONS in the source.
reset({ { 18, 20 } }); vim.fn.cursor(18, 1); feed("Vd")
check("fold with no visible line below is not expanded", buf(),
  ABOVE .. ",line9,line10,line11,line12,line13,line14,line15,line16,line17,line19,line20")

print(("\n%d passed, %d failed"):format(pass, fail))
vim.cmd(fail == 0 and "qa!" or "cq!")
