sorted
======

排序算法

.. code:: python

    >>> sorted([36, 5, -12, 9, -21])
    [-21, -12, 5, 9, 36]

此外，sorted()函数也是一个高阶函数，它还可以接收一个key函数来实现自定义的排序，例如按绝对值大小排序：

.. code:: python

    >>> sorted([36, 5, -12, 9, -21], key=abs)
    [5, 9, -12, -21, 36]

key指定的函数将作用于list的每一个元素上，并根据key函数返回的结果进行排序。对比原始的list和经过key=abs处理过的list：

.. code:: python

    list = [36, 5, -12, 9, -21]

    keys = [36, 5,  12, 9,  21]

.. code:: python

    >>> sorted(['bob', 'about', 'Zoo', 'Credit'])
    ['Credit', 'Zoo', 'about', 'bob']

    默认情况下，对字符串排序，是按照ASCII的大小比较的，由于'Z' < 'a'，结果，大写字母Z会排在小写字母a的前面。

    我们给sorted传入key函数，即可实现忽略大小写的排序：

    >>> sorted(['bob', 'about', 'Zoo', 'Credit'], key=str.lower)
    ['about', 'bob', 'Credit', 'Zoo']

.. code:: python

    >>> L = [('Bob', 75), ('Adam', 92), ('Bart', 66), ('Lisa', 88)]


    #按分数排序
    >>> sorted(L,key=lambda x : x[1])
    [('Bart', 66), ('Bob', 75), ('Lisa', 88), ('Adam', 92)]
    >>> sorted(L,key=lambda x : x[1],reverse=True)
    [('Adam', 92), ('Lisa', 88), ('Bob', 75), ('Bart', 66)]

    # 按名字排序
    >>> sorted(L,key=lambda x : x[0])
    [('Adam', 92), ('Bart', 66), ('Bob', 75), ('Lisa', 88)]
    >>> sorted(L)
    [('Adam', 92), ('Bart', 66), ('Bob', 75), ('Lisa', 88)]

sorted()也是一个高阶函数。用sorted()排序的关键在于实现一个映射函数。
