" Syntastic
let g:syntastic_enable_signs  = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_mode_map = {
  \ 'mode': 'active',
  \ 'active_filetypes': ['ruby', 'php'],
  \ 'passive_filetypes': []
\ }
if !has("gui")
  let g:loaded_syntastic_plugin = 0
endif

" Powerline
let g:Powerline_symbols = 'fancy'
