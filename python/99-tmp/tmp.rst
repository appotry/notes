列表 插入 排序
==============

socket编程中问题
----------------

服务端将,内容大小发送给客户端,客户端将此内容转成int的时候,报错

::

    ValueError: invalid literal for int() with base 10:

原因: 粘包

解决: 服务端发送之后,接收一次客户端的确认,再继续发送

1.9. 暂停一秒输出。
-------------------

import time

::

    time.sleep(1)

uuid 模块
---------

.. code:: python

    >>> import uuid
    >>> uuid.uuid4()
    UUID('77d8c6da-4433-4b05-8b8e-a15cb6d01f5e')

    >>> str(uuid.uuid4()).replace('-','')
    'f0a0e57fb81c432d84c283c1d9d82c73'

    >>> str(uuid.uuid4()).replace('-','').upper()
    'D98DEA99788241B087CE3352E3639BBC'

Pillow
------

https://pillow.readthedocs.io/
