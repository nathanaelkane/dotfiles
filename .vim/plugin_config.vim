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
if !has("gui")
  let g:loaded_syntastic_plugin = 0
endif

" Command-T
let g:CommandTMaxFiles         = 20000
let g:CommandTMaxHeight        = 10
let g:CommandTMatchWindowAtTop = 1

" Indent Guides
let g:indent_guides_color_change_percent  = 3
let g:indent_guides_enable_on_vim_startup = 1

" NERDCommenter
let g:NERDSpaceDelims = 1

" Solarized
let g:solarized_bold = 0
let g:solarized_italic = 0

" Surround
let g:surround_no_mappings = 1
