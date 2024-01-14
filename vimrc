" load defaults config
if filereadable(expand("$VIMRUNTIME/defaults.vim"))
  source $VIMRUNTIME/defaults.vim
endif

" set gui font size
if has('gui_running')
  set guifont=Menlo:h30
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

colorscheme desert
