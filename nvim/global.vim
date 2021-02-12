syntax on                                  " Turn on syntax highlighting
filetype plugin indent on                  " Enable automatic filetype detection, filetype-specific plugins/indentation
set nocompatible                           " Don't need to keep compatibility with Vi
set hidden                                 " Allow hiding buffers with unsaved changes
set listchars=trail:.,tab:>-,eol:¬         " Change the invisible characters
set nolist                                 " Hide invisibles by default
set showcmd                                " Show incomplete cmds down the bottom
set showmode                               " Show current mode down the bottom
set cmdheight=2                            " Make the command line a little taller
set incsearch                              " Find the next match as we type the search
set ruler                                  " Show ruler
set number                                 " Show line numbers
set vb t_vb=                               " Turn off bell
set linespace=2                            " Spacing between lines
set noswapfile                             " Disable creation of *.swp files
set t_Co=256                               " Support for xterm with 256 colors
set ignorecase                             " Ignore case by default when searching
set smartcase                              " Switch to case sensitive mode if needle contains uppercase characters
set modelines=1
if !has('nvim')
  set noesckeys                            " Remove <Esc> delay in Terminal Vim (also disables arrow keys in insert mode, meh)
endif
set noequalalways                          " Don't make windows the same size after splitting or closing a window

" Indentation
set shiftwidth=2                           " Number of spaces to use in each autoindent step
set tabstop=2                              " Two tab spaces
set softtabstop=2                          " Number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab                              " Spaces instead of tabs for better cross-editor compatibility
set autoindent                             " Keep the indent when creating a new line
set smarttab                               " Use shiftwidth and softtabstop to insert or delete (on <BS>) blanks
set cindent                                " Recommended seting for automatic C-style indentation
set autoindent                             " Automatic indentation in non-C files

" Wrap
set nowrap                                 " I don't always wrap lines...
set linebreak                              " ...but when I do, I wrap whole words
set wildmenu                               " Make tab completion act more like bash
set wildmode=list:longest                  " Tab complete to longest common string, like bash
set switchbuf=useopen                      " Don't re-open already opened buffers

" Moving around / editing
set nostartofline                          " Avoid moving cursor to BOL when jumping around
set scrolloff=3                            " Keep 3 context lines above and below the cursor
set backspace=2                            " Allow backspacing over autoindent, EOL, and BOL
set showmatch                              " Briefly jump to a paren once it's balanced
set matchtime=2                            " (for only .2 seconds).

" Better horizontal scrolling
set sidescroll=5
set listchars+=precedes:<,extends:>

" Speed
if !has('nvim')
  set ttyscroll=3
endif
set ttyfast
set lazyredraw

" Custom status line
if !has('nvim')
  set statusline=%F%m%r%h%w\ [TYPE=%Y]\ \ \ \ \ \ [POS=%2l,%2v][%p%%]\ \ \ \ \ \ [LEN=%L]
  set laststatus=2
end

" Terminal Vim
if !has("gui")
  let loaded_bookmarks = 0
endif

if has('nvim')
  " Hack to get C-h working in NeoVim
  nmap <BS> <C-W>h

  set termguicolors " true color support
  set inccommand=nosplit " show results while typing a :substitute command
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " for colorschemes that still rely on this value
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

set background=dark
colorscheme palenight_nate

" Required for textobjs
runtime macros/matchit.vim
