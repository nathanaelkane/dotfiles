" Syntastic
let g:syntastic_enable_signs  = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_mode_map = {
  \ 'mode': 'active',
  \ 'active_filetypes': ['ruby', 'php'],
  \ 'passive_filetypes': []
\ }
if !has("gui")
  let g:loaded_syntastic_plugin = 0
endif

" Quickfixsigns
let g:quickfixsigns_classes = ['vcsdiff']
func! TweakQuickfixsigns()
  sign define QFS_VCS_ADD texthl=DiffAdd
  sign define QFS_VCS_DEL texthl=DiffDelete
  sign define QFS_VCS_CHANGE texthl=DiffChange
  hi DiffAdd ctermfg=NONE guifg=NONE
  hi DiffDelete ctermfg=NONE guifg=NONE
endfunc
auto VimEnter * call TweakQuickfixsigns()

" Neocomplcache
let g:acp_enableAtStartup = 0                        " Disable AutoComplPop
let g:neocomplcache_enable_at_startup = 1            " Use neocomplcache
let g:neocomplcache_enable_smart_case = 1            " Use smartcase
let g:neocomplcache_enable_camel_case_completion = 1 " Use camel case completion
let g:neocomplcache_enable_underbar_completion = 1   " Use underbar completion
let g:neocomplcache_auto_completion_start_length = 5

" Powerline
let g:Powerline_symbols = 'fancy'
