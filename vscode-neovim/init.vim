" Remap leader to ',' which is much easier than '\'
let mapleader = ","

" Jump to start and end of line using the home row keys
noremap H ^
noremap L $

" Commenting out code
xmap <Leader>c <Plug>VSCodeCommentary
nmap <Leader>c <Plug>VSCodeCommentary
omap <Leader>c <Plug>VSCodeCommentary
nmap <Leader>cc <Plug>VSCodeCommentaryLine

" Movement & wrapped long lines
nmap j gj
nmap k gk

" Search for word under cursor
nmap <Leader>h *N

" Clear search
nmap <Leader>/ :nohls<CR>

function! s:trimAndSave()
  call VSCodeCall("editor.action.trimTrailingWhitespace")
  call VSCodeNotify("workbench.action.files.save")
endfunction

nmap <Leader>t :<C-u>call VSCodeNotify("workbench.action.quickOpen")<CR>
nmap <Leader>d :<C-u>call VSCodeNotify("quickOpenRelative.quickOpenRelative")<CR>
nmap <Leader>l :<C-u>call VSCodeCall("workbench.action.showAllEditors")<CR>
nmap <Leader>f :<C-u>call VSCodeCall("workbench.view.search")<CR>
nmap <Leader>a :<C-u>call VSCodeCall("editor.action.selectAll")<CR>
nmap <Leader>. :<C-u>call VSCodeCall("revealInExplorer")<CR>
nmap <Leader>cf :<C-u>call VSCodeCall("relative-path-and-line.copyRelativePath")<CR>
nmap <Leader>cl :<C-u>call VSCodeCall("relative-path-and-line.copyRelativePathAndLine")<CR>
nmap <Leader>sw :<C-u>call VSCodeCall("editor.action.trimTrailingWhitespace")<CR>
nmap <Leader>r :call <SID>trimAndSave()<CR>
nmap [d :<C-u>call VSCodeCall("workbench.action.editor.previousChange")<CR>
nmap ]d :<C-u>call VSCodeCall("workbench.action.editor.nextChange")<CR>
nmap <Leader>r :call <SID>trimAndSave()<CR>
nmap <silent> tf :<C-u>call VSCodeCall("extension.runFileSpecs")<CR>
nmap <silent> tn :<C-u>call VSCodeCall("extension.runSpecLine")<CR>
nmap <silent> tl :<C-u>call VSCodeCall("extension.runLastSpec")<CR>
nmap <Space> :<C-u>call VSCodeCall("editor.toggleFold")<CR>
nmap <Leader><Leader> :<C-u>call VSCodeCall("workbench.action.previousEditor")<CR>

command! -bang A call VSCodeCall("extension.railsGoToSpec")<CR>

" Pathogen for plugins
source ~/.config/vscode-neovim/autoload/pathogen.vim
execute pathogen#infect('~/.config/vscode-neovim/bundle/{}')

" EasyMotion
map <Leader>e <Plug>(easymotion-prefix)
