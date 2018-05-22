元组
====

元组(tuple)和列表的唯一区别就是列表可以更改,元组不可以更改,其他功能与列表一样

创建元组的两种方法
------------------

::

    ages = (11,22,33,44,55)
    ages = tuple((11,22,33,44,55))

如果元组内只有一个元素,那么需要加上一个逗号,否则就变成其他类型了

.. code:: python

    >>> t = (1)
    >>> t
    1
    >>> type(t)
    <class 'int'>
    >>>
    >>> t = (1,)
    >>> t
    (1,)
    >>> type(t)
    <class 'tuple'>

元组所具备的方法
----------------

它只有2个方法,一个是count,一个是index

1. ``count(self, value)`` 查看元组中元素出现的次数

.. code:: python

    >>> ages = tuple((11,22,33,44,55))
    >>> ages
    (11, 22, 33, 44, 55)
    >>> ages.count(11)
    1

2. ``index(self, value, start=None, stop=None)`` 查找元素在元组中的位置

.. code:: python

    >>> ages = tuple((11,22,33,44,55))
    >>> ages.index(11)
    0
    >>> ages.index(44)
    3

元组生成器

.. code:: python

    >>> T = (1,2,3,4,5)
    >>> (x * 2 for x in T)
    <generator object <genexpr> at 0x101bd9af0>
    >>> T1 = (x * 2 for x in T)
    >>> T1
    <generator object <genexpr> at 0x101bd9b48>
    >>> for t in T1: print(t)
    ...
    2
    4
    6
    8
    10

元组嵌套修改
------------

元组的元素是不可更改的,但是元组内元素的元素就可能是可以更改的

.. code:: python

    >>> tup=("tup", ["list", {"name": "yang"}])
    >>> tup
    ('tup', ['list', {'name': 'yang'}])
    >>> tup[1]
    ['list', {'name': 'yang'}]
    >>> tup[1].append("list_a")
    >>> tup[1]
    ['list', {'name': 'yang'}, 'list_a']

元组的元素本身是不可修改的,但是如果元组的元素是个列表或者字典那么就可以被修改

切片原地修改不可变类型
----------------------

.. code:: python

    >>> T = (1,2,3)
    >>> T = T[:2] + (4,)
    >>> T
    (1, 2, 4)
