Plug 'itchyny/lightline.vim'

set laststatus=2

let g:lightline = {}
let g:lightline.component = {}
let g:lightline.component_visible_condition = {}

Plug 'itchyny/vim-gitbranch'
let g:lightline.component_function = {}
let g:lightline.component_function.gitbranch = 'gitbranch#name'

let g:lightline.active =
  \ {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'gitbranch', 'readonly', 'relativepath', 'modified' ]
  \   ],
  \   'right': [
  \     [ 'lineinfo' ],
  \     [ 'percent' ],
  \     [ 'fileformat', 'fileencoding', 'filetype' ]
  \   ]
  \ }

let g:lightline.inactive =
  \ {
  \   'left': [
  \     [ 'relativepath' ]
  \   ],
  \   'right': [
  \     [ 'lineinfo' ],
  \     [ 'percent' ]
  \   ]
  \ }

function! LightlineModified()
  let map = { 'V': 'n', "\<C-v>": 'n', 's': 'n', 'v': 'n', "\<C-s>": 'n', 'c': 'n', 'R': 'n'}
  let mode = get(map, mode()[0], mode()[0])
  let bgcolor = {'n': [240, '#585858'], 'i': [31, '#0087af']}
  let color = get(bgcolor, mode, bgcolor.n)
  exe printf('hi ModifiedColor ctermfg=196 ctermbg=%d guifg=#ff0000 guibg=%s term=bold cterm=bold',
        \ color[0], color[1])
  return &modified ? '+' : &modifiable ? '' : '-'
endfunction
