重复录入
====================
如果按下了`CTRL-A`, 编辑器会插入你上一次在insert模式下录入的内容.


比如，假定你有个文件，开头是这样的:
```
"file.h" ~
/* Main program begins */ ~
```

你在第一行开始处插入 "#include ":
```
#include "file.h" ~
/* Main program begins */ ~
```

你再用命令 "j^" 往下来到下一行的开始处。现在你开始插入一个新的 "#include" 行。所以你键入: 
```viml
i CTRL-A
```

结果就像下面这样:
```
#include "file.h" ~
#include /* Main program begins */ ~
```
"#include " 被插入是因为 CTRL-A 会插入上次插入过的文本。现在你键入 "main.h"
<Enter> 以结束这一行:
```
#include "file.h" ~
#include "main.h" ~
/* Main program begins */ ~
```

`CTRL-@` 命令会完成 `CTRL-A` 的操作后退出插入模式。这是一个快速重复插入一模一样的文本的一个方法。




