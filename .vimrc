set rtp+=~/.vim/vundle/
call vundle#rc()

" MISC
"-------------------------------------------------
syntax on                                  " Turn on syntax highlighting
let mapleader = ","                        " Remap leader to ',' which is much easier than '\'
filetype plugin indent on                  " Enable automatic filetype detection, filetype-specific plugins/indentation
set nocompatible                           " Don't need to keep compatibility with Vi
set hidden                                 " Allow hiding buffers with unsaved changes
set listchars=trail:.,tab:>-,eol:$         " Change the invisible characters
set nolist                                 " Hide invisibles by default
set showcmd                                " Show incomplete cmds down the bottom
set showmode                               " Show current mode down the bottom
set cmdheight=2                            " Make the command line a little taller
set ttyfast                                " More smooth screen redrawing
set incsearch                              " Find the next match as we type the search
set hlsearch                               " Highlight searches by default
set ruler                                  " Show ruler
set number                                 " Show line numbers
set vb t_vb=                               " Turn off bell
set mouse=a                                " Enable the mouse
set linespace=3                            " Spacing between lines
set noswapfile                             " Disable creation of *.swp files
set t_Co=256                               " Support for xterm with 256 colors (gets overriden in .gvimrc)

" INDENTATION
"-------------------------------------------------
set shiftwidth=2                           " Number of spaces to use in each autoindent step
set tabstop=2                              " Two tab spaces
set softtabstop=2                          " Number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab                              " Spaces instead of tabs for better cross-editor compatibility
set autoindent                             " Keep the indent when creating a new line
set smarttab                               " Use shiftwidth and softtabstop to insert or delete (on <BS>) blanks
set cindent                                " Recommended seting for automatic C-style indentation
set autoindent                             " Automatic indentation in non-C files

" WRAP
"-------------------------------------------------
set nowrap                                 " Dont wrap lines
set wildmenu                               " Make tab completion act more like bash
set wildmode=list:longest                  " Tab complete to longest common string, like bash
set switchbuf=useopen                      " Don't re-open already opened buffers

" MOVING AROUND / EDITING
"-------------------------------------------------
set nostartofline                          " Avoid moving cursor to BOL when jumping around
set virtualedit=all                        " Let cursor move past the last char
set scrolloff=3                            " Keep 3 context lines above and below the cursor
set backspace=2                            " Allow backspacing over autoindent, EOL, and BOL
set showmatch                              " Briefly jump to a paren once it's balanced
set matchtime=2                            " (for only .2 seconds).

" FILETYPES
"-------------------------------------------------
augroup MyFileTypes
  " Clear old autocmds in group
  autocmd!

  " Autoindent with two spaces, always expand tabs
  autocmd FileType ruby,rails,haml,eruby,yaml,ru,cucumber set ai sw=2 sts=2 et
  if has("gui_running")
    autocmd FileType ruby,rails,haml,eruby,yaml,ru,cucumber :SyntasticEnable
  endif

  " Set Color Column for features
  autocmd BufWinEnter *.feature set cc=11
  autocmd BufWinLeave *.feature set cc=
augroup END

" CUSTOM STATUS LINE - see: http://vimdoc.sourceforge.net/htmldoc/options.html#'statusline'
"-------------------------------------------------
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ \ \ \ \ \ [POS=%2l,%2v][%p%%]\ \ \ \ \ \ [LEN=%L]
if has("gui_running")
  set statusline+=\ \ \ \ \ \ [%{SyntasticStatuslineFlag()}]
endif
set laststatus=2

" BACKUPS
"-------------------------------------------------
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/backup

" MAKE TABS WORK LIKE WE'RE USED TO
"-------------------------------------------------
map <C-Tab> :tabnext<CR>
map <C-S-Tab> :tabprev<CR>

" SHOW NERDTREE WITH LINE NUMBERS FOR EASIER NAVIGATION
"-------------------------------------------------
map <leader>n :NERDTreeToggle<CR>
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeHijackNetrw     = 0
let g:loaded_netrw            = 1 " Disable netrw
let g:loaded_netrwPlugin      = 1 " Disable netrw

" BUFFER NAVIGATION
"-------------------------------------------------
map <leader>, <C-^>
map <leader>] :bnext<CR>
map <leader>[ :bprev<CR>
map <leader>ls :buffers<CR>

" QUICKLY OPEN/SOURCE (.vimrc/.gvimrc)
"-------------------------------------------------
nmap <leader>vv :e $HOME/.vimrc<CR>
nmap <leader>gg :e $HOME/.gvimrc<CR>
nmap <leader>ss :source $HOME/.vimrc<Bar>:source $HOME/.gvimrc<CR>

" QUICKLY OPEN SOME OTHER CRAP
"-------------------------------------------------
nmap <leader>br :e $HOME/.bashrc<CR>
nmap <leader>ba :e $HOME/.bash_aliases<CR>

" TOGGLE SHOW INVISIBLES
"-------------------------------------------------
noremap <leader>i :set list!<CR>

" BOOKMARKING
"-------------------------------------------------
map <C-Space> :ToggleBookmark<CR>
map <C-Up>    :PreviousBookmark<CR>
map <C-Down>  :NextBookmark<CR>

" COLORSCHEME SCROLL
"-------------------------------------------------
map <silent><F2> :PREVCOLOR<CR>
map <silent><F3> :NEXTCOLOR<CR>
map <silent><F5> :NEXTCOLOR<CR><Bar>:IndentGuidesEnable<CR>

" TRIM AND SAVE
"-------------------------------------------------
map <leader>sd :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<Bar>:w<CR>

" MOVEMENT & WRAPPED LONG LINES
" - This solves the problem that pressing down jumps your cursor 'over' the current line to the next line
"-------------------------------------------------
nnoremap j gj
nnoremap k gk

" EASY WINDOW NAVIGATION
"-------------------------------------------------
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" REMOVE ANNOYING F1 HELP
"-------------------------------------------------
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" SAVE ON LOSING FOCUS
"-------------------------------------------------
au FocusLost * :up

" RESELECT VISUAL BLOCK AFTER IN/DEDENT
"-------------------------------------------------
vnoremap < <gv
vnoremap > >gv

" RAILS SETTINGS
"-------------------------------------------------
let g:rails_menu = 0

" PREVIEW SETTINGS
"-------------------------------------------------
let g:PreviewBrowsers='chrome,firefox,safari'
nmap <leader>mm :Preview<CR>

" SYNTASTIC SETTINGS
"-------------------------------------------------
let g:syntastic_enable_signs  = 1
let g:syntastic_auto_loc_list = 0

" COMMAND-T SETTINGS
"-------------------------------------------------
if has("gui_macvim")
  let g:command_t_loaded = 0 " Disable Command-T on MacVim (I use PeepOpen)
endif
let g:CommandTMaxFiles  = 20000
let g:CommandTMaxHeight = 10

" INDENT GUIDES SETTINGS
"-------------------------------------------------
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1

" BUNDLES
"-------------------------------------------------
Bundle 'Indent-Guides'
Bundle 'rails.vim'
Bundle 'ack.vim'
Bundle 'Command-T'
Bundle 'Color-Sampler-Pack'
Bundle 'The-NERD-tree'
Bundle 'The-NERD-Commenter'
Bundle 'snipMate'
Bundle 'cucumber.zip'
Bundle 'bufexplorer.zip'
Bundle 'trailing-whitespace'
Bundle 'upAndDown'
Bundle 'vimwiki'
Bundle 'Syntastic'
Bundle 'Bookmarking'
Bundle 'bufkill.vim'
Bundle 'ScrollColors'
Bundle 'css_color.vim'
Bundle 'Align'
Bundle 'fugitive.vim'
Bundle 'haml.zip'
Bundle 'git://github.com/shemerey/vim-peepopen.git'
Bundle 'git://github.com/robgleeson/vim-markdown-preview.git'
