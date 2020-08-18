" Add to freshrc:
" fresh jasoncodes/ctrlp-modified.vim lib/branch.sh --bin
" fresh jasoncodes/ctrlp-modified.vim lib/branch_modified.sh --bin
" fresh jasoncodes/ctrlp-modified.vim lib/modified.sh --bin
"
" Examples:
" https://github.com/junegunn/fzf/wiki/Examples-(vim)

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = {
  \   'window': {'width': 0.9, 'height': 0.6}
  \ }
let g:fzf_preview_window = '' " disable

command! -bang FzfModified
  \ call fzf#run(extend({
  \   'source': 'modified.sh',
  \   'sink': 'e',
  \   'options': '--prompt="Modified> "',
  \ }, g:fzf_layout))

command! -bang FzfBranchModified
  \ call fzf#run(extend({
  \   'source': 'branch_modified.sh',
  \   'sink': 'e',
  \   'options': '--prompt="BranchModified> "',
  \ }, g:fzf_layout))

command! -bang FzfTagJump
  \ call fzf#vim#tags(
  \   expand('<cword>') . '$',
  \   {'options': '--nth=1,2 --delimiter="\t" --select-1 --exit-0 +i'}
  \ )

map <silent> <leader>t :FzfFiles<CR>
map <silent> <leader>l :FzfBuffers<CR>
map <silent> <leader>m :FzfModified<CR>
map <silent> <leader>M :FzfBranchModified<CR>
map <silent> <leader>d :exe 'FzfFiles ' . expand('%:p:h', 1)<CR>
map <silent> <C-]> :FzfTagJump<CR>
