Plug 'w0rp/ale'

let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = v:true
let g:ale_sign_error = 'ﮊ'
let g:ale_sign_warning = ''

nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)
