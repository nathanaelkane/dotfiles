" PATHOGEN
"-------------------------------------------------
filetype off                               " Turn filetype detection off because it interferes with pathogen (Debian turns ft on by default)
call pathogen#runtime_append_all_bundles() " Load all plugins in the ~/.vim/bundle directory
"call pathogen#helptags()                  " Generate helptags for everything in 'runtimepath' - no longer needed

" GENERAL PLUGINS
"-------------------------------------------------
" BUNDLE: git://github.com/scrooloose/nerdtree.git
" BUNDLE: git://github.com/vim-scripts/bufexplorer.zip.git
" BUNDLE: git://github.com/bronson/vim-trailing-whitespace.git
" BUNDLE: git://git.wincent.com/command-t.git
" BUNDLE-COMMAND: rvm 1.8.7 && cd ruby/command-t && ruby extconf.rb && make
" BUNDLE: git://github.com/shemerey/vim-peepopen.git
" BUNDLE: git://github.com/vim-scripts/upAndDown.git
" BUNDLE: git://github.com/mileszs/ack.vim.git
" BUNDLE: git://github.com/vim-scripts/vimwiki.git
" BUNDLE: git://github.com/dterei/VimBookmarking.git
" BUNDLE: git://github.com/vim-scripts/bufkill.vim.git
" BUNDLE: git://github.com/greyblake/vim-preview.git
" # BUNDLE: git://github.com/vim-scripts/YankRing.vim.git
" # BUNDLE: git://github.com/vim-scripts/minibufexpl.vim.git
" # BUNDLE: git://github.com/vim-scripts/wokmarks.vim.git
" # BUNDLE: git://github.com/tomtom/tlib_vim.git
" # BUNDLE: git://github.com/tomtom/quickfixsigns_vim.git
" # BUNDLE: git://github.com/bronson/vim-closebuffer.git
" # BUNDLE: git://github.com/bronson/vim-indexedsearch.git
" # BUNDLE: git://github.com/bronson/vim-visual-star-search.git
" # BUNDLE: git://github.com/bronson/vim-toggle-wrap.git
" # BUNDLE: git://github.com/Raimondi/YAIFA.git

" COLORSCHEMES (AND RELATED)
"-------------------------------------------------
" # BUNDLE: git://github.com/bronson/vim-scrollcolors.git
" BUNDLE: git://github.com/skammer/vim-css-color.git
" BUNDLE: git://github.com/vim-scripts/vilight.vim.git
" # BUNDLE: git://github.com/vim-scripts/Zephyr-Color-Scheme.git
" BUNDLE: git://github.com/vim-scripts/Color-Sampler-Pack.git
" # BUNDLE: git://github.com/kossnocorp/up.vim.git
" # BUNDLE: git://github.com/tpope/vim-vividchalk.git

" PROGRAMMING PLUGINS
"-------------------------------------------------
" BUNDLE: git://github.com/scrooloose/nerdcommenter.git
" BUNDLE: git://github.com/msanders/snipmate.vim.git
" BUNDLE-COMMAND: rm -rf snippets/
" BUNDLE: git@github.com:nathanaelkane/snipmate-snippets.git
" BUNDLE-COMMAND: rm -rf snippets && ln -s . snippets
" BUNDLE: git://github.com/tsaleh/vim-align.git
" BUNDLE: git://github.com/tpope/vim-fugitive.git
" BUNDLE: git://github.com/tpope/vim-markdown.git
" BUNDLE: git://github.com/timcharper/textile.vim.git
" # BUNDLE: git://github.com/robgleeson/vim-markdown-preview.git
" # BUNDLE: git://github.com/tpope/vim-surround.git
" # BUNDLE: git://github.com/vim-scripts/taglist.vim
" # BUNDLE: git://github.com/tpope/vim-endwise.git
" # BUNDLE: git://github.com/tpope/vim-repeat.git
" # BUNDLE: git://github.com/tsaleh/vim-supertab.git
" # BUNDLE: git://github.com/bronson/vim-jquery.git
" # BUNDLE: git://github.com/tpope/vim-git.git
" # BUNDLE: git://github.com/kchmck/vim-coffee-script.git

" RUBY ON RAILS PLUGINS
"-------------------------------------------------
" BUNDLE: git://github.com/vim-ruby/vim-ruby.git
" BUNDLE: git://github.com/tpope/vim-rails.git
" BUNDLE: git://github.com/tpope/vim-cucumber.git
" BUNDLE: git://github.com/tpope/vim-haml.git
" # BUNDLE: git://github.com/tpope/vim-rake.git
" # BUNDLE: git://github.com/bronson/vim-ruby-block-conv.git
" # BUNDLE: git://github.com/janx/vim-rubytest.git
" # BUNDLE: git://github.com/tsaleh/vim-shoulda.git
" # BUNDLE: git://github.com/astashov/vim-ruby-debugger.git

" MISC
"-------------------------------------------------
syntax on                                  " Turn on syntax highlighting
let mapleader = ","                        " Remap leader to ',' which is much easier than '\'
filetype plugin indent on                  " Enable automatic filetype detection, filetype-specific plugins/indentation
set nocompatible                           " Don't need to keep compatibility with Vi
set background=dark                        " Make vim use colors that look good on a dark background
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
  "autocmd FileType ruby,rails,haml,eruby,yaml,ru,cucumber set ai sw=2 sts=2 et
augroup END

" CUSTOM STATUS LINE - see: http://vimdoc.sourceforge.net/htmldoc/options.html#'statusline'
"-------------------------------------------------
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ \ \ \ \ \ \ \ \ \ \ \ [POS=%2l,%2v][%p%%]\ \ \ \ \ \ \ \ \ \ \ \ [LEN=%L]
set laststatus=2

" BACKUPS
"-------------------------------------------------
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/backup

" COMMAND-T SETTINGS
"-------------------------------------------------
let g:CommandTMatchWindowAtTop = 0
let g:CommandTMaxHeight = 30

" MAKE TABS WORK LIKE WE'RE USED TO
"-------------------------------------------------
map <C-Tab> :tabnext<CR>
map <C-S-Tab> :tabprev<CR>

" SHOW NERDTREE WITH LINE NUMBERS FOR EASIER NAVIGATION
"-------------------------------------------------
map <leader>n :NERDTreeToggle<CR>
let g:NERDTreeShowLineNumbers=1

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

" TOGGLE SHOW INVISIBLES
"-------------------------------------------------
noremap <leader>i :set list!<CR>

" BOOKMARKING
"-------------------------------------------------
map <C-Space> :ToggleBookmark<CR>
map <C-Up>    :NextBookmark<CR>
map <C-Down>  :PreviousBookmark<CR>

" COLORSCHEME SCROLL
"-------------------------------------------------
map <silent><F3> :NEXTCOLOR<cr>
map <silent><F2> :PREVCOLOR<cr>

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
let g:rails_menu=0

" PREVIEW SETTINGS
"-------------------------------------------------
let g:PreviewBrowsers='chrome,firefox,safari'
nmap <leader>mm :Preview<CR>

