vim技巧
=======

vim配置
-------

k-vim

https://github.com/wklken/k-vim

vim 编辑器自动注释,可以参考k-vim中vimrc的配置，示例如下

.. code:: shell

            call append(line("."), "\##############################################")
            call append(line(".")+1, "\# File Name: ".expand("%"))
            call append(line(".")+2, "\# Author: yjj")
            call append(line(".")+3, "\# qq: 493535459")
            call append(line(".")+4, "\# Created Time: ".strftime("%c"))
            call append(line(".")+5, "\###########################################")

vim常用技巧
-----------

.. code:: shell

    :g/^\s*$/d 删除空行

    :set nu     :set nonu
    G   移动到文件的最后一行
    gg  移动到文件的第一行（首行）
    ngg 移动到文件的第n行

    yy  复制当前整行
    p   粘贴
    np  粘贴n次，n次数

    dd  剪切当前一行
    ndd 剪切接下来的多少行，包括 光标所在行
    dG  shanchu 剪切当前行到文件结尾
    D/d$    剪切光标后位置到行尾

    x 删除光标位置字符

    u 撤销上一次操作

    :noh 消除高亮

    ctrl x    减光标所在位置的数字
    ctrl a    加光标所在位置的数字

vim打开文件乱码处理方式
-----------------------

Linux下wget中文编码导致的乱码现象，由于所打开的文件采用的汉字编码方式不同，一般有utf-8
和gb2312两种编码方式

修改系统的配置文件/etc/vimrc即可：

vim /etc/vimrc

.. code:: shell

    #加入下面语句即可：
    set fileencodings=utf-8,gb2312,gbk,gb18030 //支持中文编码
    set termencoding=utf-8
    set fileformats=unix
    set encoding=prc

关闭自动补全
-------------------

.. code:: shell

    解决方法如下：

    :set noautoindent 
    :set nosmartindent

关闭自动注释
-------------------

.. code:: shell

    :set comments=