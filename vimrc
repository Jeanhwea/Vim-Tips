" Section: load OS init scripts
if has("win64") || has("win32")
  source $HOME\\vimfiles\\initwin.vim
elseif has("mac")
  source $HOME/.vim/initmac.vim
endif

" Section: load defaults config
if filereadable(expand("$VIMRUNTIME/defaults.vim"))
  source $VIMRUNTIME/defaults.vim
endif

" Section: GUI
autocmd GUIEnter * set guioptions-=r guioptions-=L

" Section: indent, tab, space
setglobal shiftround
setglobal smarttab
setglobal tabstop=8
setglobal softtabstop=4
setglobal shiftwidth=4
setglobal expandtab
setglobal autoindent
setglobal cindent 

" set line number
" set number

" Section: move arround quickly
" map space for ctrl-d page down.
nmap <Space> <C-D>

let mapleader = ","
"nmap <Leader>ew :e %:h<Enter>
nmap <Leader>ew :e %:h
nmap <Leader>ee :e #

" allow swith unsaved file
set hidden

" autocmd VimEnter * redraw!

" vim:set et sw=2 foldmethod=expr
