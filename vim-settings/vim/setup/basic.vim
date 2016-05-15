" this is a private vim config file
" add this file to your .vimrc by add command as following
"   source /path/to/this/file

set history=5000
set ruler

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" Use the same symbols as TextMate for tabstops and EOLs
" set listchars=tab:▸\ ,eol:¬
" set listchars=tab:▸\ ,eol:☠
set listchars=tab:▸\ ,trail:♀
set list

" Set modeline
set modeline

if has("autocmd")
    filetype on

    " set tabstop softtabstop shiftwidth expandtab
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css  setlocal ts=2 sts=2 sw=2 expandtab

    " set cindent autoindent
    autocmd FileType c    setlocal cindent autoindent
    autocmd FileType cpp  setlocal cindent autoindent
    autocmd FileType java setlocal cindent autoindent

    " set list chars
    autocmd FileType text setlocal listchars=tab:▸\ ,eol:☠
    autocmd FileType mkd  setlocal listchars=tab:▸\ ,eol:☠
    autocmd FileType vim  setlocal listchars=tab:▸\ ,eol:☠

endif


" need molokai.vim colorscheme
" set t_Co=256

" set if you prefer the scheme to match the original monokai background color
let g:molokai_original=1
let g:rehash256=1
colorscheme molokai

" export TERM=xterm-256color, in your gnome-terminal
" notice that molokai colorscheme need 256 color support


