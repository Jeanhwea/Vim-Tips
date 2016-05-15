如何将vim配置添加到自己的vim上
===================================


本vim的配主要针对`ubuntu 14.04`的用户，需要下面的预装工具

* vim 7
* ctags
* python 2.7 或者 python 3

**配置的时候一定要在相应的操作系统上，否则一切后果概不负责**

安装这个vim配置
--------------
一般我是将这个工程通过git克隆到本地，然后建立相应的符号连接，适宜的命令如下：

```bash
# 克隆这个git仓库
$ git clone https://github.com/Jeanhwea/Vim-Tips.git

# 建立相应的符号连接
$ ln -s /path/to/Vim-Tips/vim-settings/vimrc ~/.vimrc
$ ln -s /path/to/Vim-Tips/vim-settings/vim   ~/.vim
```



