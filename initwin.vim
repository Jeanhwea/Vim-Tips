if exists("g:win")
  finish
endif
let g:win=1

let $LANG='en'
set langmenu=en

if has('gui_running') 
  set guifont=Consolas:h14
  colorscheme blue
endif
