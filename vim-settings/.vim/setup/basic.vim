" this is a private vim config file
" add this file to your .vimrc by add command as following
"   source /path/to/this/file

set history=5000
set ruler

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set autoindent

if has("autocmd")
    filetype on

    " set tabstop softtabstop shiftwidth expandtab
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab

    " set cindent
    autocmd FileType c setlocal cindent
    autocmd FileType cpp setlocal cindent

endif
" need molokai.vim colorscheme
" set t_Co=256
" let g:molokai_original=1
" let g:rehash256=1
" export TERM=xterm-256color, in your gnome-terminal
colorscheme molokai

