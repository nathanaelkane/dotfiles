Plug 'vimwiki/vimwiki'

function! s:open_diary()
  " Diary index

  VimwikiDiaryIndex
  set wrap
  vsplit
  wincmd l

  " Yesterday's entry

  VimwikiMakeYesterdayDiaryNote
  write
  set wrap
  split

  " Today's entry

  VimwikiMakeDiaryNote
  set wrap

  if getline(1,'$') == ['']
    " Create from template
    execute '0r ' . expand('%:p:h') . '/template.wiki'
    execute '%s/<DATE>/' . strftime('%Y-%m-%d')
    execute '%s/<DAY>/' . strftime('%A')
    normal Gdd
  endif

  write
  wincmd h

  " Generate links on diary index

  VimwikiDiaryGenerateLinks
  write
  wincmd l
endfunction

command! Diary call <SID>open_diary()
