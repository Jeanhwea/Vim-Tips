if exists("g:unix")
  finish
endif
let g:unix=1

if has('gui_running') 
  colorscheme slate
  "set guifont=Menlo:h40
  set guifont=Menlo:h30
endif

" vim:set et sw=2 foldmethod=expr
