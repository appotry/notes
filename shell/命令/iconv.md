# iconv

## 参数

```shell
-f encoding:   把字符从encoding编码开始转换。
-t encoding:   把字符转换到encoding编码。
-l:            列出已知的编码字符集合
# 不使用 -o 参数, 则会输出到标准输出, 也可以使用重定向写入文件
-o file:       指定输出文件
-c:            忽略输出的非法字符
-s:            禁止警告信息，但不是错误信息
--verbose:     显示进度信息

-f和-t所能指定的合法字符在-l选项的命令里面都列出来了。
```

## 实例

> 批量文件编码转换

```shell
# 创建对应目录, 转码之后的文件放置在对应utf目录下
find . -type d | sed 's#^./##g' |awk 'NR!=1{print "utf/"$0}'|xargs mkdir -p

# 转码, 将所有 txt, 及 java 文件 gbk 编码转成 utf-8
find . -type f -name "*.txt" -o -name "*.java"|sed 's#^./##g'|awk '{print "iconv -f gbk -t utf-8 \""$1"\" > \"utf/"$1"\""}' |bash
```
