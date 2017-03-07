" To get yamllint working:
" $ pip install yamllint
Plug 'benekastah/neomake'

let g:neomake_warning_sign = {'text': 'W'}
let g:neomake_error_sign = {'text': 'E'}

autocmd! BufWritePost,BufEnter * Neomake
