-- Reference suite: what does REAL Vim folding do?
--
--   nvim --headless -u NONE -i NONE -l test/vim_reference.lua
--
-- ../vscode-fold-motions.lua exists to reproduce Vim's fold behaviour in an
-- editor where Neovim cannot see the folds. This file pins down what that
-- behaviour actually IS, using Neovim's own folds (foldmethod=manual,
-- foldenable=true) and loading nothing else -- no stub, no mappings.
--
-- Every expectation in fold_motions_spec.lua should have a counterpart here.
-- If Vim ever changes, this suite fails first and says which assumption broke.

local pass, fail = 0, 0

local function check(name, got, want)
  if got == want then
    pass = pass + 1
    print("  ok   " .. name)
  else
    fail = fail + 1
    print(("  FAIL %s\n         got:  %s\n         want: %s"):format(name, tostring(got), tostring(want)))
  end
end

-- 20 lines, a real closed fold over 10..15, cursor on the header.
-- `regtype` seeds register a: "V" linewise, "v" charwise.
local function fixture(regtype)
  vim.cmd("silent! normal! \28\14")
  local lines = {}
  for i = 1, 20 do
    lines[i] = "line" .. i
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.wo.foldmethod = "manual"
  vim.wo.foldenable = true
  vim.cmd("silent! normal! zE")
  vim.cmd("10,15fold") -- creates the fold AND closes it
  vim.fn.setreg("a", regtype == "v" and "XX" or "PASTED\n", regtype or "V")
  vim.fn.cursor(10, 1)
end

local function feed(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "nx", false)
end

local function lines(first, last)
  return table.concat(vim.api.nvim_buf_get_lines(0, first - 1, last, false), ",")
end

print("\n== the fixture really is a closed fold ==")
fixture()
check("fold starts at line 10", vim.fn.foldclosed(10), 10)
check("fold ends at line 15", vim.fn.foldclosedend(10), 15)
check("line 16 is outside it", vim.fn.foldclosed(16), -1)

print("\n== motions treat a closed fold as one line ==")
fixture(); feed("j")
check("j from the header clears the fold", vim.fn.line("."), 16)
fixture(); vim.fn.cursor(16, 1); feed("k")
check("k lands on the header", vim.fn.line("."), 10)

print("\n== operators swallow a closed fold whole ==")
fixture(); feed("dd")
check("dd deletes the whole fold", lines(9, 10), "line9,line16")
fixture(); feed("yy")
check("yy yanks the whole fold", vim.fn.getreg('"'),
  "line10\nline11\nline12\nline13\nline14\nline15\n")
fixture(); feed("Vd")
check("Vd deletes the whole fold", lines(9, 10), "line9,line16")
fixture(); vim.fn.cursor(9, 1); feed("dj")
check("dj from above swallows the fold", lines(8, 9), "line8,line16")
fixture(); feed(">>")
check(">> indents the whole fold", lines(10, 16),
  "\tline10,\tline11,\tline12,\tline13,\tline14,\tline15,line16")
fixture(); feed("gUU")
check("gUU uppercases the whole fold", lines(10, 16),
  "LINE10,LINE11,LINE12,LINE13,LINE14,LINE15,line16")

print("\n== paste ==")
fixture(); feed('"ap')
check("p with a linewise register lands AFTER the fold", lines(15, 17),
  "line15,PASTED,line16")
fixture(); feed('3"ap')
check("3p pastes three copies after the fold", lines(15, 19),
  "line15,PASTED,PASTED,PASTED,line16")
fixture("v"); feed('"ap')
check("p with a charwise register goes inline into the header", lines(10, 11),
  "lXXine10,line11")
fixture(); feed('"aP')
check("P already pastes before the fold", lines(9, 11), "line9,PASTED,line10")
fixture(); feed('V"ap')
check("Vp replaces the whole fold", lines(9, 11), "line9,PASTED,line16")
fixture(); feed('V"aP')
check("VP replaces the whole fold", lines(9, 11), "line9,PASTED,line16")

print("\n== join: the fold is NOT a unit in normal mode ==")
fixture(); feed("J")
check("J joins only the next line", lines(10, 11), "line10 line11,line12")
fixture(); feed("gJ")
check("gJ joins only the next line", lines(10, 11), "line10line11,line12")
fixture(); vim.fn.cursor(9, 1); feed("J")
check("J above the fold joins only the header", lines(9, 10), "line9 line10,line11")
fixture(); feed("VJ")
check("VJ joins the whole fold", lines(10, 11),
  "line10 line11 line12 line13 line14 line15,line16")
fixture(); feed("VgJ")
check("VgJ joins the whole fold without spaces", lines(10, 11),
  "line10line11line12line13line14line15,line16")
fixture(); vim.fn.cursor(9, 1); feed("VJ")
check("VJ on a plain line joins just the next", lines(9, 10), "line9 line10,line11")

print(("\n%d passed, %d failed"):format(pass, fail))
vim.cmd(fail == 0 and "qa!" or "cq!")
