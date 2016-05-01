格式化JSON格式的文件
====================

Bash中可以使用相关命令了格式化JSON类型的文件，例如下面的命令：
```bash
echo '{"a":1, "b":2, "c":3}' | python -mjson.tool  
```
输出结果为：
```
{
    "a": 1,
    "b": 2,
    "c": 3
}
```

我们使用上面的命令在Vim里面格式化JSON文件。使用的Ex命名如下：
```viml
:%!python -mjson.tool
```
