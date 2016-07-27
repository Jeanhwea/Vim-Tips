编辑多个文件
==================
有的时候我们同时编辑多个文件，例如下面的bash命令：

```bash
$ vim main.c vector.c path.c
```

在编辑多个文件时，我们可以使用下面的命令来查看编辑的文件列表

```viml
:args
```

查看结果如下：
```
// Copyright 2012 Rui Ueyama. Released under the MIT license.

#include <libgen.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include "8cc.h"

static char *infile;
static char *outfile;
static char *asmfile;
static bool dumpast;
static bool cpponly;
static bool dumpasm;
static bool dontlink;
static Buffer *cppdefs;
static Vector *tmpfiles = &EMPTY_VECTOR;

static void usage(int exitcode) {
    fprintf(exitcode ? stderr : stdout,
            "Usage: 8cc [ -E ][ -a ] [ -h ] <file>\n\n"
[main.c] vector.c path.c                                      1,1           Top

```
其中只有main.c被方括号括起来了，表示这是当前编辑的文件。

在这些文件中来回移动有下面的命令
-------------------
* `:next` : 切换的文件列表中的下一个文件
* `:preious` : 切换的文件列表中的上一个文件，与`:next`相对。
* `:wnext` : 切换的文件列表中的下一个文件，切换前写入文件内容，相当于同时使用了`:write`和`:next`
* `:wprev` : 切换的文件列表中的上一个文件，切换前写入文件内容，相当于同时使用了`:write`和`:prev`




