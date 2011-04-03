" Toggle Solarized Background
function! ToggleBackground()
  if (g:solarized_style == 'dark')
    let g:solarized_style = 'light'
    colorscheme solarized
  else
    let g:solarized_style = 'dark'
    colorscheme solarized
  endif
endfunction
