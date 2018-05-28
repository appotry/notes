Sphinx
======

`Docs <http://www.sphinx-doc.org/en/1.4.8/contents.html>`__

安裝
----

.. code:: shell

    pip install Sphinx

支持markdown
-----------------------

http://www.sphinx-doc.org/en/stable/markdown.html

安装 ``recommonmark``

.. code:: shell

    pip install recommonmark

添加 ``Markdown parser`` 到 Sphinx 配置文件变量 ``source_parsers`` 中 :

.. code:: python

    from recommonmark.parser import CommonMarkParser

    source_parsers = {
        '.md': CommonMarkParser,
    }

我们也可设置 ``.md`` 后缀为其他名字.

添加 ``Markdown filename extension`` 到配置文件前缀 ``source_suffix``
配置变量中:

.. code:: python

    source_suffix = ['.rst', '.md']

You can further configure recommonmark to allow custom syntax that
standard CommonMark doesn’t support. Read more in the recommonmark
documentation.

AutoStructify组件
~~~~~~~~~~~~~~~~~~~~~~~~~~

支持markdown转换到rst的高级用法.

- https://github.com/rtfd/recommonmark
- http://recommonmark.readthedocs.io/
- http://recommonmark.readthedocs.org/en/latest/auto_structify.html

首先需要在Sphinx配置文件 ``conf.py`` 中添加配置::

    # At top on conf.py (with other import statements)
    import recommonmark
    from recommonmark.transform import AutoStructify

    # At the bottom of conf.py
    def setup(app):
        app.add_config_value('recommonmark_config', {
                'url_resolver': lambda url: github_doc_root + url,
                'auto_toc_tree_section': 'Contents',
                }, True)
        app.add_transform(AutoStructify)

有如下配置:

* enable_auto_toc_tree: 启用自动标题树特性.
* auto_toc_tree_section: 为 True 时, 自动标题树仅会在标题与章节匹配的时候启用.
* enable_auto_doc_ref: 启用 Auto Doc Ref 特性.
* enable_math: 数学公式特性.
* enable_inline_math: 内联数学特性.
* enable_eval_rst: 启用嵌入式 reStructuredText 特性.
* url_resolver: 映射文档相对路径到http链接.

详细使用方法参考: http://recommonmark.readthedocs.io/en/latest/auto_structify.html#

sphinx-autobuild
-----------------------

自动生成html, 并启动server

.. code:: shell

    # 安装sphinx-autobuild
    pip install sphinx-autobuild
    # 监听 source 目录, 生成的文件放置于 _build/html
    sphinx-autobuild source _build/html

Server 默认端口 ``8000``, `http://127.0.0.1:8000/ <http://127.0.0.1:8000/>`__

theme
-----------------------

.. code:: shell

    # 安装
    pip install sphinx_rtd_theme

    # 配置
    import sphinx_rtd_theme
    html_theme = 'sphinx_rtd_theme'

`HTML theming
support <http://www.sphinx-doc.org/en/stable/theming.html>`__

-  `sphinx\_rtd\_theme <https://pypi.python.org/pypi/sphinx_rtd_theme>`__

-  `sphinx-bootstrap-theme <https://github.com/ryan-roemer/sphinx-bootstrap-theme>`__

插入图片
---------------------------
.. code-block:: shell

    资源文件放置于 source/_static 目录下, 绝对路径从 /_static 开始, 也可使用相对路径
    .. image:: /_static/5g.jpg

