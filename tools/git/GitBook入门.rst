GitBook 入门
============

-  `GitBook帮助中心 <https://help.gitbook.com/>`__
-  `Toolchain <https://toolchain.gitbook.com/>`__

安装
----

安装 Node.js
~~~~~~~~~~~~

`下载地址 <https://nodejs.org/zh-cn/>`__

或者

::

    Mac
    wget https://nodejs.org/dist/v7.8.0/node-v7.8.0.pkg

安装 GitBook
~~~~~~~~~~~~

首先需要安装Node.js,然后使用npm安装gitbook

.. code:: shell

    # 安装
    npm install gitbook-cli -g

    # 检查
    gitbook -V

gitbook help
~~~~~~~~~~~~

.. code:: shell

    # 获取帮助信息
    $ gitbook help

GitBook使用
-----------

Gitbook有几个主要的文件

README.md
~~~~~~~~~

这个文件相当于一本Gitbook的简介，最上层(和 ``SUMMARY.md`` 文件同级)的 ``README.md`` 文件
最终会被用于生成本书的 ``Introduction`` 。

SUMMARY.MD
~~~~~~~~~~

该文件是书的目录结构,使用Markdown语法,这个文件在使用gitbook命令行工具之前要先写好,以便生成书籍目录.

gitbook editor
~~~~~~~~~~~~~~

gitbook editor 实际上就是一个本地应用版的在线编辑器，使用方式和
gitbook在线编辑器类似，而这里的目录及章节是使用编辑器添加生成，同时也会存放到本地之前建立的目录.

导出图书
--------

目前为止，Gitbook支持如下格式输出：

-  静态HTML，可以看作一个静态网站
-  PDF格式
-  eBook格式
-  单个HTML文件
-  JSON格式

输出为HTML
~~~~~~~~~~

.. code:: shell

    ➜  ops-book git:(master) ls
    BOXFISH.md   Docker       README.md    VPN          book.json    nexus.md     内部
    CI           ELK          SUMMARY.md   assets       nexus        node_modules 监控

本地预览(会自动生成)
^^^^^^^^^^^^^^^^^^^^

.. code:: shell

    ➜  ops-book git:(master) gitbook serve .
    Live reload server started on port: 35729
    Press CTRL+C to quit ...

    info: 9 plugins are installed
    info: 8 explicitly listed
    info: loading plugin "toggle-chapters"... OK
    info: loading plugin "splitter"... OK
    info: loading plugin "livereload"... OK
    info: loading plugin "highlight"... OK
    info: loading plugin "search"... OK
    info: loading plugin "lunr"... OK
    info: loading plugin "fontsettings"... OK
    info: loading plugin "theme-default"... OK
    info: found 81 pages
    info: found 47 asset files
    info: >> generation finished with success in 15.4s !

    Starting server ...
    Serving book on http://localhost:4000

可以在浏览器中打开这个网址：\ http://localhost:4000

此时目录下面会多出一个 ``_book``
目录,这个目录就是就是生成的静态网站内容.

使用build参数生成到指定目录
^^^^^^^^^^^^^^^^^^^^^^^^^^^

在图书目录的上层目录使用如下命令生成

.. code:: shell

    ➜  notes gitbook build ops-book out_book # ops-book为项目目录名 静态网页将生成在out_book目录下
    info: 9 plugins are installed
    info: 7 explicitly listed
    info: loading plugin "toggle-chapters"... OK
    info: loading plugin "splitter"... OK
    info: loading plugin "highlight"... OK
    info: loading plugin "search"... OK
    info: loading plugin "lunr"... OK
    info: loading plugin "fontsettings"... OK
    info: loading plugin "theme-default"... OK
    info: found 81 pages
    info: found 47 asset files
    info: >> generation finished with success in 17.7s !

生成 eBooks 和 PDFs
~~~~~~~~~~~~~~~~~~~

.. code:: shell

    $ gitbook pdf ./ ./mybook.pdf

    # Generate an ePub file
    $ gitbook epub ./ ./mybook.epub

    # Generate a Mobi file
    $ gitbook mobi ./ ./mybook.mobi

安装 ebook-convert
^^^^^^^^^^^^^^^^^^

生成 ebooks (epub, mobi, pdf) 依赖 ``ebook-convert``.

    GNU/Linux

安装 ``Calibre``.

::

    sudo aptitude install calibre

在一些 GNU/Linux 发行版 ``node`` 被安装的名字为 ``nodejs``,
手动创建软链接:

::

    sudo ln -s /usr/bin/nodejs /usr/bin/node

..

    OS X

下载 `Calibre application <https://calibre-ebook.com/download>`__.
安装后创建软链接:

::

    sudo ln -s ~/Applications/calibre.app/Contents/MacOS/ebook-convert /usr/bin

``/usr/bin``\ 可以修改为任何在环境变量里面的路径.

Covers
^^^^^^

Covers are used for all the ebook formats. You can either provide one
yourself, or generate one using the `autocover
plugin <https://plugins.gitbook.com/plugin/autocover>`__.

输出PDF
^^^^^^^

由于生成pdf epub mobi等文件依赖于ebook-convert，故首先下载安装 Calibre

`下载链接 <http://calibre-ebook.com/download>`__

这一步有一个关键地方：和windows一样要声明环境变量，否则还是会报ebook-convert……

mac的方式是：

::

    sudo ln -s /Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin

也有另外一种：Mac下该工具已包含在安装包中，用户在使用前请执行

.. code:: shell

    export PATH="$PATH:/Applications/calibre.app/Contents/MacOS/" # 将cli tools路径加入系统路径，或将此句加入.bashrc。

    export PATH=/Applications/calibre.app/Contents/MacOS:$PATH
    ➜ ~ echo $PATH

.. code:: shell

    gitbook pdf gitbook ./gitbook入门教程.pdf

    然后，你会发现你的目录里多了一个名为gitbook入门教程.pdf的文件，就是它了！
