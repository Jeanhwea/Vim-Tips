" Section: load OS init scripts
if has("win64") || has("win32")
  source $HOME\\vimfiles\\init\\win.vim
elseif has("mac") || has("unix")
  source $HOME/.vim/init/unix.vim
  source $HOME/.vim/init/mac.vim
elseif has("unix")
  source $HOME/.vim/init/unix.vim
endif

" Section: load defaults config
if filereadable(expand("$VIMRUNTIME/defaults.vim"))
  source $VIMRUNTIME/defaults.vim
endif

" Section: GUI setup
autocmd GUIEnter * set guioptions-=r guioptions-=L

" Section: Edit: indent, tab, space
setglobal shiftround
setglobal smarttab
setglobal tabstop=8
setglobal softtabstop=0
setglobal shiftwidth=8
setglobal expandtab
setglobal autoindent
setglobal cindent 
setglobal hidden
" setglobal number

" Section: move arround quickly
" map space for ctrl-d page down.
nmap <Space> <C-D>

let mapleader = ","
"nmap <Leader>ew :e %:h<Enter>
nmap <Leader>ew :e <C-r>=expand('%:h')<CR>
nmap <Leader>ee :e <C-r>=expand('#')<CR>
nmap <Leader>wv :vsplit<CR>
nmap <Leader>wh :split<CR>
nmap <Leader>ww <C-W>o

" vim:set et sw=2 foldmethod=expr
