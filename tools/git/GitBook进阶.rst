GitBook 进阶
============

个性化配置
----------

除了修改书籍的主题外，还可以通过配置 book.json 文件来修改 gitbook
在编译书籍时的行为，例如：修改书籍的名称，显示效果等等。

gitbook 在编译书籍的时候会读取书籍源码顶层目录中的 book.js 或者
book.json

`gitbook 文档 <https://github.com/GitbookIO/gitbook>`__

book.json 配置示例
------------------

.. code:: json

    {
        "author": "Yang",
        "description": "notes",
        "extension": null,
        "generator": "site",
        "links": {
            "sharing": {
                "all": null,
                "facebook": null,
                "google": null,
                "twitter": null,
                "weibo": null
            },
            "sidebar": {
                "notes": "https://yangjinjie.github.io"
            }
        },
        "pdf": {
            "fontSize": 18,
            "footerTemplate": null,
            "headerTemplate": null,
            "margin": {
                "bottom": 36,
                "left": 62,
                "right": 62,
                "top": 36
            },
            "pageNumbers": false,
            "paperSize": "a4"
        },
        "plugins": [
            "toggle-chapters",
            "theme-comscore",
            "splitter",
            "-sharing",
            "search"
        ],
        "title": "notes",
        "variables": {}
    }

插件
----

`插件详情
https://toolchain.gitbook.com/plugins/ <https://toolchain.gitbook.com/plugins/>`__

gitbook 支持许多插件，用户可以从 `NPM <https://www.npmjs.com/>`__ 上搜索
gitbook 的插件，gitbook 文档 推荐插件的命名方式为：

-  gitbook-plugin-X: 插件
-  gitbook-theme-X: 主题

GitBook默认带有6个插件：

-  font-settings
-  highlight
-  lunr
-  search
-  sharing
-  theme-default

去除自带插件， 可在插件名前加-

::

    "plugins": [
        "-search"
    ]

插件安装方法
~~~~~~~~~~~~

方法一:

1. 配置book.json 下的 plugins
2. 然后执行命令 gitbook install(自动安装插件)

.. code:: json

        "plugins": [
            "toggle-chapters",
            "theme-comscore",
            "splitter",
            "-sharing",
            "search"
        ],

完整配置请查看

`book.json 配置示例 <#22-bookjson-配置示例>`__

方法二:

::

    npm install gitbook-plugin-multipart -g
    然后编辑 book.json 添加 multipart 到 plugins 中：

    ```json
        "plugins": [
            "multipart"
        ],
    ```

指定插件版本
~~~~~~~~~~~~

``"myPlugin@0.3.1"``

主题插件
~~~~~~~~

ComScore
^^^^^^^^

ComScore 是一个彩色主题，默认的 gitbook
主题是黑白的，也就是标题和正文都是黑色的，而 ComScore
可以为各级标题添加不同的颜色，更容易区分各级标题

anchor-navigation-ex
~~~~~~~~~~~~~~~~~~~~

-  `anchor-navigation-ex <https://www.npmjs.com/package/gitbook-plugin-anchor-navigation-ex>`__
-  `github地址 <https://github.com/zq99299/gitbook-plugin-anchor-navigation-ex>`__

实用插件
~~~~~~~~

-  disqus, 集成用户评论系统
-  multipart 插件可以将书籍分成几个部分，例如：

   -  GitBook Basic
   -  GitBook Advanced
   -  对有非常多章节的书籍非常有用，分成两部分后，各个部分的章节都从 1
      开始编号。

-  toggle-chapters 使左侧的章节目录可以折叠
-  Splitter 使侧边栏的宽度可以自由调节

发布
~~~~

GitBook发布
^^^^^^^^^^^

GitHub托管,集成
^^^^^^^^^^^^^^^

md托管到GitHub

GitHub Pages
^^^^^^^^^^^^

直接手动将生成的_book推送到GitHub仓库即可

或者使用Grunt发布

grunt-gh-pages插件

模板
----

https://toolchain.gitbook.com/templating/

忽略特殊的模板标签, 输出为纯文本。

.. code:: html

    {% raw %}
      this will {{ not be processed }}
    {% endraw %}

参考链接
--------

https://zhilidali.github.io/gitbook/
