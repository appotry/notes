Python3内置函数
===============

The Python interpreter has a number of functions and types built into it
that are always available. They are listed here in alphabetical order.

`官方介绍 <https://docs.python.org/3/library/functions.html>`__

内置函数详解
------------

abs(x)
~~~~~~

    返回数字的绝对值,参数可以是整数或浮点数,如果参数是复数,则返回其大小

.. code:: python

    >>> abs(-517)
    517

all(iterable)
~~~~~~~~~~~~~

    all()会循环括号内的每一个元素,如果括号内的所有元素都是真的,或者如果iterable为空,则返回\ ``True``,如果有一个为假,那么久返回\ ``False``

.. code:: python

    >>> all([])
    True
    >>> all([1,2,3])
    True
    >>> all([1,2,""])
    False
    >>> all([1,2,None])
    False

假的参数有：False、0、None、“”、[]、()、{}等，查看一个元素是否为假可以使用bool进行查看。

any(iterable)
~~~~~~~~~~~~~

    循环元素,如果有一个元素为真,那么久返回True,否则就返回False

.. code:: python

    >>> any([0,1])
    True
    >>> any([0])
    False

ascii(object)
~~~~~~~~~~~~~

    在对象的类中寻找\ ``__repr__``\ 方法,获取返回值

.. code:: python

    >>> class Foo:
    ...   def __repr_(self):
    ...     return "hello"
    ...
    >>> obj = Foo()
    >>> r = ascii(obj)
    >>> print(r)
    <__main__.Foo object at 0x101a9fe80>
    # 返回的是一个可迭代的对象

bin(x)
~~~~~~

    将整数x转换为二进制字符串,如果x不为python中int类型,x必须包含方法\ ``__index__()``\ 并且返回值为\ ``integer``

.. code:: python

    # 返回一个整数的二进制
    >>> bin(999)
    '0b1111100111'

.. code:: python

    >>> class myType:
    ...   def __index__(self):
    ...     return 35
    ...
    >>> myvar = myType()
    >>> bin(myvar)
    '0b100011'

bool([x])
~~~~~~~~~

    查看一个元素的布尔值,非真即假

.. code:: python

    >>> bool(0)
    False
    >>> bool(1)
    True
    >>> bool([1])
    True

bytearray()
~~~~~~~~~~~

bytearray([source[,encoding[,errors]]])

    返回一个byte数组,Bytearray类型是一个可变的序列,并且序列中的元素的取值范围为[0,255]

source参数:

1. 如果source为整数,则返回一个长度为source的初始化数组;
2. 如果source为字符串,则按照指定encoding将字符串转换为字节序列;
3. 如果source为可迭代类型,则元素必须为[0,255]中的整数;
4. 如果source为与buffer接口一致的对象,则此对象也可以被用于初始化bytearray.

.. code:: python

    >>> bytearray(3)
    bytearray(b'\x00\x00\x00')

bytes()
~~~~~~~

    bytes([source[,encoding[,errors]]])

.. code:: python

    >>> bytes("yjj",encoding="utf-8")
    b'yjj'

callable(object)
~~~~~~~~~~~~~~~~

    返回一个对象是否可以被执行

.. code:: python

    >>> def func():
    ...   return 123
    ...
    >>> callable(func)
    True
    >>> func = 123
    >>> callable(func)
    False

chr(i)
~~~~~~

    返回一个数字在ASCII编码中对应的字符,取值范围256

.. code:: python

    >>> chr(66)
    'B'
    >>> chr(5)
    '\x05'
    >>> chr(65)
    'A'

classmethod(function)
~~~~~~~~~~~~~~~~~~~~~

    返回函数的类方法

compile()
~~~~~~~~~

compile(source,filename,mode,flags=0,dont_inherit=False,optimize=-1)

    把字符串编译成python可执行的代码,
    代码对象可以使用exec来执行或者eval()进行求值

.. code:: python

    >>> str = "for i in range(0,10):print(i)"
    >>> c = compile(str,'','exec')
    >>> exec(c)
    0
    1
    2
    3
    4
    5
    6
    7
    8
    9

complex()
~~~~~~~~~

complex([real[,imag]])

    创建一个值为real+imag*j的复数或者转化一个字符串(或数字)为复数.如果第一个参数为字符串,则不需要指定第二个参数

.. code:: python

    >>> complex(1,2)
    (1+2j)
    # 数字
    >>> complex(1)
    (1+0j)
    # 当做字符串处理
    >>> complex("1")
    (1+0j)
    # 注意:这个地方在"+"号两边不能有空格,也就是不能写成"1 + 2j",否则会报错
    >>> complex("1+2j")
    (1+2j)

delattr(object,name)
~~~~~~~~~~~~~~~~~~~~

    删除对象的属性值

.. code:: python

    >>> class cls:
    ...   @classmethod
    ...   def echo(self):
    ...     print('CLS')
    ...
    >>> cls.echo()
    CLS
    >>> delattr(cls,'echo')
    >>> cls.echo()
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    AttributeError: type object 'cls' has no attribute 'echo'
    >>>

dict ``(**kwarg)``
~~~~~~~~~~~~~~~~~~~~~~~~~~

    创建一个数据类型为字典

.. code:: python

    >>> dic = dict({"k1":"123","k2":"456"})
    >>> dic
    {'k1': '123', 'k2': '456'}

dir(\ `object <#object>`__)
~~~~~~~~~~~~~~~~~~~~~~~~~~~

    返回一个对象中的所有方法

.. code:: python

    >>> dir(str)
    ['__add__', '__class__', '__contains__', '__delattr__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__getitem__', '__getnewargs__', '__gt__', '__hash__', '__init__', '__iter__', '__le__', '__len__', '__lt__', '__mod__', '__mul__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__rmod__', '__rmul__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', 'capitalize', 'casefold', 'center', 'count', 'encode', 'endswith', 'expandtabs', 'find', 'format', 'format_map', 'index', 'isalnum', 'isalpha', 'isdecimal', 'isdigit', 'isidentifier', 'islower', 'isnumeric', 'isprintable', 'isspace', 'istitle', 'isupper', 'join', 'ljust', 'lower', 'lstrip', 'maketrans', 'partition', 'replace', 'rfind', 'rindex', 'rjust', 'rpartition', 'rsplit', 'rstrip', 'split', 'splitlines', 'startswith', 'strip', 'swapcase', 'title', 'translate', 'upper', 'zfill']

divmod(a,b)
~~~~~~~~~~~

    返回的是a//b(除法取整)以及a对b的余数,返回结果类型为tuple

.. code:: python

    >>> divmod(10,3)
    (3, 1)

enumerate(iterable,start=0)
~~~~~~~~~~~~~~~~~~~~~~~~~~~

    为元素生成下标

.. code:: python

    >>> li = ["a","b","c"]
    >>> for n,k in enumerate(li):
    ...   print(n,k)
    ...
    0 a
    1 b
    2 c

eval()
~~~~~~

eval(expression,globals=None,locals=None)

    把一个字符串当做一个表达式去执行

.. code:: python

    >>> string = "1+3"
    >>> string
    '1+3'
    >>> eval(string)
    4

exec()
~~~~~~

exec(object[,globals[,locals]])

    把字符串当做python代码执行

.. code:: python

    >>> exec("for n in range(5):print(n)")
    0
    1
    2
    3
    4

filter(function,iterable)
~~~~~~~~~~~~~~~~~~~~~~~~~

    筛选过滤,循环可迭代的对象,把迭代的对象当做函数的参数,如果符合条件就返回\ ``True``,否则就返回\ ``False``

.. code:: python

    >>> def func(x):
    ...   if x == 11 or x == 22:
    ...     return True
    ...
    >>> ret = filter(func,[11,22,33,44])
    >>> for n in ret:
    ...   print(n)
    ...
    11
    22

.. code:: python

    >>> list(filter((lambda x : x > 0),range(-5,5)))
    [1, 2, 3, 4]

float([x])
~~~~~~~~~~

    将整数和字符串转换成浮点数

.. code:: python

    >>> float("123")
    123.0
    >>> float("123.45")
    123.45
    >>> float("-123.45")
    -123.45

format()
~~~~~~~~

format(value,[format_spec])

    字符串格式化

`详解 <https://blog.ansheng.me/article/python-full-stack-way-string-formatting/>`__

frozenset([iterable])
~~~~~~~~~~~~~~~~~~~~~

    frozenset是冻结的集合,它是不可改变的,存在哈希值,好处是它可以作为字典的key,也可以作为其他集合的元素.缺点是一旦创建便不能更改,没有add,remove方法.

getattr(object,name[,default])
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    返回对象的命名属性的值,\ ``name``\ 必须是字符串,如果字符串是对象属性之一的名称,则结果是该属性的值.

globals
~~~~~~~

    获取或修改当前文件内的全局变量

.. code:: python

    >>> a = "12"
    >>> b = "434d"
    >>> globals()
    {'__builtins__': <module 'builtins' (built-in)>, '__doc__': None, '__loader__': <class '_frozen_importlib.BuiltinImporter'>, 'b': '434d', '__spec__': None, '__name__': '__main__', '__package__': None, 'a': '12'}

hasattr(object,name)
~~~~~~~~~~~~~~~~~~~~

    参数是一个对象和一个字符串,如果字符串是对象的某个属性的名称,则结果为True,否则为False

hash(object)
~~~~~~~~~~~~

    返回一个对象的hash值

.. code:: python

    >>> a = "afdafasd"
    >>> hash(a)
    2216836390023867832

help(\ `object <#object>`__)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    查看一个类的所有详细方法,或者查看某个方法的使用详细信息

.. code:: python

    >>> help(list)

    Help on class list in module builtins:

    class list(object)
     |  list() -> new empty list
     |  list(iterable) -> new list initialized from iterable's items
     |
     |  Methods defined here:
     |
     |  __add__(self, value, /)
     |      Return self+value.
     |
     |  __contains__(self, key, /)
     |      Return key in self.
     |
     |  __delitem__(self, key, /)
     |      Delete self[key].
     |
     |  __eq__(self, value, /)
     |      Return self==value.
     |
     |  __ge__(self, value, /)
     |      Return self>=value.
     |
     |  __getattribute__(self, name, /)
     |      Return getattr(self, name).
     ......

hex(x)
~~~~~~

    获取一个数的十六进制

.. code:: python

    >>> hex(19)
    '0x13'

id(object)
~~~~~~~~~~

    返回一个对象的内存地址

.. code:: python

    >>> a = 123
    >>> id(a)
    4297558784

input([prompt])
~~~~~~~~~~~~~~~

    交互式输入

.. code:: python

    >>> name = input("Please input your name: ")
    Please input your name: yang
    >>> print(name)
    yang

int(x,base=10)
~~~~~~~~~~~~~~

    获取一个数的十进制

.. code:: python

    >>> int("51")
    51

..

    也可以做进制转换

.. code:: python

    >>> int(10)
    10
    >>> int('0b11',base=2)
    3
    >>> int('0xe',base=16)
    14

isinstance(object,classinfo)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    判断对象是否是这个类创建的

.. code:: python

    >>> li = [11,22,33]
    >>> isinstance(li,list)
    True

issubclass(class,classinfo)
~~~~~~~~~~~~~~~~~~~~~~~~~~~

issubclass()

    查看一个对象是否为子类

iter(object[,sentinel])
~~~~~~~~~~~~~~~~~~~~~~~

    创建一个可迭代的对象

.. code:: python

    >>> obj = iter([11,22,33,44])
    >>> obj
    <list_iterator object at 0x101bfe048>
    >>> for n in obj:
    ...   print(n)
    ...
    11
    22
    33
    44

len(s)
~~~~~~

    查看一个对象的长度

.. code:: python

    >>> url="yang"
    >>> len(url)
    4

list([iterable])
~~~~~~~~~~~~~~~~

    创建一个数据类型为列表

.. code:: python

    >>> li = list([11,22,44])
    >>> li
    [11, 22, 44]

locals()
~~~~~~~~

    返回当前作用域的局部变量,以字典形式输出

.. code:: python

    >>> def func():
    ...   name="yang"
    ...   print(locals())
    ...
    >>> func()
    {'name': 'yang'}

map(function,iterable,…)
~~~~~~~~~~~~~~~~~~~~~~~~

    对一个序列中的每一个元素都传到函数中执行并返回

.. code:: python

    >>> list(map((lambda x : x + 10),[11,22,33,44]))
    [21, 32, 43, 54]

max()
~~~~~

max(iterable,*[,key,default])

max(arg1,arg2,*args[,key])

    取一个对象中的最大值

.. code:: python

    >>> li = [11,22,33,44]
    >>> li
    [11, 22, 33, 44]
    >>> max(li)
    44

memoryview(obj)
~~~~~~~~~~~~~~~

    返回对象obj的内存查看对象

.. code:: python

    >>> import struct
    >>> buf = struct.pack("i"*12,*list(range(12)))
    >>> x = memoryview(buf)
    >>> y = x.cast('i',shape=[2,2,3])
    >>> print(y.tolist())
    [[[0, 1, 2], [3, 4, 5]], [[6, 7, 8], [9, 10, 11]]]
    >>>

min()
~~~~~

min(iterable,*[,key,default])

min(arg1,arg2,*args[,key])

    取一个对象中的最小值

.. code:: python

    >>> li = list([11,22,33])
    >>> min(li)
    11

next()
~~~~~~

next(iterable[,default])

    每次只拿取可迭代对象的一个元素

.. code:: python

    >>> obj = iter([11,22,33,44])
    >>> next(obj)
    11
    >>> next(obj)
    22
    >>> next(obj)
    33
    >>> next(obj)
    44
    # 如果没有可迭代的元素,就会报错
    >>> next(obj)
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    StopIteration

object
~~~~~~

    返回一个新的无特征对象

oct(x)
~~~~~~

    获取一个字符串的八进制

.. code:: python

    >>> oct(15)
    '0o17'

open()
~~~~~~

open(file,mode=‘r’,buffering=-1,encoding=None,errors=None,newline=None,closefd=True,opener=None)

    文件操作的函数,用来做文件操作

.. code:: python

    >>> f = open("a.txt","r")

ord(c)
~~~~~~

    把一个字母转换为ASCII对应表中的数字

.. code:: python

    >>> ord("a")
    97

pow(x,y[,z])
~~~~~~~~~~~~

    返回一个数的N次方

.. code:: python

    >>> pow(2,10)
    1024
    >>> pow(2,20)
    1048576

print()
~~~~~~~

::

    print(*objects,sep='',end=`\n`,file=sys.stdout,flush=False)

    打印输出

.. code:: python

    >>> print("Hello World")
    Hello World

properyt()
~~~~~~~~~~

properyt(fget=None,fset=None,fdel=None,doc=None)

range(start,stop[,step])
~~~~~~~~~~~~~~~~~~~~~~~~

    生成一个序列

.. code:: python

    >>> range(10)
    range(0, 10)
    >>> for n in range(5):
    ...   print(n)
    ...
    0
    1
    2
    3
    4

repr(object)
~~~~~~~~~~~~

    返回一个包含对象的可打印表示的字符串

.. code:: python

    >>> repr(1110)
    '1110'
    >>> repr(111.11)
    '111.11'

reversed(seq)
~~~~~~~~~~~~~

    对一个对象的元素进行反转

.. code:: python

    >>> li = [11,22,33,44]
    >>> reversed(li)
    <list_reverseiterator object at 0x101e96518>
    >>> for n in reversed(li):
    ...   print(n)
    ...
    44
    33
    22
    11

round(number[,ndigits])
~~~~~~~~~~~~~~~~~~~~~~~

    四舍五入

.. code:: python

    >>> round(3.3)
    3
    >>> round(3.7)
    4

set([iterable])
~~~~~~~~~~~~~~~

    创建一个数据类型为集合

.. code:: python

    >>> var = set([11,22,33])
    >>> type(var)
    <class 'set'>

setattr()
~~~~~~~~~

setattr(object,name,value)

    为某个对象设置一个属性

slice()
~~~~~~~

slice(start,stop[,step])

    元素的切片操作都是调用的这个方法

sorted(iterable[,key][,reverse])
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    为一个对象的元素进行排序

.. code:: python

    >>> sorted([5, 2, 3, 1, 4])
    [1, 2, 3, 4, 5]

staticmethod(function)
~~~~~~~~~~~~~~~~~~~~~~

    返回函数的静态方法

str()
~~~~~

str(object=b’‘,encoding=’utf-8’,errors=‘strict’)

    字符串

.. code:: python

    >>> a = str(111)
    >>> type(a)
    <class 'str'>

sum()
~~~~~

sum(iterable[,start])

    求和

.. code:: python

    >>> sum([11,22,33])
    66

super()
~~~~~~~

super([type[,object-or-type]])

    执行父类的构造函数

tuple([iterable])
~~~~~~~~~~~~~~~~~

    创建一个对象,数据类型为元组

.. code:: python

    >>> tup = tuple([11,22,33,44])
    >>> type(tup)
    <class 'tuple'>

type(object)
~~~~~~~~~~~~

    查看一个对象的数据类型

.. code:: python

    >>> tup = tuple([11,22,33,44])
    >>> type(tup)
    <class 'tuple'>

vars(\ `object <#object>`__)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

查看一个对象里面有多少个变量

zip(\*iterables)
~~~~~~~~~~~~~~~~~~~~~

    将两个元素相同的序列转换为字典

.. code:: python

     >>> li1 = ["k1","k2","k3"]
    >>> li2 = ["a","b","c"]
    >>> d = dict(zip(li1,li2))
    >>> d
    {'k2': 'b', 'k1': 'a', 'k3': 'c'}

**import**\ ()
~~~~~~~~~~~~~~

**import**\ (name,globals=None,locals=None,fromlist=(),level=0)

    导入模块,把导入的模块作为一个别名

生成随机验证码例子
------------------

    生成一个六位的随机验证码,且包含数字,数字的位置随机

.. code:: python

    #!/usr/bin/env python
    # _*_ coding:utf-8 _*_

    import random
    temp = ""
    for i in range(6):
        num = random.randrange(0,4)
        if num == 3 or num == 1:
            rad2 = random.randrange(0,10)
            temp += str(rad2)
        else:
            rad1 = random.randrange(65,91)
            c1 = chr(rad1)
            temp += c1
    print(temp)

.. code:: python

    ➜  python_test python3 012-exercise-2.py
    81FZ62
