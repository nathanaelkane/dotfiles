Bundle 'moll/vim-bbye'

nnoremap <silent><Leader>q :call CloseWindow()<CR>
nnoremap <Leader>Q :bufdo :Bdelete<CR>

" Closes the quickfix window if it's open, otherwise the focused buffer.
function! CloseWindow()
  for i in range(1, winnr('$'))
    let bnum = winbufnr(i)
    if getbufvar(bnum, '&buftype') == 'quickfix'
      cclose
      return
    endif
  endfor
  Bdelete
endfunction
