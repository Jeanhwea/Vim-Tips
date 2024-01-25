if exists("g:loaded_win")
  finish
endif
let g:loaded_win=1

let $LANG='en'
set langmenu=en

" Detect and Source pathogen.vim
if filereadable(expand("$HOME\\vimfiles\\pack\\bundle\\start\\pathogen\\autoload\\pathogen.vim"))
  source $HOME\\vimfiles\\pack\\bundle\\start\\pathogen\\autoload\\pathogen.vim
  execute pathogen#infect("pack/{}/start/{}")
endif

if has('gui_running') 
  set guifont=Consolas:h14
  "colorscheme blue
  colorscheme shine
endif


" vim:set et sw=2 foldmethod=expr
