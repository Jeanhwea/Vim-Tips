加速你的Ex模式的命令输入
========================
vim的Ex命令支持命令补全的功能，就像bash一样，当你按下<Tab>键的时候就有相应的命令补全。

例如我想设置当前的colorscheme为solarized，我只要键入`:color`，然后按下<Tab>补全成`:colorscheme`，再键入`so`，然后<Tab>补全为
```viml
:colorscheme solarized
```

要想列出<Tab>补全的所有选项，可以使用`Ctrl-D`，例如下面就是使用了`Ctrl-D`列出了所有可以设置的主题色彩。
```viml
~                                                                               
~                                                                               
~                                                                               
~                                                                               
~                                                                               
~                                                                               
:colorscheme <Ctrl-D>
blue       delek      evening    morning    peachpuff  slate      zellner
darkblue   desert     koehler    murphy     ron        solarized
default    elflord    molokai    pablo      shine      torte
:colorscheme 
```


