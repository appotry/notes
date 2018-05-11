time
====

在Python中,通常有几种方式表示时间

1. 时间戳
2. 格式化的时间字符串
3. 元组(共九个元素)

time.strftime()
---------------

.. code:: python

    >>> x = time.localtime()
    >>> x
    time.struct_time(tm_year=2017, tm_mon=6, tm_mday=2, tm_hour=10, tm_min=51, tm_sec=34, tm_wday=4, tm_yday=153, tm_isdst=0)

    # time.strftime("%Y-%m-%d %H:%M:%S",struct_time)  将struct_time 转成格式化的字符串
    >>> time.strftime("%Y-%m-%d %H:%M:%S",x)
    '2017-06-02 10:51:34'

time.strptime()
---------------

.. code:: python

    # time.strptime('2017-06-02 10:51:34',"%Y-%m-%d %H:%M:%S") 将格式化的字符串转成struct_time
    >>> time.strptime('2017-06-02 10:51:34',"%Y-%m-%d %H:%M:%S")
    time.struct_time(tm_year=2017, tm_mon=6, tm_mday=2, tm_hour=10, tm_min=51, tm_sec=34, tm_wday=4, tm_yday=153, tm_isdst=-1)
    >>>

time.gmtime()
-------------

::

    >>> help(time.gmtime) # 帮助信息超级详细

将秒转换成UTC时间的struct_time

默认返回当前time.time()
