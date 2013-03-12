runtime colors/jellybeans.vim

let colors_name = 'jellybeans_nate'

hi Normal guibg=#000000 ctermbg=0
hi NonText guibg=#000000 ctermbg=0
hi CursorLine ctermbg=NONE
hi VertSplit ctermbg=235

hi Cursor  guibg=#afd700 guifg=black
hi iCursor guibg=#0087af
hi cCursor guibg=white

hi IndentGuidesOdd ctermbg=NONE
hi IndentGuidesEven ctermbg=233

function! s:GitGutterColors()
  hi lineAdded ctermbg=NONE
  hi lineModified ctermbg=NONE
  hi lineRemoved ctermbg=NONE
endfunction

hi SignColumn ctermbg=0
autocmd BufEnter,WinEnter,ColorScheme * call s:GitGutterColors()
