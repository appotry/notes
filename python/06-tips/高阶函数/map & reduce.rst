map/reduce
==========

reduce
------

.. code:: python

    reduce(...)
        reduce(function, sequence[, initial]) -> value

        Apply a function of two arguments cumulatively to the items of a sequence,
        from left to right, so as to reduce the sequence to a single value.
        For example, reduce(lambda x, y: x+y, [1, 2, 3, 4, 5]) calculates
        ((((1+2)+3)+4)+5).  If initial is present, it is placed before the items
        of the sequence in the calculation, and serves as a default when the
        sequence is empty.

将传入的字符编程规范的首字母大写,其他字母小写
---------------------------------------------

.. code:: python

    >>> L1 = ['adam', 'LISA', 'barT']

    >>> list(map(lambda s:s[0].upper()+s[1:].lower() ,L1))
    ['Adam', 'Lisa', 'Bart']

请编写一个prod()函数，可以接受一个list并利用reduce()求积
--------------------------------------------------------

.. code:: python

    >>> from functools import reduce
    >>> reduce(lambda x,y : x * y,[3,5,7,9])
    945

利用map和reduce编写一个str2float函数
------------------------------------

把字符串’123.456’转换成浮点数123.456：

.. code:: python

    >>> def char2num(s):
    ...     return {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9,".":"."}[s]
    ...

    >>> s = "1234.56700"
    reduce(lambda x,y:x*10+y,map(char2num,s.split(".")[0]))+reduce(lambda x,y:x/10 + y,map(char2num,s.split(".")[1][::-1]))/10

.. code:: python

    def str2float(s):
        digit = {'1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9, '0': 0, '.': '.'}
        l = list(map(lambda c: digit[c], s))
        n = l.index('.')
        l.remove('.')
        return reduce(lambda x, y: 10*x+y, l)/(10**(len(l)-n))
