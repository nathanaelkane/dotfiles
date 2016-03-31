Plug 'brettanomyces/nvim-editcommand'

let g:terminal_scrollback_buffer_size = 10000
let $GIT_EDITOR = 'nvim-client -f'
let $PSQL_EDITOR = 'nvim-client -f'

" <C-\><C-n> is too inconvenient
tnoremap <ESC> <C-\><C-n>

" Window navigation
tnoremap <C-Right> <C-\><C-n><C-w><Right>
tnoremap <C-Left> <C-\><C-n><C-w><Left>
tnoremap <C-Up> <C-\><C-n><C-w><Up>
tnoremap <C-Down> <C-\><C-n><C-w><Down>

" Edit current terminal command
tmap <Leader>e <Plug>EditCommand

" Terminal visor (toggle)
" Uses the same term buffer regardless of tab and window
let s:visor_buffer_number = 0
let s:visor_key_map = '<Leader>v'

function! ToggleTerminalVisor()
  try
    execute 'buffer' . s:visor_buffer_number
    startinsert
  catch
    terminal
    let s:visor_buffer_number = bufnr('%')
    execute 'tnoremap <buffer> ' . s:visor_key_map . ' <C-\><C-n><C-^>'
  endtry
endfunction

command! ToggleTerminalVisor call ToggleTerminalVisor()
execute 'nnoremap ' . s:visor_key_map . ' :ToggleTerminalVisor<CR>'

" Colours for :term (see :help nvim-terminal-emulator-configuration)
"
" Matches the iTerm2's "Light Background" colour presets
"
" NOTE: NeoVim uses bright colours for bold, rather than using iTerm2's text
" rendering setting for bold. I've worked around this by setting the bright
" colours to their related normal colour.

" black: normal + bright
let g:terminal_color_0 = '#000000'
let g:terminal_color_8 = '#000000' " Set to '#686868' once term bold/bright issue is fixed.

" red: normal + bright
let g:terminal_color_1 = '#C91B00'
let g:terminal_color_9 = '#C91B00' " Set to '#FF6E67' once term bold/bright issue is fixed.

" green: normal + bright
let g:terminal_color_2 = '#00C200'
let g:terminal_color_10 = '#00C200' " Set to '#5FFA68' once term bold/bright issue is fixed.

" yellow: normal + bright
let g:terminal_color_3 = '#C7C400'
let g:terminal_color_11 = '#C7C400' " Set to '#FFFC67' once term bold/bright issue is fixed.

" blue: normal + bright
let g:terminal_color_4 = '#0225C7'
let g:terminal_color_12 = '#0225C7' " Set to '#6871FF' once term bold/bright issue is fixed.

" magenta: normal + bright
let g:terminal_color_5 = '#CA30C7'
let g:terminal_color_13 = '#CA30C7' " Set to '#FF77FF' once term bold/bright issue is fixed.

" cyan: normal + bright
let g:terminal_color_6 = '#00C5C7'
let g:terminal_color_14 = '#00C5C7' " Set to '#60FDFF' once term bold/bright issue is fixed.

" white: normal + bright
let g:terminal_color_7 = '#C7C7C7'
let g:terminal_color_15 = '#C7C7C7' " Set to '#FFFFFF' once term bold/bright issue is fixed.
