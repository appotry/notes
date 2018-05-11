Mac OS开启vim语法高亮/着色
==========================

用户家目录编辑.vimrc文件,或者全局修改/usr/share/vim/vimrc文件(区别在于当前用户生效,还是全局生效)

.. code:: shell

    ➜  ~ cat .vimrc
    set ai                  " auto indenting
    set ruler               " show the cursor position
    set hlsearch            " highlight the last searched term
    set history=1000        " keep 1000 lines of history
    syntax on               " syntax highlighting
    filetype plugin on      " use the file type plugins

如果想一直显示行号,可以添加如下语句

.. code:: shell

    set nu
