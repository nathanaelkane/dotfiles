Plug 'airblade/vim-gitgutter'

set signcolumn=yes

let g:gitgutter_map_keys = v:false
let g:gitgutter_realtime = v:false
let g:gitgutter_preview_win_floating = v:true
let g:gitgutter_close_preview_on_escape = v:true

let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▎'
let g:gitgutter_sign_removed_first_line = '▎'
let g:gitgutter_sign_removed_above_and_below = '▎'
let g:gitgutter_sign_modified_removed = '▎'

nmap ]d <Plug>(GitGutterNextHunk)
nmap [d <Plug>(GitGutterPrevHunk)
nmap <leader>gp <Plug>(GitGutterPreviewHunk)

function! ToggleGitGutterMode()
  if g:gitgutter_diff_base == ''
    let g:gitgutter_diff_base='$(git merge-base origin/HEAD HEAD)'
  else
    let g:gitgutter_diff_base=''
  endif

  GitGutterAll
endfunction

nmap <silent> cog :call ToggleGitGutterMode()<CR>

autocmd BufWritePost * GitGutter
