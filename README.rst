Notes
=====

    由于\ ``GitBook``\ 生成\ ``html``\ 太慢, 放弃使用\ ``GitBook``,
    文档使用\ ``reStructuredText``\ 编写,
    使用\ ``Sphinx``\ 生成静态文件.

-  `GitHub地址 <https://github.com/yangjinjie/notes>`__

在线阅读
------------

`最新文档 <https://notes.yangjinjie.xyz>`__

.. attention::

    原GitHub Pages(使用GitBook生成)可继续访问, 但不再更新, 地址
    https://yangjinjie.github.io 或 https://docs.yangjinjie.xyz

离线阅读
--------

本地使用Sphinx生成静态文档
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: shell

    # 前提, 安装Sphinx
    git clone --depth=1 https://github.com/yangjinjie/notes.git notes_notes
    cd notes_notes
    make html
    # 访问生成的html即可

`GitBook相关教程 <tools/git/GitBook.md>`__

项目简介
--------

可以使用搜索功能, Python相关内容,
需要进入侧边工具栏\ ``Python``\ 下搜索…

所有内容可在\ ``GitHub notes``\ 仓库中搜索

.. code:: shell

    tree
    .
    notes
    ├── bigdata
    ├── ci
    │   ├── TeamCity
    │   └── jenkins
    ├── cloud
    │   ├── ~~~
    ├── db
    │   ├── ~~~
    ├── html,css,JavaScript
    ├── microservice
    ├── network
    ├── os
    │   ├── 各系统相关
    │   └── ...
    ├── python
    ├── ruby
    ├── service
    │   ├── 各类服务
    │   └── ...
    ├── shell
    ├── tips
    ├── tmp
    │   └── 未分类
    └── tools
        ├── 各类工具, 比如vim,git
        └── ...
