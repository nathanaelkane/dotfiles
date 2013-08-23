" Yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" Trim & save
noremap <Leader>sd :FixWhitespace<CR>:w<CR>

" Buffer navigation
noremap <Leader><Leader> <C-^>

" Quickly open/source .vimrc/.gvimrc
nnoremap <Leader>vv :e $MYVIMRC<CR>
nnoremap <Leader>gg :e $MYGVIMRC<CR>
nnoremap <Leader>ss :source $MYVIMRC<CR>

" Toggle invisibles
noremap <Leader>i :set list!<CR>

" Toggle wrap
noremap <Leader>w :set wrap!<CR>

" Bookmarking
noremap <C-Space> :ToggleBookmark<CR>
noremap <C-Up>    :PreviousBookmark<CR>
noremap <C-Down>  :NextBookmark<CR>

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
let g:tcommentMapLeaderOp1 = '<Leader>c'

" Surround
let g:surround_no_mappings = 1
nmap cs <Plug>Csurround
xmap S  <Plug>VSurround

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

" Override Vimwiki mappings to avoid conflicts
nmap <silent> <Leader>vw <Plug>VimwikiIndex
nmap <silent> <Leader>Zwt <Plug>VimwikiTabIndex
nmap <silent> <Leader>Zws <Plug>VimwikiUISelect
nmap <silent> <Leader>Zwi <Plug>VimwikiDiaryIndex
nmap <silent> <Leader>Zw<Leader>w <Plug>VimwikiMakeDiaryNote
nmap <silent> <Leader>Zw<Leader>t <Plug>VimwikiTabMakeDiaryNote

" Select all
map <Leader>a ggVG

" Yank and put system pasteboard with <Leader>y/p
noremap  <Leader>y  "*y
nnoremap <Leader>yy "*yy
noremap  <Leader>p  "*p
noremap  <Leader>P  "*P

" vimux
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vs :VimuxInterruptRunner<CR>
map <Leader>vrr :wall<Bar>:call VimuxRunCommand("clear; ber " . bufname("%"))<CR>
map <Leader>vrl :wall<Bar>:call VimuxRunCommand("clear; ber " . bufname("%") . ":" . line("."))<CR>
map <Leader>vcc :wall<Bar>:call VimuxRunCommand("clear; bec " . bufname("%"))<CR>
map <Leader>vcl :wall<Bar>:call VimuxRunCommand("clear; bec " . bufname("%") . ":" . line("."))<CR>
map <Leader>vx :call VimuxRunCommand('exit')<CR>

" Refresh and save all teh things.
map <silent><Leader>r :checktime<CR>:silent! wall<CR>:redraw!<CR>:call QuickfixsignsUpdate()<CR>
