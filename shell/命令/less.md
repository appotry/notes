# less

从文件底部往上看

对于一些很大的log文件，我们用more查看时会很费劲，没有办法直接跳到末尾再向前查看。
我们可以用less来解决，less查看一个文件时，可以使用类似vi的command命令，在command模式下按G跳到文件末尾，再使用f或B来翻页

less filename

:G 跳到底部，就可以用 向上 向下 箭头 或 向滚动鼠标来查看log了

上下翻页

    Ctrl + u/d