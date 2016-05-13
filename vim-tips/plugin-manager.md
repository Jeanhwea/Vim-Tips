插件管理器
====================

很久之前，vim的一大缺点是缺少插件管理器。如果我们将所有的插件都放到`.vim/*`的相关文件夹下面，当插件多了的话，我们想要删除一个我们不想要的插件就比较麻烦。所有慢慢就有大神写出来一些插件管理器。

目前常用的插件管理器有下面两种
* [pathogen] (https://github.com/tpope/vim-pathogen)
* [vundle] (https://github.com/gmarik/vundle)

pathogen
----------------
安装pathogen有简单的两个步骤：
1. 将 pathogen 的安装是将文件 pathogen.vim 直接放到目录 `~/.vim/autoload`下。
2. 在`.vimrc`文件中添加一句 `execute pathogen#infect()`,用于执行插件包的初始化。

如果有想安装的插件，只需要将插件的文件夹复制到`~/.vim/bundle`下面即可。
pathogen是通过vim的变量`runtimepath`来动态控制插件的加载，一旦pathogen检测的`~/.vim/bundle`下面有新的目录，pathogen就会将插件目录添加的`runtimepath`变量上。


Vundle
-----------------
安装Vundle有下面步骤：
1. 将文件`Vundle.vim`放到`~/.vim/bundle`目录下面
2. 配置你所要安装的包，例如官网上给出下面的配置文档`.vimrc`

```viml
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
```
显然pathogen的安装比较简单，使用只需要将插件文件夹直接放到指定目录就行，但是Vundle添加一个新的插件还要重新写配置文档，我个人觉得这样比较麻烦，所以我比较倾向使用pathogen。



