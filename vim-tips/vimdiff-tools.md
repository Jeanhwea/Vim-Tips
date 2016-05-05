vimdiff工具
==========================
vim有一种特殊的启动方式, 可以显示两个文件的不同之处. 我们来以main.c文件为例, 在其中一行插入几个字符, 在打开'backup'选项的情况下保存文件, 这样名为main.c~的备份文件会保留该文件此前的版本。

```bash
$ vimdiff main.c main.c~
````

vimdiff工具可以和git工具集成使用，具体配置命令如下：
```bash
git config --global diff.tool vimdiff
```

配置完毕以后使用git来diff就可以使用下面的命令：
```bash
git difftool
```

vimdiff工具来解决冲突
========================

* `dp` : 当前窗口中引起不同的内容被放到另一窗口中缺少这段内容的地方去了, diff-put
* `do` : 从另一窗口中的对应位置取来了差异的内容, diff-obtain



