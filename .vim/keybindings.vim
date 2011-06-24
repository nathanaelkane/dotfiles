" KEYBINDINGS

" Remap leader to ',' which is much easier than '\'
let mapleader = ","

" Yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" NERDTree
map <Leader>n :NERDTreeToggle<CR>
map <Leader>N :NERDTreeFind<CR>

" Trim & save
map <Leader>sd :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<Bar>:w<CR>

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

" Remove annoying F1 help
inoremap <F1> <Esc>
nnoremap <F1> <Esc>
vnoremap <F1> <Esc>

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Preview (markdown)
nmap <Leader>mm :Preview<CR>

" Vimwiki
map <Leader>vw <Plug>VimwikiIndex<CR>

" Vimwiki (mapping overrides)
map <Leader>vw1 <Plug>VimwikiTabIndex<CR>
map <Leader>vs2 <Plug>VimwikiUISelect<CR>
map <Leader>vw<Leader>w <Plug>VimwikiMakeDiaryNote<CR>
map <Leader>vw<Leader>t <Plug>VimwikiTabMakeDiaryNote<CR>

" Align Maps (mapping overrides)
map <Leader>am <Plug>AM_w=

" Rooter (mapping overrides)
map <Leader>ro <Plug>RooterChangeToRootDirectory

" TComment
let g:tcommentMapLeaderOp1 = '<Leader>c'
