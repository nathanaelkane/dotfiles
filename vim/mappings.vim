noremap <Leader>sd :echoerr "Use <Leader>sw or <Leader>r instead"<CR>

" Buffer navigation
noremap <Leader><Leader> <C-^>

" Toggle invisibles
noremap <Leader>i :set list!<CR>

" Toggle wrap
noremap <Leader>w :set wrap!<CR>

" Movement & wrapped long lines
" This solves the problem that pressing down jumps your cursor 'over' the current line to the next line
nnoremap j gj
nnoremap k gk

" Easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Remove annoying F1 help
inoremap <F1> <nop>
nnoremap <F1> <nop>
vnoremap <F1> <nop>

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" TComment
let g:tcomment_opleader1 = '<Leader>c'

" Substitute
nnoremap <Leader>sr :%s///g<left><left>

" Open Browser
nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)

" Use `=` to indent the current line
nnoremap = v=

" Source a single line of Vimscript
nnoremap <Leader>S ^vg_y:execute @@<CR>

" Jump to start and end of line using the home row keys
noremap H ^
noremap L $

" Copy relative path to the system pasteboard
nnoremap <silent><Leader>cf :let @*=expand('%')<CR>

" Copy relative path and line number to the system pasteboard
nnoremap <silent><Leader>cl :let @*=expand('%').':'.line('.')<CR>

" Use sane regexes
nnoremap / /\v
vnoremap / /\v

" Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" Tabular
nnoremap <Leader>= :Tabularize /\(=>\|=\)<CR>

" Close Vim instance
nmap <Leader>W :qall<CR>

" Select all
map <Leader>a ggVG

" Yank and put system pasteboard with <Leader>y/p
noremap  <Leader>y  "*y
nnoremap <Leader>yy "*yy
noremap  <Leader>p  "*p
noremap  <Leader>P  "*P

" Refresh and save all teh things.
map <silent><Leader>r :checktime<CR>:silent! wall<CR>:redraw!<CR>

" Get the highlight group of the word under the cursor
map <Leader>g :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Remove the escape delay when using capslock as escape/control.
inoremap <C-h> <Esc>
inoremap <C-j> <Esc>
inoremap <C-k> <Esc>
inoremap <C-l> <Esc>
