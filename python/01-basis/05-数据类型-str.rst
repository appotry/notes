字符串(str)
===========

字符串类型是Python的序列类型,他的本质就是字符序列,而且Python的字符串类型是不可改变的,你无法将原字符串进行修改,但是可以将字符串的一部分复制到新的字符串中,来达到相同的修改效果.

创建字符串类型
--------------

创建字符串类型可以使用单引号或者双引号又或者三引号来创建,实例如下:

单引号

.. code:: python

    >>> string = 'string'
    >>> type(string)
    <class 'str'>

双引号

.. code:: python

    >>> string = "yang"
    >>> type(string)
    <class 'str'>
    >>> string
    'yang'

三引号

.. code:: python

    >>> string = """yang"""
    >>> type(string)
    <class 'str'>
    >>> string
    'yang'

还可以指定类型

.. code:: python

    >>> var=str('string')
    >>> var
    'string'
    >>> type(var)
    <class 'str'>

字符串方法
----------

    每个类的方法其实都是很多的,无论我们在学习的过程中还是工作的时候,常用的没有多少,所以没必要去记那么多,只要对方法有印象就行了,需要的时候能够搜索到.

.. code:: python

    >>> string = "hello"
    >>> string.    ## 使用tab键查看所有方法
    string.capitalize() # 首字母大写
    string.center() # 内容居中
    string.count()  # 计数
    string.encode() # 编码
    string.endswith()
    string.find()
    string.format()
    string.index()
    string.isdigit()
    string.join()
    string.lower()
    string.replace()
    string.split()
    string.startswith()
    string.strip()
    string.upper()
    ...

capitalize
----------

    首字母变大写

.. code:: python

    >>> name = "yang"
    >>> name.capitalize()
    'Yang'

center
------

内容居中

width:字符串的总宽度;fillchar:填充字符,默认填充字符为空格

    center(self,width,fillchar=None):

.. code:: python

    # 定义一个字符串变量,名为"string",内容为"hello world"
    >>> string = "hello world"
    # 输出这个字符创的长度,用len(value_name)
    >>> len(string)
    11
    # 字符串的总宽度为11,填充的字符为"*"
    >>> string.center(11,"*")
    'hello world'
    # 如果设置字符串的总长度为12,那么减去字符串长度11还剩下一个位置,这个位置就会被*所占用
    >>> string.center(12,"*")
    'hello world*'
    >>> string.center(13,"*")
    '*hello world*'

count
-----

    统计字符串里某个字符出现的次数,可选参数为字符串搜索的开始与结束位置

..

    count(self,sub,start=None,end=None):

+-----------------------------------+-----------------------------------+
| 参数                              | 描述                              |
+===================================+===================================+
| sub                               | 搜索的子字符串                    |
+-----------------------------------+-----------------------------------+
| start                             | 字符串开始搜索的位置.默认为第一个字符,第一个字符索引值为0 |
+-----------------------------------+-----------------------------------+
| end                               | 字符串中结束搜索的位置.字符中第一个字符的索引为0.默认为字符串的 |
|                                   | 最后一个位置                      |
+-----------------------------------+-----------------------------------+

.. code:: python

    >>> string.count("l")
    3
    # 默认搜索出来的"l"是出现过三次的
    >>> string="hello world"
    >>> string.count("l")
    3
    # 如果指定从第三个位置开始搜索,搜索到第六个位置,"l"出现过一次
    >>> string.count("l",3,6)
    1

解码
----

decode(self,encoding=None,errors=None):

编码,针对Unicode
----------------

判断字符串是否是以指定后缀结尾,如果以指定后缀结尾返回TRUE,否则返回False

    endswith(self,suffix,start=None,end=None)

+--------+---------------------------------------------------+
| 参数   | 描述                                              |
+========+===================================================+
| suffix | 后缀,可能是一个字符串,或者也可能是寻找后缀的tuple |
+--------+---------------------------------------------------+
| start  | 开始,切片从这里开始                               |
+--------+---------------------------------------------------+
| end    | 结束,片到此为止                                   |
+--------+---------------------------------------------------+

.. code:: python

    # 判断字符串是否以"d"结尾,如果是则返回"True"
    >>> string = "hello world"
    >>> string.endswith("d")
    True
    # 判断字符串是否以"t"结尾,不是则返回"False"
    >>> string.endswith("t")
    False
    # 指定搜索的为止,实则是从字符串位置1到7来进行判断,如果第七个位置是"d",则返回True,否则返回False
    >>> string.endswith("d",1,7)
    False
    >>>

把字符串中的tab符号(‘:raw-latex:`\t`’)转为空格,tab符号(‘:raw-latex:`\t`’)默认的空格数是8

    expandtabs(self,tabsize=None)

检测字符串中是否包含字符串str,如果指定beg(开始)和end(结束)范围,则检查是否包含在指定范围内,如果包含子字符串返回开始的索引值,否则返回-1
