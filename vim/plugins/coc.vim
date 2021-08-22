if has('nvim')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Snippets
  imap <c-j> <plug>(coc-snippets-expand)
  vmap <c-j> <plug>(coc-snippets-select)
  let g:coc_snippet_next = '<c-j>'
  let g:coc_snippet_prev = '<c-k>'

  " Use tab/shift-tab to:
  " - select next/prev completion item (if popup menu is visible), or
  " - jump to next/prev snippet placeholder (if currently in a snippet), or
  " - else revert to default behaviour
  inoremap <silent><expr> <tab>
    \ pumvisible() ? "\<c-n>" :
    \ coc#jumpable() ? "\<c-r>=coc#rpc#request('snippetNext',[])\<cr>" :
    \ <sid>check_back_space() ? "\<tab>" :
    \ coc#refresh()
  inoremap <silent><expr> <s-tab>
    \ pumvisible() ? "\<c-p>" :
    \ coc#jumpable() ? "\<c-r>=coc#rpc#request('snippetPrev',[])\<cr>" :
    \ "\<c-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Make <cr> expand the currently selected snippet.
  inoremap <silent><expr> <cr> pumvisible() && coc#expandable() ? coc#_select_confirm() : "\<cr>"

  " GoTo code navigation.
  nmap <silent> gd <plug>(coc-definition)
  nmap <silent> gy <plug>(coc-type-definition)
  nmap <silent> gi <plug>(coc-implementation)
  nmap <silent> gr <plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <sid>show_documentation()<cr>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Remap <C-f> and <C-b> for scroll float windows/popups.
  nnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
  nnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
  inoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<right>"
  inoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<left>"
  vnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
  vnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
endif
