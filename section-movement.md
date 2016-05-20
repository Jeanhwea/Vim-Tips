段移动
=====================

如果你未曾用过Vim的段移动命令 (`[[`, `]]`, `[]` 和`][`)，现在花上几秒读读它们的帮助文档。也顺便读读`:help section`。

Vim以`.`和nroff的段头符开始的任何行当做一个段头，即使你编辑的不是nroff文件！ 下面的示例文件以.SH开头的行就是段头。我用`***`把它们标记出来。 四个段移动命令将在段头行之间移动你的光标。
```
.SH NAME                                                     ***
awk \- pattern-directed scanning and processing language
.SH SYNOPSIS                                                 ***
.B awk
[
.BI \-F
.I fs
]
[
.BI \-v
.I var=value
]
[
.I 'prog'
|
.BI \-f
.I progfile
]
[
.I file ...
]
.SH DESCRIPTION                                              ***
.I Awk
scans each input
.I file
for lines that match ...
```

使用花括号来进行段移动
---------------------
段移动命令也查看另一样东西：一个打开或关闭的大括号({或})作为行的第一个字符。 `[[`和`]]`查看开括号，而`[]`和`][`查看闭括号。
这额外的行为使得你可以在C风格语言的段之间轻松移动。 然而，这些规则也依旧没有顾及你正在编辑的文件类型！
例如下面的文件， `[[`和`]]`命令将在标记为A的行之间移动，而`[]`和`][`将在标记为B的行之间移动。
```
Test           A B
Test

.SH Hello      A B

Test

{              A
Test
}                B

Test

.H World       A B

Test
Test           A B
```
