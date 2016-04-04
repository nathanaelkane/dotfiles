Plug 'kassio/neoterm'
Plug 'hkupty/nvimux'
Plug 'ToruIwashita/tabmove-assist.vim'

" TODO: Use prefix var for mappings.
" TODO: Reuse the nvimux key mapping function for convenience?
let g:nvimux_prefix = '<C-g>'

if !exists('$TMUX')
  set showtabline=2 " Always show tabline
  autocmd FileType gitcommit set showtabline=1

  " Close tab
  nnoremap <C-g>x :tabclose<CR>
  vnoremap <C-g>x :tabclose<CR>
  inoremap <C-g>x <ESC>:tabclose<CR>
  tnoremap <C-g>x <C-\><C-n>:tabclose<CR>

  " Rename tab
  function! RenameTab()
    let current_tab_name = TabooTabName(tabpagenr())
    let new_tab_name = inputdialog('Enter new name: ', current_tab_name, '__CANCEL__')

    if new_tab_name == ''
      exec ':TabooReset'
    elseif new_tab_name == '__CANCEL__'
      " Do nothing
    else
      exec ':TabooRename ' . new_tab_name
    endif
  endfunction

  nnoremap <C-g>, :call RenameTab()<CR>
  vnoremap <C-g>, :call RenameTab()<CR>
  inoremap <C-g>, <ESC>:call RenameTab()<CR>
  tnoremap <C-g>, <C-\><C-n>:call RenameTab()<CR>

  " Navigate to last active tab
  let g:last_tab = 1
  autocmd TabLeave * let g:last_tab = tabpagenr()

  function! LastActiveTab()
    exec 'tabn ' . g:last_tab
  endfunction

  nnoremap <C-g><C-g> :call LastActiveTab()<CR>
  vnoremap <C-g><C-g> :call LastActiveTab()<CR>
  inoremap <C-g><C-g> <ESC>:call LastActiveTab()<CR>
  tnoremap <C-g><C-g> <C-\><C-n>:call LastActiveTab()<CR>

  " Move tab
  function! MoveTab()
    let current_tab_position = tabpagenr()
    let new_tab_position = inputdialog('Enter new position (current: ' . current_tab_position . '): ', '', '__CANCEL__')

    if new_tab_position == '' || new_tab_position == '__CANCEL__'
      " Do nothing
    else
      exec 'TabMove ' .new_tab_position
    endif
  endfunction

  nnoremap <C-g>m :call MoveTab()<CR>
  vnoremap <C-g>m :call MoveTab()<CR>
  inoremap <C-g>m <ESC>:call MoveTab()<CR>
  tnoremap <C-g>m <C-\><C-n>:call MoveTab()<CR>

  " Horizontal split
  " TODO: Follow into new split and execute :enew.
  nnoremap <C-g>s :sp<CR>
  vnoremap <C-g>s :sp<CR>
  inoremap <C-g>s <ESC>:sp<CR>
  tnoremap <C-g>s <C-\><C-n>:sp<CR>

  " Vertical split
  " TODO: Follow into new split and execute :enew.
  nnoremap <C-g>v :vs<CR>
  vnoremap <C-g>v :vs<CR>
  inoremap <C-g>v <ESC>:vs<CR>
  tnoremap <C-g>v <C-\><C-n>:vs<CR>
endif
