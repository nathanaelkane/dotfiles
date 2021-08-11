if has('nvim')
  Plug 'lukas-reineke/indent-blankline.nvim'

  let g:indent_blankline_char = '│'
  let g:indent_blankline_show_first_indent_level = v:true
  let g:indent_blankline_show_trailing_blankline_indent = v:false
  let g:indent_blankline_buftype_exclude = ['terminal', 'NvimTree']
else
  Plug 'nathanaelkane/vim-indent-guides'

  let g:indent_guides_color_change_percent = 5
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_exclude_filetypes = ['help', 'diff', 'fzf']
  let g:indent_guides_tab_guides = 0
  let g:indent_guides_soft_pattern = ' '
endif
