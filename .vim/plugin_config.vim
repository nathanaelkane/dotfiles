" PLUGIN CONFIG

" NERDTree
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeHijackNetrw     = 0
let g:loaded_netrw            = 1 " Disable netrw
let g:loaded_netrwPlugin      = 1 " Disable netrw
let g:NERDTreeIgnore          = ['Icon$']
let g:NERDTreeWinPos          = 'right'
let g:NERDTreeMinimalUI       = 1
let g:NERDTreeDirArrows       = 1

" Rails
let g:rails_menu = 0

" Preview
let g:PreviewBrowsers='firefox,chrome,safari'

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

" Indent Guides
let g:indent_guides_color_change_percent  = 3
let g:indent_guides_enable_on_vim_startup = 1

" NERDCommenter
let g:NERDSpaceDelims = 1

" Open Browser
let g:netrw_nogx = 1 " disable netrw's gx mapping

" Quickfixsigns
let g:quickfixsigns_classes = ['vcsdiff']

" CtrlP
let g:ctrlp_clear_cache_on_exit   = 1
let g:ctrlp_working_path_mode     = 0 " Handle working path manually
let g:ctrlp_dotfiles              = 0 " Ignore all dot/hidden files
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore         = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|backups$\|logs$\|tmp$',
  \ 'file': '',
  \ 'link': '',
  \ }

" Neocomplcache
let g:acp_enableAtStartup = 0                        " Disable AutoComplPop
let g:neocomplcache_enable_at_startup = 1            " Use neocomplcache
let g:neocomplcache_enable_smart_case = 1            " Use smartcase
let g:neocomplcache_enable_camel_case_completion = 1 " Use camel case completion
let g:neocomplcache_enable_underbar_completion = 1   " Use underbar completion
let g:neocomplcache_auto_completion_start_length = 5
