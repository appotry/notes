max/min 函数的用法
==================

说明
----

.. code:: python

    def max(*args, key=None): # known special case of max
        """
        max(iterable, *[, default=obj, key=func]) -> value
        max(arg1, arg2, *args, *[, key=func]) -> value

        With a single iterable argument, return its biggest item. The
        default keyword-only argument specifies an object to return if
        the provided iterable is empty.
        With two or more arguments, return the largest argument.
        """
        pass

简单用法
--------

.. code:: python

    >>> tmp = max(1,2,4)
    >>> print(tmp)
    4
    >>> a = [1,2,3,4,5,6]
    >>> print(max(a))
    6

中级用法,key属性的使用
----------------------

当key参数不为空时，就以key的函数对象为判断的标准。

如果我们想找出一组数中绝对值最大的数，就可以配合lamda先进行处理，再找出最大值

.. code:: python

    >>> a = [-9,-4,6,1,-3]
    >>> tmp = max(a,key = lambda x : abs(x))
    >>> print(tmp)
    -9

有一组商品,其名称和价格在一个字典中,可以用下面的方法快速找到价格最贵的那组商品
------------------------------------------------------------------------------

.. code:: python

    prices = {
        'A' : 123,
        'B' : 324,
        'C' : 444
    }

    # 在对字典进行数据操作的时候，默认只会处理key，而不是value
    # 先使用zip把字典的keys和values翻转过来，再用max取出值最大的那组数据
    max_prices = max(zip(prices.values(),prices.keys()))
    print(max_prices)

    min_prices = min(zip(prices.values(),prices.keys()))
    print(min_prices)
