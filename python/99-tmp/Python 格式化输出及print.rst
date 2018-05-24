print
=====

输出不换行
----------

Python 2.x print

::

    print x,

**Python 3.x**

::

    print(x,end="")

print原型
---------

end 默认为 ``\n``

.. code:: python

    def print(self, *args, sep=' ', end='\n', file=None): # known special case of print
        """
        print(value, ..., sep=' ', end='\n', file=sys.stdout, flush=False)

        Prints the values to a stream, or to sys.stdout by default.
        Optional keyword arguments:
        file:  a file-like object (stream); defaults to the current sys.stdout.
        sep:   string inserted between values, default a space.
        end:   string appended after the last value, default a newline.
        flush: whether to forcibly flush the stream.
        """
        pass

格式化输出
----------

python格式化字符串有%和{}两种 字符串格式控制符.

字符串输入数据格式类型(%格式操作符号)

.. code:: python

    %%百分号标记

    %c字符及其ASCII码

    %s字符串

    %d有符号整数(十进制)

    %u无符号整数(十进制)

    %o无符号整数(八进制)

    %x无符号整数(十六进制)

    %X无符号整数(十六进制大写字符)

    %e浮点数字(科学计数法)

    %E浮点数字(科学计数法，用E代替e)

    %f浮点数字(用小数点符号) 以为小数 %.1f 百分比 %2.1f %%

    %g浮点数字(根据值的大小采用%e或%f)

    %G浮点数字(类似于%g)

    %p指针(用十六进制打印值的内存地址)

    %n存储输出字符的数量放进参数列表的下一个变量中

    如果字符串里面的 `%` 是一个普通字符,这个时候就需要转义，用 `%%` 来表示一个 `%`

字符串格式控制%[(name)][flag][width][.][precision]type
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

name:可为空，数字(占位),命名(传递参数名,不能以数字开头)以字典格式映射格式化，其为键名

flag:标记格式限定符号,包含+-#和0,+表示右对齐(会显示正负号),-左对齐,前面默认为填充空格(即默认右对齐)，0表示填充0，#表示八进制时前面补充0,16进制数填充0x,二进制填充0b

width:宽度(最短长度,包含小数点,小于width时会填充)

precision:小数点后的位数,与C相同

type:输入格式类型，请看上面

还有一种format_spec格式{[name][:][[fill]align][sign][#][0][width][,][.precision][type]}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

用{}包裹name命名传递给format以命名=值 写法,非字典映射,其他和上面相同

``fill =  <any character>``　　#fill是表示可以填写任何字符

``align =  "<" | ">" | "=" | "^"``　　#align是对齐方式，<是左对齐，
>是右对齐，^是居中对齐。

``sign  =  "+" | "-" | " "``　　#sign是符号， +表示正号， -表示负号

``width =  integer``　　#width是数字宽度，表示总共输出多少位数字

``precision =  integer``　　#precision是小数保留位数

``type =  "b" | "c" | "d" | "e" | "E" | "f" | "F" | "g" | "G" | "n" | "o" | "s" | "x" | "X" | "%"``　　#type是输出数字值是的表示方式，比如b是二进制表示；比如E是指数表示；比如X是十六进制表示

.. code:: python

    >>> print("{color}-{what}".format(**dic))
    green-apple

    print("{:,}".format(123456))#输出1234,56
    print("{a:w^8}".format(a="8"))#输出www8wwww,填充w
    print("%.5f" %5)#输出5.000000
    print("%-7s3" %("python"))#输出python 3
    print("%.3e" %2016)#输出2.016e+03,也可以写大E
    print("%d %s" %(123456,"myblog"))#输出123456 myblog

    >>> print("{}{}{}".format("xxx",".","cn"))
    xxx.cn
    >>> print("{0}{1}".format("hello","fun"))
    hellofun
    >>> print("{a[0]}{a[1]}{a[2]}".format(a=["xxx",".","cn"]))
    xxx.cn
    >>> print("{dict[host]}{dict[dot]}{dict[domain]}".format(dict={"host":"www","domain":"xxx.cn","dot":"."}))
    www.xxx.cn
    >>> print("{who} {doing} {0}".format("python",doing="like",who="I"))
    I like python

    >>> print("%(color)s-%(what)s" % {'color': 'red', 'what': 'xxx'})
    red-xxx
