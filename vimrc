" load OS init scripts
if has("win64") || has("win32")
  source $HOME\\vimfiles\\initwin.vim
elseif has("mac")
  source $HOME/.vim/initmac.vim
endif


" load defaults config
if filereadable(expand("$VIMRUNTIME/defaults.vim"))
  source $VIMRUNTIME/defaults.vim
endif


" set line number
" set number

" map space for ctrl-d page down.
nmap <Space> <C-D>

" edit
let mapleader = ","
"nmap <Leader>ew :e %:h<Enter>
nmap <Leader>ew :e %:h
nmap <Leader>ee :e #

" allow swith unsaved file
set hidden

" autocmd VimEnter * redraw!
