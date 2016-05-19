插件的目录结构
=====================
通常vim的插件目录都有下面几个文件夹，这些文件夹都有相应的作用。
* `~/.vim/colors/`
* `~/.vim/plugin/`
* `~/.vim/ftdetect/`
* `~/.vim/ftplugin/`
* `~/.vim/indent/`
* `~/.vim/compiler/`
* `~/.vim/after/`
* `~/.vim/autoload/`
* `~/.vim/doc/`

colors
---------------------
Vim将会查找~/.vim/colors/mycolors.vim并执行它。 这个文件应该包括生成你的配色方案所需的一切Vimscript命令。

plugin
---------------------
plugin下的文件将在每次Vim启动的时候执行。 这里的文件包括那些无论何时，在启动Vim之后你就想加载的代码。

ftdetect
---------------------
ftdetect是"filetype detection"的缩写。 这里的文件仅仅负责启动检测和设置文件的filetype类型的自动命令。 这意味着它们一般不会超过一两行。

ftplugin
---------------------
当Vim把一个缓冲区的filetype设置成某个值时， 它会去查找~/.vim/ftplugin/下对应的文件。 比如：如果你执行set filetype=python，Vim将查找~/.vim/ftplugin/python.vim。 一旦文件存在，Vim将执行它。

因为每次在一个缓冲区中执行filetype时都会执行这些文件，**所以它们只能设置buffer-local选项！**如果在它们中设置了全局选项，所有打开的缓冲区的设置都会遭到覆盖！

indent
---------------------
indent下的文件类似于ftplugin下的文件。加载时也是只加载名字对应的文件。 indent文件应该设置跟对应文件类型相关的缩进，而且这些设置应该是buffer-local的。

compiler
---------------------
compiler下的文件非常类似于indent文件。它们应该设置同类型名的当前缓冲区下的编译器相关选项。

after
---------------------
after文件夹有点神奇。这个文件夹下的文件会在每次Vim启动的时候加载， 不过是在plugin下的文件加载了之后。 这**允许你覆盖Vim的默认设置**。实际上你将很少需要这么做，所以不用理它， 除非你有"Vim设置了选项x，但我想要不同的设置"的主意。

autoload
---------------------
autoload是一种延迟插件代码到需要时才加载的方法。

doc
---------------------
doc文件夹提供了一个你可以放置你的插件的文档的地方。 Vim对文档的要求是多多益善(看看我们执行过的所有:help命令就知道)，所以为你的插件写文档是重要的



