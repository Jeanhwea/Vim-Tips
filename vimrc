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

" setglobal line number
" setglobal number

" Section: move arround quickly
" map space for ctrl-d page down.
nmap <Space> <C-D>

let mapleader = ","
"nmap <Leader>ew :e %:h<Enter>
nmap <Leader>ew :e <C-r>=expand('%:h')<CR><CR>
nmap <Leader>ee :e <C-r>=expand('#')<CR><CR>
nmap <Leader>ev :vsplit<CR>
nmap <Leader>eh :split<CR>
nmap <Leader>ww <C-W>o

" vim:set et sw=2 foldmethod=expr
