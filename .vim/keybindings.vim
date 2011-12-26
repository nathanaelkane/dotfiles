" KEYBINDINGS

" Remap leader to ',' which is much easier than '\'
let mapleader = ","

" Yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" NERDTree
map <Leader>n :NERDTreeToggle<CR>
map <Leader>N :NERDTreeFind<CR>

" Trim & save
map <Leader>sd :FixWhitespace<CR>:w<CR>

" Buffer navigation
map <Leader>, <C-^>

" Tab navigation
map <C-Tab>   :tabnext<CR>
map <C-S-Tab> :tabprev<CR>

" Quickly open/source .vimrc/.gvimrc
nmap <Leader>vv :e $HOME/.vimrc<CR>
nmap <Leader>gg :e $HOME/.gvimrc<CR>
nmap <Leader>ss :source $HOME/.vimrc<Bar>:source $HOME/.gvimrc<CR>

" Toggle invisibles
noremap <Leader>i :set list!<CR>

" Bookmarking
map <C-Space> :ToggleBookmark<CR>
map <C-Up>    :PreviousBookmark<CR>
map <C-Down>  :NextBookmark<CR>

" Colorscheme scroll
map <C-Left>  :PREVCOLOR<CR>
map <C-Right> :NEXTCOLOR<CR>

" Movement & wrapped long lines
" This solves the problem that pressing down jumps your cursor 'over' the current line to the next line
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Move around in insert mode
inoremap <C-h> <left>
inoremap <C-k> <up>
inoremap <C-j> <down>
inoremap <C-l> <right>

" Remove annoying F1 help
inoremap <F1> <Esc>
nnoremap <F1> <Esc>
vnoremap <F1> <Esc>

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Preview (markdown)
nmap <Leader>mm :Preview<CR>

" Align Maps - align selected Cucumber table with <Bar>
vmap <silent><Bar> :Align <Bar><CR>gv:S/\s\+$//e<CR>gv:S/^\s//e<CR>gv<Esc>

" Rooter (mapping overrides)
map <Leader>ro <Plug>RooterChangeToRootDirectory

" TComment
let g:tcommentMapLeaderOp1 = '<Leader>c'

" Clear search
map <silent><Leader>/ :nohls<CR>

" EasyMotion
let g:EasyMotion_leader_key = '<Leader>e'

" Surround
nmap cs <Plug>Csurround

" Close quickfix window
" Handy for getting rid of Ack results
nmap <silent><Leader>q :cclose<CR>

" Substitute
nnoremap <Leader>sr :%s///g<left><left>

" Open Browser
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" Highlight word at cursor without changing position
nnoremap <Leader>h *<C-O>

" Use `=` to indent the current line
nnoremap = v=

" Replace until end of line with yanked text. Uses blackhole register.
nmap <silent><Leader>p "_DP

" Source a single line of Vimscript
nnoremap <Leader>S ^vg_y:execute @@<CR>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Copy relative path and line number to the system pasteboard
nmap <silent><Leader>cf :let @*=expand('%').':'.line('.')<CR>
