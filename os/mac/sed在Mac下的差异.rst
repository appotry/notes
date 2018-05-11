sed在Mac下的差异
================

参数 i
------

linux下可选参数 ``-i``\ 在Mac下被强制要求

执行命令

.. code:: shell

    ➜  oam git:(master) ✗ sed -i "s#Updated: 2017-[0-9][0-9]-[0-9][0-9]#Updated: $(date +%F)#g" README.md
    sed: 1: "README.md": invalid command code R

操作失败，linux下是OK的。因为两个系统下对参数“i”的要求不一样。

参数“i”的用途是直接在文件中进行替换。为防止误操作，可提供一个后缀名，使sed在替换前对文件进行备份,mac下是强制要求备份的，但linux下是可选的。

所以如果不需要备份，传入空字符串

.. code:: shell

    ➜  oam git:(master) ✗ sed -i "" "s#Updated: 2017-[0-9][0-9]-[0-9][0-9]#Updated: $(date +%F)#g" README.md 替代linux下用法即可

**或者安装GNU版本的 sed来解决**

编码问题
--------

说到编辑器，就离不开编码问题，sed作为programmer式的编辑工具也是。

工作时碰到报错

.. code:: shell

    sed: RE error: illegal byte sequence
    sed : RE error : illegal byte sequence

这是因为在识别含有多字节编码字符时遇到了解析冲突问题，解决方式是在sed前执行下方命令，或将其加入~/.bash_profile
或 ~/.zshrc

.. code:: shell

    export LC_CTYPE=C
    export LANG=C
    export LC_CTYPE = C

    export LANG = C

改变语言编码环境，使Mac下sed正确处理单字节和多字节字符。再次执行sed命令，OK了。

不过弊端也有，在我们UTF8环境的Mac终端里，这么做会让字符中每个字节都被识别为单独的字符（终端里输入汉字会显示为16进制unicode编码）忽略UTF8的编码规则。
