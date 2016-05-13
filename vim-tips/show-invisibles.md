显示不可见字符
=================

通常编辑器都有选项来显示不可见字符，例如：<Tab>和回车符。在vim里面也可以实现这样的功能，vim中有一个选项`list`，可以通过下面两个Ex命令来显示与隐藏不可见字符。
```viml
" 显示不可见字符
:set list

" 隐藏不可见字符
:set nolist
```

增加按键绑定
------------------
直接敲命令不是很好记，一般可以考虑将这样的功能增加一个键位绑定，用来帮助快速交换。

```viml
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:☠
```

这样的话，只需要按`\l`就可以切换显示或者隐藏不可见字符。同时<Tab>会被映射成`▸`,换行会被映射成`☠`



