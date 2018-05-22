filter
======

python內建的\ ``filter()``\ 用于过滤序列

和\ ``map()``\ 类似,\ ``filter()``\ 也接收一个函数和一个序列.

``filter()``\ 把传入的函数依次作用于每个元素,然后根据返回值是\ ``True``\ 还是\ ``False``\ 决定保留还是丢弃该元素.

例如,在一个list中,删掉偶数,保留奇数

.. code:: python

    >>> L = [1,2,3,4,5,6,7,8,9,10]
    >>> list(filter(lambda x:x % 2 == 1,L))
    [1, 3, 5, 7, 9]

把一个序列中的空字符串删掉

.. code:: python

    >>> list(filter(lambda x:x and x.strip() ,["A"," ","",None,"C",1]))
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
      File "<stdin>", line 1, in <lambda>
    AttributeError: 'int' object has no attribute 'strip'
    >>> list(filter(lambda x:x and x.strip() ,["A"," ","",None,"C","1"]))
    ['A', 'C', '1']
    >>> list(filter(lambda x:x and str(x).strip() ,["A"," ","",None,"C",1]))
    ['A', 'C', 1]

``filter()`` 函数返回的是一个
``Iterator``,也就是一个惰性序列,所以要强迫\ ``filter()``\ 完成计算结果,需要用\ ``list()``\ 函数获取所有结果并返回list

用filter求素数
--------------

.. code:: python

    >>> list(filter(lambda x:str(x) == str(x)[::-1],range(1,1000)))
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 22, 33, 44, 55, 66, 77, 88, 99, 101, 111, 121, 131, 141, 151, 161, 171, 181, 191, 202, 212, 222, 232, 242, 252, 262, 272, 282, 292, 303, 313, 323, 333, 343, 353, 363, 373, 383, 393, 404, 414, 424, 434, 444, 454, 464, 474, 484, 494, 505, 515, 525, 535, 545, 555, 565, 575, 585, 595, 606, 616, 626, 636, 646, 656, 666, 676, 686, 696, 707, 717, 727, 737, 747, 757, 767, 777, 787, 797, 808, 818, 828, 838, 848, 858, 868, 878, 888, 898, 909, 919, 929, 939, 949, 959, 969, 979, 989, 999]
    >>>
