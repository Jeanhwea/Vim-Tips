C语言相关缩进风格
=======================

先看看我偏好的缩进风格的.vimrc设置。
```viml
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoinden
set cindent
```

关于C语言缩进风格主要有下面几个要点：
* `cindent` : 开启C语言缩进
* `set shiftwidth=4` : 将C语言缩进设置成4个空白的距离

编辑是自动缩进的命令
---------------------
* `==` : 缩进当前行
* `=a{` : 缩进当前以花括号为分割的代码快
* `gg=G` : 缩进全部的文件
