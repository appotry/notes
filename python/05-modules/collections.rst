collections
===========

collections是python內建的一个集合模块,提供了许多有用的集合类

namedtuple
----------

`详细参考 <https://docs.python.org/3/library/collections.html#collections.namedtuple>`__

``namedtuple``\ 是一个函数,它用来创建一个自定义的\ ``tuple``\ 对象,并且规定了\ ``tuple``\ 元素的个数,并可以用属性而不是索引来引用\ ``tuple``\ 的某个元素.

这样,我们用\ ``namedtuple``\ 可以很方便地定义一种数据类型,它具备tuple的不变形,又可以根据属性来引用.

二维坐标

.. code:: python

    >>> from collections import namedtuple
    >>> Point = namedtuple('Point',['x','y'])
    >>> p = Point(1,2)
    >>> p.x
    1
    >>> p.y
    2

    >>> isinstance(p,Point)
    True
    >>> isinstance(p,tuple)
    True

类似的,可以用坐标和半径表示一个源,也可以用\ ``namedtuple``\ 定义

::

    Circle = namedtuple('Circle',['x','y','r'])

deque
-----

用\ ``list``\ 存储数据时,按索引访问元素很快,但是插入和删除元素就很慢了,因为\ ``list``\ 是线性存储,数据量大的时候,插入和删除效率很低

deque是为了高效实现插入和删除操作的双向列表,适合用于队列和栈

.. code:: python

    >>> from collections import deque
    >>> q = deque(['a','b','c'])
    >>> q.append('x')
    >>> q
    deque(['a', 'b', 'c', 'x'])
    >>> q.appendleft('what')
    >>> q
    deque(['what', 'a', 'b', 'c', 'x'])
    >>> q.pop()
    'x'
    >>> q.popleft()
    'what'
    >>> q
    deque(['a', 'b', 'c'])

deque除了实现\ ``list``\ 的\ ``append()``\ 和\ ``pop()``\ 外，还支持\ ``appendleft()``\ 和\ ``popleft()``\ ，这样就可以非常高效地往头部添加或删除元素。

defaultdict
-----------

使用\ ``dict``\ 时,如果引用的key不存在,就会抛出KeyError,如果希望key不存在时,返回一个默认值,就可以用\ ``defaultdict``

.. code:: python

    >>> from collections import defaultdict
    >>> d = defaultdict(lambda : 'N/A')
    >>> d['key1'] = 'abc'
    >>> d['key1']
    'abc'
    >>> d['key2']
    'N/A'

**默认值是调用函数返回的,而函数在创建\ ``defaultdict``\ 对象时传入**

除了key不存在时返回默认值,其他的与dict一致

OrderedDict
-----------

使用\ ``dict``,key是无序的,在对\ ``dict``\ 做迭代时,我们无法确定key的顺序

如果要保持key的顺序,可以使用\ ``OrderedDict``

::

    od = OrderedDict([('a', 1), ('b', 2), ('c', 3)])

OrderedDict的Key会按照插入的顺序排列，不是Key本身排序

OrderedDict可以实现一个FIFO（先进先出）的dict，当容量超出限制时，先删除最早添加的Key：

.. code:: python

    from collections import OrderedDict

    class LastUpdatedOrderedDict(OrderedDict):

        def __init__(self, capacity):
            super(LastUpdatedOrderedDict, self).__init__()
            self._capacity = capacity

        def __setitem__(self, key, value):
            containsKey = 1 if key in self else 0
            if len(self) - containsKey >= self._capacity:
                last = self.popitem(last=False)
                print('remove:', last)
            if containsKey:
                del self[key]
                print('set:', (key, value))
            else:
                print('add:', (key, value))
            OrderedDict.__setitem__(self, key, value)

Counter
-------

``Counter``\ 是一个简单的计数器,例如,统计字符出现的个数

.. code:: python

    >>> from collections import Counter
    >>> c = Counter()
    >>> for ch in 'pythoncxxxx':
    ...   c[ch] = c[ch] + 1
    ...
    >>> c
    Counter({'x': 4, 'n': 1, 'p': 1, 'c': 1, 'o': 1, 'y': 1, 't': 1, 'h': 1})

Counter实际上也是dict的一个子类，上面的结果可以看出，字符’x’出现了4次，其他字符各出现了一次。

collections模块提供了一些有用的集合类，可以根据需要选用。
---------------------------------------------------------
