Bundle 'tomtom/quickfixsigns_vim'

let g:quickfixsigns_classes = ['vcsdiff']

func! TweakQuickfixsigns()
  sign define QFS_VCS_ADD text=+ texthl=DiffAdd
  sign define QFS_VCS_DEL text=_ texthl=DiffDelete
  sign define QFS_VCS_CHANGE text== texthl=DiffChange
  hi DiffAdd ctermfg=NONE guifg=NONE
  hi DiffDelete ctermfg=NONE guifg=NONE
endfunc
auto VimEnter * call TweakQuickfixsigns()

" Refresh quickfixsigns when buffer reloads
autocmd BufRead * call QuickfixsignsUpdate()

" Jump between git diff hunks (quickfixsigns)
nmap [d :silent call quickfixsigns#MoveSigns(-1, '', 1)<CR>
nmap ]d :silent call quickfixsigns#MoveSigns(1, '', 1)<CR>
