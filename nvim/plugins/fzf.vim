" Add to freshrc:
" fresh jasoncodes/ctrlp-modified.vim lib/branch.sh --bin
" fresh jasoncodes/ctrlp-modified.vim lib/branch_modified.sh --bin
" fresh jasoncodes/ctrlp-modified.vim lib/modified.sh --bin
"
" Examples:
" https://github.com/junegunn/fzf/wiki/Examples-(vim)
"
" TODO:
" - Fix <Leader>d so that it excludes sub-directories and works in project root.
" - Add ivalkeen/vim-ctrlp-tjump equivalent.

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Hide statusline
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = {
  \   'window': 'botright 10split enew',
  \ }

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

map <silent> <leader>t :FzfFiles<CR>
map <silent> <leader>l :FzfBuffers<CR>
map <silent> <leader>m :FzfModified<CR>
map <silent> <leader>M :FzfBranchModified<CR>
map <silent> <leader>d :FzfFiles %:h<CR>
