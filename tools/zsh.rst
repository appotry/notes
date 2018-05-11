zsh
===

Mac 升级zsh
-----------

.. code:: shell

    Mac 系统自带了 Zsh, 一般不是最新版，如果需要最新版可通过 Homebrew 来安装

    brew install zsh
        可通过 zsh --version 命令查看 zsh 的版本

    修改默认 Shell
        在 /etc/shells 文件中加入如下一行
        /usr/local/bin/zsh
        然后运行命令
        chsh -s /usr/local/bin/zsh

插件
----

`查看插件 <https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins-Overview>`__

.. code:: shell

    autojump
    git
    colored-man
    colorize
    copydir
    command-not-found
    history
    sublime
    brew

    配置方法：
    ➜  ~ grep "^plugins"  ~/.zshrc
    plugins=(git autojump colored-man colorize copydir history command-not-found)

使用 \*\* 作为下级目录的通配符
------------------------------

.. code:: shell

    ls **/*.pyc
    foo.pyc bar.pyc lib/wibble.pyc
    rm **/*.pyc
    ls **/*.pyc

在文件筛选中使用匹配模式
------------------------

::

    ls *.(py|sh)

在文件筛选中使用修饰符，如：(@) 限制只匹配符号链接：
----------------------------------------------------

::

    ls -l *(@)

使用制表符TAB来自动完成，如man的时候：
--------------------------------------

::

    man zsh[TAB]

也可以用制表符来自动补全命令选项：
----------------------------------

::

    python -[TAB]

或者在kill的时候自动完成：
--------------------------

::

    kill Dock[TAB]

在制表符自动补全时，可以使用光标键（上下左右等）：
--------------------------------------------------

::

    man zsh[TAB][DOWN][RIGHT][LEFT][UP]

自动修改错误的输入：
--------------------

.. code:: shell

    $ pythn -V
    zsh: correct 'pythn' to 'python' [nyae]? y
    Python 2.7.1

使用r来重复上一条命令，可以带替换方式！
---------------------------------------

.. code:: shell

    touch foo.htm bar.htm
    mv foo.htm foo.html
    r foo=bar
    mv bar.htm bar.html

高可定制性的提示符，使用RPROMPT居然可以设置提示符在右边！
---------------------------------------------------------

::

    RPROMPT="%t"
