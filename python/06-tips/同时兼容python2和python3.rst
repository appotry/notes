同时兼容python2和python3
===========================

放弃2.6之前的Python版本
------------------------------

python 2.6之前的python版本缺少一些新特性

bin/2to3
--------------

.. code-block:: python

    安装python的bin目录下有2to3，可以将python2的代码自动转成python3，可以通过这种方式查看2和3的差异

使用python -3执行python程序
------------------------------

``from __future__ import``
------------------------------

import
------------------------------

.. code-block:: python

    try:
        #python2
        from UserDict import UserDict
        #建议按照python3的名字进行import
        from UserDict import DictMixin as MutableMapping

    except ImportError:
        #python3
        from collections import UserDict
        from collections import MutableMapping

检查当前运行的python版本
-------------------------------

有时候你或许必须为python2和python3写不同的代码，你可以用下面的代码检查当前系统的python版本。

.. code-block:: python

    import sys
    if sys.version > '3':
        PY3 = True
    else:
        PY3 = False

six
-------

不推荐使用six，使用six写出来的代码更像python2
