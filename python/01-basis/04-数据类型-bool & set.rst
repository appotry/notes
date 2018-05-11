布尔类型(bool)
==============

布尔类型其实就是数字0和1的变种而来，即 ``真(True/1)`` 或
``假(False/0)``\ ，实际上就是内置的数字类型的子类而已。

集合(set)
=========

集合的元素是不允许重复、不可变且无序的。

主要作用:

-  去重, 把一个列表变成集合,就自动去重了
-  关系测试, 测试两组数据之间的交集, 差集, 并集等关系

创建集合

.. code:: python

    >>> s = set([11,22,33])
    >>> s
    {33, 11, 22}
    >>> type(s)
    <class 'set'>

第二种不常用创建集合的方式

.. code:: python

    >>> s = {11,22,33}
    >>> type(s)
    <class 'set'>
    >>> s
    {33, 11, 22}

把其它可迭代的数据类型转换为set集合

.. code:: python

    >>> li = ["a","b","c"]
    >>> se = set(li)
    >>> se
    {'a', 'b', 'c'}
    >>> type(se)
    <class 'set'>
    >>>

集合同样支持表达式操作符

.. code:: python

    >>> x = set('abcde')
    >>> y = set('bdxyz')
    >>> x
    {'d', 'a', 'b', 'c', 'e'}
    >>> y
    {'z', 'x', 'b', 'd', 'y'}

    使用in进行成员检查
    >>> 'a' in x
    True

    差集, 项在x中,但不在y中
    >>> x - y
    {'a', 'e', 'c'}

    并集
    >>> x | y
    {'y', 'e', 'd', 'c', 'b', 'x', 'a', 'z'}

    交集
    >>> x & y
    {'b', 'd'}

    对称差集,项在x或y中, 但不会同时出现在二者中
    >>> x ^ y
    {'y', 'e', 'c', 'x', 'a', 'z'}

    比较
    >>> x > y
    False
    >>> x < y
    False
    >>> x > y , x < y
    (False, False)

集合解析

.. code:: python

    >>> {x for x in 'abc'}
    {'a', 'b', 'c'}

    >>> {x+'b' for x in 'abc'}
    {'ab', 'bb', 'cb'}

集合所提供的方法
----------------

add
~~~

往集合内添加元素

.. code:: python

    >>> se = {11,22,33}
    >>> se
    {33, 11, 22}
    >>> se.add(44)
    >>> se
    {33, 11, 44, 22}

clear
~~~~~

清除集合内容

.. code:: python

    >>> se = {11,22,33}
    >>>
    >>>
    >>> se
    {33, 11, 22}
    >>> se.clear()
    >>> se
    set()

copy浅拷贝
~~~~~~~~~~

.. code:: python

    var = se.copy()
    # 返回集合的浅copy

difference,差集
~~~~~~~~~~~~~~~

集合\ ``var1``\ 中存在，\ ``var2``\ 中不存在的元素

.. code:: python

    >>> var1 = {11,22,33}
    >>> var2 = {22,55}
    >>> var1.difference(var2)
    {33, 11}
    >>> var2.difference(var1)
    {55}

difference_update
~~~~~~~~~~~~~~~~~

寻找集合var1中存在，var2中不存在的元素，并把查找出来的元素重新赋值给var1

.. code:: python

    >>> var1
    {33, 11, 22}
    >>> var2
    {22, 55}
    >>> var1.difference_update(var2)
    >>> var1
    {33, 11}

discard
~~~~~~~

移除指定元素，不存在不报错

.. code:: python

    >>> var1 = {11,22,33}
    >>> var1.discard(11)
    >>> var1
    {33, 22}
    >>> var1.discard(112111)
    >>> var1
    {33, 22}

remove
~~~~~~

移除指定元素，不存在报错

.. code:: python

    >>> var1 = {11,22,33}
    >>> var1
    {33, 11, 22}
    >>> var1.remove(11)
    >>> var1
    {33, 22}
    >>> var1.remove(asdf)
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    NameError: name 'asdf' is not defined

intersection,交集
~~~~~~~~~~~~~~~~~

交集，查找元素中都存在的值

.. code:: python

    >>> var1 = {11,22,33}
    >>> var2 = {22,55,77}
    >>> var1.intersection(var2)
    {22}

intersection_update
~~~~~~~~~~~~~~~~~~~

取交集并更新到var1中

.. code:: python

    >>> var1 = {11,22,33}
    >>> var2 = {22,55,77}
    >>> var1.intersection_update(var2)
    >>> var1
    {22}

isdisjoint
~~~~~~~~~~

判断有没有交集，如果有返回False，否则返回True

.. code:: python

    >>> var1 = {11,22,33}
    >>> var2 = {22,55,77}
    >>> var1.isdisjoint(var2)
    False
    >>> var2 = {66,44,55}
    >>> var1.isdisjoint(var2)
    True

issubset
~~~~~~~~

是否是子序列，也就是说如果var2的所有元素都被var1所包含，那么var2就是var1的子序列

.. code:: python

    >>> var1 = {11,22,33,44}
    >>> var2 = {11,22}
    >>> var2.issubset(var1)
    True

issuperset
~~~~~~~~~~

是否是父序列

.. code:: python

    >>> var1 = {11,22,33}
    >>> var2 = {22,44,55}
    >>> var1.issuperset(var2)
    False
    >>> var2 = {11,22}
    >>> var1.issuperset(var2)
    True

pop
~~~

移除一个元素，并显示移除的元素，移除时是无序的

.. code:: python

    >>> var1 = {11,22,33,44}
    >>> var1.pop()
    33
    >>> var1
    {11, 44, 22}
    >>> var1.pop()
    11
    >>> var1
    {44, 22}

symmetric_difference
~~~~~~~~~~~~~~~~~~~~

对称交集，把var1存在且var2不存在和var2存在且var1不存在的元素合在一起

.. code:: python

    >>> var1 = {11,22,33,44}
    >>> var2 = {11,55,66,44}

    >>> var1.symmetric_difference(var2)
    {33, 66, 22, 55}

symmetric_difference_update
~~~~~~~~~~~~~~~~~~~~~~~~~~~

对称交集，并更新到var1中

.. code:: python

    >>> var1 = {11,22,33,44}
    >>> var2 = {11,55,66,44}
    >>> var1
    {33, 11, 44, 22}
    >>> var1.symmetric_difference_update(var2)
    >>> var1
    {33, 66, 22, 55}

union,并集
~~~~~~~~~~

并集，把两个集合中的所有元素放在一起，如果有重复的则只存放一个

.. code:: python

    >>> var1 = {11,22,33,44}
    >>> var2 = {11,55,66,44}
    >>> var1.union(var2)
    {33, 66, 11, 44, 22, 55}

update
~~~~~~

更新，把一个集合中的元素更新到另一个集合中

.. code:: python

    >>> var1 = {11,22,33,44}
    >>> var2 = {11,55,66,44}
    >>> var1.update(var2)
    >>> var1
    {33, 66, 11, 44, 22, 55}
