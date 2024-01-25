if exists("g:loaded_unix")
  finish
endif
let g:loaded_unix=1

" Detect and Source pathogen.vim
if filereadable(expand("$HOME/.vim/pack/bundle/start/pathogen/autoload/pathogen.vim"))
  source $HOME/.vim/pack/bundle/start/pathogen/autoload/pathogen.vim
  execute pathogen#infect("pack/{}/start/{}")
endif

if has('gui_running') 
  colorscheme slate
endif

" vim:set et sw=2 foldmethod=expr
