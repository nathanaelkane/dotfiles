" KEYBINDINGS

" Remap leader to ',' which is much easier than '\'
let mapleader = ","

" Yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" NERDTree
noremap <Leader>n :NERDTreeToggle<CR>
noremap <Leader>N :NERDTreeFind<CR>

" Trim & save
noremap <Leader>sd :FixWhitespace<CR>:w<CR>

" Buffer navigation
noremap <Leader><Leader> <C-^>

" Quickly open/source .vimrc/.gvimrc
nnoremap <Leader>vv :e $MYVIMRC<CR>
nnoremap <Leader>gg :e $MYGVIMRC<CR>
nnoremap <Leader>ss :source $MYVIMRC<Bar>:source $MYGVIMRC<CR>

" Toggle invisibles
noremap <Leader>i :set list!<CR>

" Bookmarking
noremap <C-Space> :ToggleBookmark<CR>
noremap <C-Up>    :PreviousBookmark<CR>
noremap <C-Down>  :NextBookmark<CR>

" Colorscheme scroll
noremap <C-Left>  :PREVCOLOR<CR>
noremap <C-Right> :NEXTCOLOR<CR>

" Movement & wrapped long lines
" This solves the problem that pressing down jumps your cursor 'over' the current line to the next line
nnoremap j gj
nnoremap k gk

" Easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Move around in insert mode
inoremap <C-h> <left>
inoremap <C-k> <up>
inoremap <C-j> <down>
inoremap <C-l> <right>

" Remove annoying F1 help
inoremap <F1> <nop>
nnoremap <F1> <nop>
vnoremap <F1> <nop>

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Align Maps - align selected Cucumber table with <Bar>
vnoremap <silent><Bar> :Align <Bar><CR>gv:S/\s\+$//e<CR>gv:S/^\s//e<CR>gv<Esc>

" Align Maps (mapping overrides)
map <Leader>At| <Plug>AM_t|
map <Leader>At#   <Plug>AM_t#
map <Leader>At,   <Plug>AM_t,
map <Leader>At:   <Plug>AM_t:
map <Leader>At;   <Plug>AM_t;
map <Leader>At<   <Plug>AM_t<
map <Leader>At=   <Plug>AM_t=
map <Leader>Ats,  <Plug>AM_ts,
map <Leader>Ats:  <Plug>AM_ts:
map <Leader>Ats;  <Plug>AM_ts;
map <Leader>Ats<  <Plug>AM_ts<
map <Leader>Ats=  <Plug>AM_ts=
map <Leader>Aw=   <Plug>AM_w=
map <Leader>At?   <Plug>AM_t?
map <Leader>At~   <Plug>AM_t~
map <Leader>At@   <Plug>AM_t@
map <Leader>Am=   <Plug>AM_m=
map <Leader>Atab  <Plug>AM_tab
map <Leader>Atml  <Plug>AM_tml
map <Leader>Atsp  <Plug>AM_tsp
map <Leader>Atsq  <Plug>AM_tsq
map <Leader>Att   <Plug>AM_tt

" TComment
let g:tcommentMapLeaderOp1 = '<Leader>c'

" Clear search
noremap <silent><Leader>/ :nohls<CR>

" EasyMotion
let g:EasyMotion_leader_key = '<Leader>e'

" Surround
let g:surround_no_mappings = 1
nmap cs <Plug>Csurround
xmap S  <Plug>VSurround

" Close quickfix window
" Handy for getting rid of Ack results
nnoremap <silent><Leader>q :cclose<CR>

" Substitute
nnoremap <Leader>sr :%s///g<left><left>

" Open Browser
nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)

" Highlight word at cursor without changing position
nnoremap <Leader>h *<C-O>

" Highlight and ack for word at cursor without changing position
nnoremap <Leader>H *<C-O>:AckFromSearch!<CR>

" Use `=` to indent the current line
nnoremap = v=

" Replace until end of line with yanked text. Uses blackhole register.
nnoremap <silent><Leader>p "_DP

" Source a single line of Vimscript
nnoremap <Leader>S ^vg_y:execute @@<CR>

" Jump to start and end of line using the home row keys
noremap H ^
noremap L $

" Copy relative path to the system pasteboard
nnoremap <silent><Leader>cf :let @*=expand('%')<CR>

" Copy relative path and line number to the system pasteboard
nnoremap <silent><Leader>cF :let @*=expand('%').':'.line('.')<CR>

" Use sane regexes
nnoremap / /\v
vnoremap / /\v

" Use jk as <Esc> alternative
inoremap jk <Esc>

" Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" CtrlP
let g:ctrlp_map = '<Leader>t'
map <Leader>l :CtrlPBuffer<CR>
map <Leader>m :CtrlPMRUFiles<CR>
