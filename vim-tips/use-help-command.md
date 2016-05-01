使用help来查找命令
===================
在Vim中查找相关命令可以使用help命令。
```viml
:help
```

1 得到Vim命令的索引
---------------

```viml
:help index
```

得到结果如下：

```
                                                           *index*
This file contains a list of all commands for each mode, with a tag and a
short description.  The lists are sorted on ASCII value.

Tip: When looking for certain functionality, use a search command.  E.g.,
to look for deleting something, use: "/delete".

1. Insert mode                          |insert-index|
2. Normal mode                          |normal-index|
   2.1. Text objects                    |objects|
   2.2. Window commands                 |CTRL-W|
   2.3. Square bracket commands         |[|
   2.4. Commands starting with 'g'      |g|
   2.5. Commands starting with 'z'      |z|
3. Visual mode                          |visual-index|
4. Command-line editing                 |ex-edit-index|
5. EX commands                          |ex-cmd-index|

For an overview of options see help.txt |option-list|.
For an overview of built-in functions see |functions|.
```

2 查找一些选项
-----
例如查找显示行号的选项，可以使用下面命令
```viml
:help 'number'
```

3 查找insert模式下的命令
-----
查找insert模式下的命令，需要以`i_`开头，例如：
```viml
:help i_CTRL-H
```

4 查找Vim的启动选项
-----
Vim的启动选项一般是以`-`开始，例如：
```viml
:help -t
```

