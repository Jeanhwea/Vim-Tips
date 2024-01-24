if exists("g:win")
  finish
endif
let g:win=1

if has('gui_running') 
  set langmenu=en
  set guifont=Consolas:h14
  colorscheme blue
endif
