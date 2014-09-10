Bundle 'vasconcelloslf/vim-interestingwords'

nnoremap <silent> K :call InterestingWords()<CR>
nnoremap <silent> <leader>k :call UncolorAllWords()<CR>

nnoremap <silent> n :call WordNavigation('forward')<CR>
nnoremap <silent> N :call WordNavigation('backward')<CR>
