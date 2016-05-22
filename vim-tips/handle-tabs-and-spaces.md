处理文本中的制表符和空格
=========================

处理文本中的缩进是每个程序员比较在意的事情。有人喜欢使用制表符缩进，有人喜欢使用空格缩进，所以在团队合作过程中往往需要处理文本来得到一个满意的缩进。我个人比较偏向使用全空格缩进风格，下面贴一下我vim中关于缩进的设置：
```viml
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cindent 
```

解释
---------------
这么多选项，各有各的意思。其中`cindent`和`set shiftwidth=4`是关于C语言风格的缩进，详细见[C语言相关缩进风格](Intent-c-style-text.md)。
* `tabstop` : 设置显示tab时需要多少个空白，一般`<Tab>`是8个空白，空格是一个空白。
* `softtabstop` : 设置当你通过键盘触发了一个`<Tab>`健操作时，他会将其转换为多少个宽度的空白。
* `expandtab` :设置展开tab，即在输入`<Tab>`健时，插入相应数量的空格来代替`<Tab>`。
* `autoindent` : 开启自动缩进，也就是在使用`o`新增行时会根据前面的缩进来添加新行的缩进。

仅仅使用空格
----------------
如果开启`expandtab`选项，当输入tab健就会自动被填充成相应数量的空格，那么像Makefile里面有的行必须要以`<Tab>`开头怎么样输入`<Tab>`呢？一种解决方案是先按`Ctrl-V`后再按`<Tab>`。

制表符和空格之间的转化
-------------------------
当你拿到别人的代码是，你无法保证他是按照你的缩进风格写的，这时就需要在制表符和空格之间转化。

### 制表符转空格
因为`expandtab`对文本中已有的tab健不会做转化，所以可以使用下面的命令：
```viml
:set expandtab
:%retab
```
有时需要替换文中所有`<Tab>`，那么可以使用下面的命令
```viml
:%retab!
```

或者可以直接替换文件所有的tab，但是这样替换有风险，**可能会替换的字符串里面<Tab>**，所有可以使用下面的正则表达式查找一下是否含有制表符的字符串。
```viml
/"[^"\t]*\t[^"]*"
```

### 空格转制表符
和上面相反的过程，使用下面的方法即可。

```viml
:set noexpandtab
:%retab!
```

### 处理多余的空格
处理一行结尾的多余的空白符
```viml
:%s/\s\+$//e
```

删除空行
```viml
:g/^$/d
```

### 添加脚本
为了方便空格和<Tab>之间的转化，可以添加下面和帮助函数。
```viml
function! SwapTabAndSpace() " {{{2¬
    if &expandtab∙¬
        set noexpandtab¬
        :%retab!¬
    else¬
        set expandtab¬
        :%retab!¬
    endif¬
endfunction¬
command! -nargs=* SwapTabAndSpace call SwapTabAndSpace()<CR>¬
```

