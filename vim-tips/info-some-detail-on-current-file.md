查看当前文件的相关信息
======================

有些时候我们需要查看当前光标所在的行，文件名等等信息。但是如果打开单个文件时，这些信息的ruler往往是隐藏的。
```viml
set history=5000
" set number
set ruler
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
" set cindent

" need molokai.vim colorscheme
" set t_co=256
" let g:molokai_original=1
" let g:rehash256=1
" colorscheme molokai

map _u :call ID_search()<Bar>execute "/\\<" . g:word . "\\>"<CR>
map _n :n<Bar>execute "/\\<" . g:word . "\\>"<CR>

function! ID_search()
  let g:word = expand("<cword>")
  let x = system("lid --key=none ". g:word)
  let x = substitute(x, "\n", " ", "g")
                                                              21,1          66%
```
当使`Ctrl-G`按键后，就会显示当前文件的信息，结果如下：

```viml
set history=5000
" set number
set ruler
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
" set cindent

" need molokai.vim colorscheme
" set t_co=256
" let g:molokai_original=1
" let g:rehash256=1
" colorscheme molokai

map _u :call ID_search()<Bar>execute "/\\<" . g:word . "\\>"<CR>
map _n :n<Bar>execute "/\\<" . g:word . "\\>"<CR>

function! ID_search()
  let g:word = expand("<cword>")
  let x = system("lid --key=none ". g:word)
  let x = substitute(x, "\n", " ", "g")
"~/.vim/setup/basic.vim" 29 lines --72%--                     21,1          66%
```
