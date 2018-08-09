datetime
========

datetime是Python处理日期和时间的标准库

获取当前日志和时间
------------------

.. code:: python

    >>> from datetime import datetime
    >>> now = datetime.now()
    >>> print(now)
    2017-05-24 14:59:05.139597
    >>> print(type(now))
    <class 'datetime.datetime'>

``datetime``\ 是模块,\ ``datetime``\ 模块还包含一个\ ``datetime``\ 类,通过\ ``from datetime import datetime``\ 导入的才是\ ``datetime``\ 这个类,如果仅导入\ ``import datetime``,则必须引用全名\ ``datetime.datetime``

``datetime.now()``\ 返回当前日期和时间,起类型是\ ``datetime``

获取指定日志和时间
------------------

要指定某个日期和时间,我们直接用参数构造一个\ ``datetime``

.. code:: python

    >>> from datetime import datetime
    >>> dt = datetime(2017,5,17,5,20)
    >>> print(dt)
    2017-05-17 05:20:00

datetime转换为timestamp
-----------------------

在计算机中,时间实际上是用数字表示的.我们把1970年1月1日00:00:00
UTC+00:00时区的时刻成为epoch
time,记为\ ``0``\ (1970年以前的时间timestamp为负数),当前时间就是相对于``epoch time``\ 的秒数,称为timestamp

你可以认为：

::

    timestamp = 0 = 1970-1-1 00:00:00 UTC+0:00

对应的北京时间是：

::

    timestamp = 0 = 1970-1-1 08:00:00 UTC+8:00

可见timestamp的值与时区毫无关系，因为timestamp一旦确定，其UTC时间就确定了，转换到任意时区的时间也是完全确定的，这就是为什么计算机存储的当前时间是以timestamp表示的，因为全球各地的计算机在任意时刻的timestamp都是完全相同的（假定时间已校准）。

.. code:: python

    >>> from datetime import datetime
    >>> dt = datetime(2017,5,24,3,5) # 用指定日期时间创建datetime
    >>> print(dt)
    2017-05-24 03:05:00
    >>> dt.timestamp() # 把datetime转换为timestamp
    1495566300.0

注意Python的timestamp是一个浮点数。如果有小数位，小数位表示毫秒数。

某些编程语言（如Java和JavaScript）的timestamp使用整数表示毫秒数，这种情况下只需要把timestamp除以1000就得到Python的浮点表示方法。

timestamp转换为datetime
-----------------------

使用\ ``datetime``\ 提供的\ ``fromtimestamp()``\ 方法

.. code:: python

    >>> from datetime import datetime
    >>> t = 1495566300.0
    >>> print(datetime.fromtimestamp(t))
    2017-05-24 03:05:00

注意到timestamp是一个浮点数，它没有时区的概念，而datetime是有时区的。上述转换是在timestamp和本地时间做转换。

本地时间是指当前操作系统设定的时区。例如北京时区是东8区，则本地时间：

::

    2017-05-24 03:05:00

实际上就是UTC+8:00时区的时间：

::

    2017-05-24 03:05:00 UTC+8:00

而此刻的格林威治标准时间与北京时间差了8小时，也就是UTC+0:00时区的时间应该是：

::

    2017-05-23 19:05:00 UTC+0:00

timestamp也可以直接被转换到UTC标准时区的时间

.. code:: python

    >>> from datetime import datetime
    >>> t = 1495566300.0
    >>> print(datetime.fromtimestamp(t))
    2017-05-24 03:05:00
    >>> print(datetime.utcfromtimestamp(t))
    2017-05-23 19:05:00

str转换为datetime
-----------------

很多时候,用户输入的日期和时间是字符串,要处理日期和时间,首先必须把str转换为datetime.转换方法是通过\ ``datetime.strptime()``\ 实现,需要一个日期和时间的格式化字符串.

.. code:: python

    >>> from datetime import datetime
    >>> cday = datetime.strptime('2017-05-24 15:14','%Y-%m-%d %H:%M')
    >>> print(cday)
    2017-05-24 15:14:00

字符串\ ``%Y-%m-%d %H:%M:%S``\ 规定了日期和时间部分的格式。详细的说明请参考。\ `Python文档 <https://docs.python.org/3/library/datetime.html#strftime-strptime-behavior>`__

datetime转换为str
-----------------

如果已经有了datetime对象,要把它格式化为字符串显示给用户,就需要转换为str,转换方法是通过\ ``strftime()``\ 实现的,同样需要一个日期和时间的格式化字符串

.. code:: python

    >>> from datetime import datetime
    >>> now = datetime.now()
    >>> print(now.strftime('%a,%b %d %H:%M'))
    Wed,May 24 15:26

datetime加减
------------

对日期和时间进行加减十几上就是把datetime往后或往前计算,得到新的datetime.加减可以直接用\ ``+``\ 和\ ``-``\ 运算符,不过需要导入\ ``timedelta``\ 这个类

.. code:: python

    >>> from datetime import datetime,timedelta
    >>> now = datetime.now()
    >>> now
    datetime.datetime(2017, 5, 24, 15, 28, 49, 136987)
    >>> now + timedelta(hours=10)
    datetime.datetime(2017, 5, 25, 1, 28, 49, 136987)
    >>> now - timedelta(days = 1)
    datetime.datetime(2017, 5, 23, 15, 28, 49, 136987)
    >>> now + timedelta(days = 2,hours = 12)
    datetime.datetime(2017, 5, 27, 3, 28, 49, 136987)

本地时间转换为UTC时间
---------------------

本地时间是指系统设定时区的时间,例如北京时间是UTC+8:00时区的时间,而UTC时间指UTC+0:00的时间

一个\ ``datetime``\ 类型有一个时区属性\ ``tzinfo``,但是默认为\ ``None``,所以无法区分这个\ ``datetime``\ 是哪个时区,除非强行给\ ``datetime``\ 设置一个时区

.. code:: python

    >>> from datetime import datetime
    >>> from datetime import datetime,timedelta,timezone
    >>> tz_utc_8 = timezone(timedelta(hours=8))
    >>> now = datetime.now()
    >>> now
    datetime.datetime(2017, 5, 24, 15, 32, 32, 126421)
    >>> dt = now.replace(tzinfo=tz_utc_8)
    >>> dt
    datetime.datetime(2017, 5, 24, 15, 32, 32, 126421, tzinfo=datetime.timezone(datetime.timedelta(0, 28800)))

时区转换
--------

可以先通过\ ``utcnow()``\ 拿到当前UTC时间,再转换为任意时区的时间

.. code:: python

    >>> utc_dt = datetime.utcnow().replace(tzinfo=timezone.utc)
    >>> print(utc_dt)
    2017-05-24 07:38:49.792786+00:00
    >>> bj_dt = utc_dt.astimezone(timezone(timedelta(hours=8)))
    >>> print(bj_dt)
    2017-05-24 15:38:49.792786+08:00

时区转换的关键在于，拿到一个datetime时，要获知其正确的时区，然后强制设置时区，作为基准时间。

利用带时区的datetime，通过astimezone()方法，可以转换到任意时区。

注：不是必须从UTC+0:00时区转换到其他时区，任何带时区的datetime都可以正确转换，例如上述bj_dt到tokyo_dt的转换。

小结
----

``datetime``\ 表示的时间需要时区信息才能确定一个特定的时间，否则只能视为本地时间。

如果要存储\ ``datetime``\ ，最佳方法是将其转换为timestamp再存储，因为timestamp的值与时区完全无关。

测试
----

.. code:: python

    #!/usr/bin/env python
    # -*- coding: utf-8 -*-

    """
    假设你获取了用户输入的日期和时间如2015-1-21 9:01:30，以及一个时区信息如UTC+5:00，均是str，请编写一个函数将其转换为timestamp：

    """

    import re
    from datetime import datetime, timezone, timedelta

    def to_timestamp(dt_str, tz_str):
        dt = datetime.strptime(dt_str,'%Y-%m-%d %H:%M:%S')

        res = int(re.search("[+-]\d+", tz_str).group())
        tz_zone = timezone(timedelta(hours=res))

        return dt.replace(tzinfo=tz_zone).timestamp()

    t1 = to_timestamp('2015-6-1 08:10:30', 'UTC+7:00')
    assert t1 == 1433121030.0, t1

    t2 = to_timestamp('2015-5-31 16:10:30', 'UTC-09:00')
    assert t2 == 1433121030.0, t2

    print('Pass')

附录 格式代码标准
-----------------

`<https://docs.python.org/3/library/datetime.html#strftime-and-strptime-behavior>`_ 

简单列表::

    %a 本地的星期缩写
    %A 本地的星期全称
    %b 本地的月份缩写
    %B 本地的月份全称
    %c 本地的合适的日期和时间表示形式
    %d 月份中的第几天，类型为decimal number（10进制数字），范围[01,31]
    %f 微秒，类型为decimal number，范围[0,999999]，Python 2.6新增
    %H 小时（24进制），类型为decimal number，范围[00,23]
    %I 小时（12进制），类型为decimal number，范围[01,12]
    %j 一年中的第几天，类型为decimal number，范围[001,366]
    %m 月份，类型为decimal number，范围[01,12]
    %M 分钟，类型为decimal number，范围[00,59]
    %p 本地的上午或下午的表示（AM或PM），只当设置为%I（12进制）时才有效
    %S 秒钟，类型为decimal number，范围[00,61]（60和61是为了处理闰秒）
    %U 一年中的第几周（以星期日为一周的开始），类型为decimal number，范围[00,53]。在度过新年时，直到一周的全部7天都在该年中时，才计算为第0周。只当指定了年份才有效。
    %w 星期，类型为decimal number，范围[0,6]，0为星期日
    %W 一年中的第几周（以星期一为一周的开始），类型为decimal number，范围[00,53]。在度过新年时，直到一周的全部7天都在该年中时，才计算为第0周。只当指定了年份才有效。
    %y 去掉世纪的年份数，类型为decimal number，范围[00,99]
    %Y 带有世纪的年份数，类型为decimal number
    %Z 时区名字（不存在时区时为空）
    %% 代表转义的"%"字符