tablib
======

`doc <http://docs.python-tablib.org/en/latest/>`__

`GitHub tablib <https://github.com/kennethreitz/tablib>`__

示例
----

生成单张工作簿, headers 为表头, title 为工作簿名
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

data为数据列表,里面是一行行内容

::

    tablib.Dataset(*data, headers=headers, title=sheet_name)

写 xlsx
~~~~~~~

.. code:: python

    # tmp_data 为一个字典, 字典的 value 是dataset
    book = tablib.Databook(tuple(tmp_data.values()))
        with open(filename, 'wb') as f:
            f.write(book.xlsx)

    # 添加排序
    book = tablib.Databook(tuple(tmp_data[key] for key in sorted(tmp_data.keys())))
        with open(filename, 'wb') as f:
            f.write(book.xlsx)
