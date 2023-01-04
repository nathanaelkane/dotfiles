local map = require("utils").map

-- goto previous buffer
map("", "<Leader><Leader>", "<C-^>")

-- move by visible line on wrapped lines
-- doesn't affect motions with count, e.g. 5j
map("n", "j", "v:count ? 'j' : 'gj'", {expr = true})
map("n", "k", "v:count ? 'k' : 'gk'", {expr = true})

-- window navigation
map("", "<C-h>", "<C-w>h")
map("", "<C-j>", "<C-w>j")
map("", "<C-k>", "<C-w>k")
map("", "<C-l>", "<C-w>l")

-- remove annoying F1 help
map({"i", "n", "v"}, "<F1>", "<Nop>")

-- reselect visual block after indent or outdent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- indent the current line
map("n", "=", "v=")

-- jump to start/end of line
map("", "H", "^")
map("", "L", "$")

-- copy file path
map("n", "<Leader>cf", ":let @*=expand('%')<CR>", {silent = true})
map("n", "<Leader>cl", ":let @*=expand('%').':'.line('.')<CR>", {silent = true}) -- with line number

-- select all
map("n", "<Leader>a", "ggVG")

-- yank from cursor to end of line
map("", "Y", "y$")

-- yank and put to/from system pasteboard
map("", "<Leader>y", '"*y')
map("n", "<Leader>yy", '"*yy')
map("", "<Leader>p", '"*p')
map("", "<Leader>P", '"*P')

-- clear search
map("", "<Leader>/", ":nohls<CR>", {silent = true})

-- search forward for visually selected text
map("v", "*", [[:call setreg("/", substitute(v:lua.get_selected_text(), '\_s\+', '\\_s\\+', 'g'))<CR>n]], {silent = true})

-- highlight word/selection without changing position
map("n", "<Leader>h", ":let view=winsaveview()<CR>*:call winrestview(view)<CR>", {noremap = false, silent = true})
map("v", "<Leader>h", ":<C-U>let view=winsaveview()<CR>gv*:<C-U>call winrestview(view)<CR>", {noremap = false, silent = true})

vim.cmd [[
  " http://vim.wikia.com/wiki/Execute_commands_without_changing_the_search_register
  " Executes a command (across a given range) and restores the search register when done.
  function! SafeSearchCommand(line1, line2, theCommand)
    let search = @/
    execute a:line1 . "," . a:line2 . a:theCommand
    let @/ = search
  endfunction
  command! -range -nargs=* SafeSubstitute call SafeSearchCommand(<line1>, <line2>, 's' . <q-args>)
]]

-- normalize whitespace
map("n", "<Leader>ss", [[:SafeSubstitute/\(\S\)\s\+/\1 /ge<CR>:SafeSubstitute/\s*$//e<CR>]], {silent = true})
map("v", "<Leader>ss", [[:SafeSubstitute/\(\S\)\s\+/\1 /ge<CR>gv:SafeSubstitute/\s*$//e<CR>]], {silent = true})

-- space to toggle folds
map({"n", "v"}, "<Space>", "za")
