if has('nvim')
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kyazdani42/nvim-tree.lua'

  let g:nvim_tree_side = 'right'
  let g:nvim_tree_hide_dotfiles = 1

  nnoremap <Leader>n :NvimTreeToggle<CR>
  nnoremap <Leader>. :NvimTreeFindFile<CR>
else
  Plug 'scrooloose/nerdtree'

  let g:NERDTreeShowLineNumbers = 0
  let g:NERDTreeHijackNetrw = 0
  let g:loaded_netrw = 1 " Disable netrw
  let g:loaded_netrwPlugin = 1 " Disable netrw
  let g:NERDTreeIgnore = ['Icon$']
  let g:NERDTreeWinPos = 'right'
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeDirArrows = 1

  noremap <Leader>n :NERDTreeToggle<CR>
  noremap <Leader>. :NERDTreeFind<CR>
endif
