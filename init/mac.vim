if exists("g:loaded_mac")
  finish
endif
let g:loaded_mac=1

if has('gui_running') 
  colorscheme slate
  "set guifont=Menlo:h40
  set guifont=Menlo:h30
endif

" vim:set et sw=2 foldmethod=expr
