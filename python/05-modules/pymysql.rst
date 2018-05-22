PyMysql
=======

安装
----

::

    pip3 install pymysql

或者下载源码安装

https://pypi.python.org/pypi/PyMySQL#downloads

简单测试
--------

.. code:: python

    import pymysql
    conn = pymysql.connect(host='127.0.0.1',port=3306,user='root',passwd='111111',db='mysql',charset='UTF8')
    cur = conn.cursor()
    cur.execute("select version()")
    for i in cur:
        print(i)
    cur.close()
    conn.close()
