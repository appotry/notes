字典数据类型
============

字典(dict)在基本的数据类型中使用频率也是相当高的,而且它的访问方式是通过键来获取到对应的值,当然存储的方式也是\ ``键值对``\ 了,属于可变类型

特性:

-  dict是无序的
-  key必须是唯一的,天生去重

创建字典的两种方法
------------------

第一种

.. code:: python

    >>> dic = {"k1":"123","k2":"456"}
    >>> dic
    {'k1': '123', 'k2': '456'}
    >>> type(dic)
    <class 'dict'>

第二种

.. code:: python

    >>> dic = dict ({"k1":"123","k2":"456"})
    >>> dic
    {'k1': '123', 'k2': '456'}
    >>> type(dic)
    <class 'dict'>

在创建字典的时候,\ ``__init__``\ 初始化的时候还可以接受一个可迭代的变量作为值

.. code:: python

    >>> li = ["a","b","c"]
    >>> dic = dict(enumerate(li))
    >>> dic
    {0: 'a', 1: 'b', 2: 'c'}

默认dict在添加元素的时候会把li列表中的元素for循环一遍,添加的时候列表中的内容是字典的值,而键默认是没有的,可以通过enumerate方法给他加一个序列,也就是键

与其变量不同的是,字典的键不仅仅支持字符串,而且还支持其他数据类型

.. code:: python

    # 数字
    >>> D = {1:3}
    >>> D[1]
    3
    # 元组
    >>> D = {(1,2,3):3}
    >>> D[(1,2,3)]
    3

字典解析

.. code:: python

    >>> D = {x: x*2 for x in range(10)}
    >>> D
    {0: 0, 1: 2, 2: 4, 3: 6, 4: 8, 5: 10, 6: 12, 7: 14, 8: 16, 9: 18}
    # 可以使用zip
    >>> D = {k:v for (k,v) in zip(['a','b','c'],[1,2,3])}
    >>> D
    {'a': 1, 'b': 2, 'c': 3}

字典所提供的常用方法
--------------------

.. code:: python

    >>> dict. # 使用tab键查看

    1. clear(self)         删除字典中的所有元素
    2. copy(self)          返回一个字典的浅复制
    3. fromkeys(S,v=None)  创建一个新字典,以序列seq中元素做字典的键,value为字典所有键对应的初始值
    4. get(self,k,d=None)  返回指定键的值,如果值不在字典中返回默认值
    5. items(self)         以列表返回可遍历的(键,值)元组数组
    6. keys(self)          以列表的形式返回一个字典所有的键
    7. pop(self,k,d=None)  删除指定给定键所对应的值,返回这个值并从字典中把它移除
    8. popitem(self)       随机返回并删除字典中的一对键和值,因为字典是无序的,没有所谓的"最后一项"或是其他顺序
    9. setdefault(self,k,d=None)  如果key不存在,则创建,如果存在,则返回已存在的值且不修改
    10. update(self,E=None,**F)   把字典dic2的键/值更新到dic1里 dic1.update(dic2)
    11. values(self)              显示字典中所有的值

字典操作
--------

.. code:: python

    info = {
        'stu1101': "TengLan Wu",
        'stu1102': "LongZe Luola",
        'stu1103': "XiaoZe Maliya",
    }

增加
~~~~

.. code:: python

    >>> info["stu1104"] = "苍井空"
    >>> info
    {'stu1103': 'XiaoZe Maliya', 'stu1102': 'LongZe Luola', 'stu1101': 'TengLan Wu', 'stu1104': '苍井空'}
    >>>

修改
~~~~

.. code:: python

    >>> info['stu1101'] = "武藤兰"
    >>> info
    {'stu1103': 'XiaoZe Maliya', 'stu1102': 'LongZe Luola', 'stu1101': '武藤兰', 'stu1104': '苍井空'}
    >>>

删除
~~~~

.. code:: python

    >>> info
    {'stu1103': 'XiaoZe Maliya', 'stu1102': 'LongZe Luola', 'stu1101': '武藤兰', 'stu1104': '苍井空'}
    >>> info.pop("stu1101") # 标准删除
    '武藤兰'
    >>> info
    {'stu1103': 'XiaoZe Maliya', 'stu1102': 'LongZe Luola', 'stu1104': '苍井空'}
    >>> del info["stu1103"] # 其他删除
    >>> info
    {'stu1102': 'LongZe Luola', 'stu1104': '苍井空'}
    >>>
    >>> info.popitem() # 随机删除
    ('stu1102', 'LongZe Luola')
    >>> info
    {'stu1104': '苍井空'}

查找
~~~~

.. code:: python

    >>> info = {'stu1102': 'LongZe Luola', 'stu1103': 'XiaoZe Maliya'}
    >>> "stu1102" in info # 标准用法
    True
    >>> info.get("stu1102") # 获取,安全的获取
    'LongZe Luola'
    >>> info["stu1102"] # 同上,但是看下面,如果一个key不存在,则会报错,get不会,不存在只会返回None
    'LongZe Luola'
    >>> info["stu1105"]
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    KeyError: 'stu1105'

多级字典嵌套即操作
~~~~~~~~~~~~~~~~~~

.. code:: python

    av_catalog = {
        "欧美":{
            "www.youporn.com": ["很多免费的,世界最大的","质量一般"],
            "www.pornhub.com": ["很多免费的,也很大","质量比yourporn高点"],
            "letmedothistoyou.com": ["多是自拍,高质量图片很多","资源不多,更新慢"],
            "x-art.com":["质量很高,真的很高","全部收费,屌比请绕过"]
        },
        "日韩":{
            "tokyo-hot":["质量怎样不清楚,个人已经不喜欢日韩范了","听说是收费的"]
        },
        "大陆":{
            "1024":["全部免费,真好,好人一生平安","服务器在国外,慢"]
        }
    }

    >>> av_catalog["大陆"]["1024"][1] += ",可以用爬虫爬下来"
    >>> print(av_catalog["大陆"]["1024"])
    ['全部免费,真好,好人一生平安', '服务器在国外,慢,可以用爬虫爬下来']

其他
~~~~

.. code:: python

    # values
    >>> info = {'stu1102': 'LongZe Luola', 'stu1103': 'XiaoZe Maliya'}
    >>> info.values()
    dict_values(['XiaoZe Maliya', 'LongZe Luola'])

    # keys
    >>> info.keys()
    dict_keys(['stu1103', 'stu1102'])

    # setdefault
    >>> info.setdefault("stu1106","xxxx")
    'xxxx'
    >>> info
    {'stu1103': 'XiaoZe Maliya', 'stu1102': 'LongZe Luola', 'stu1106': 'xxxx'}
    >>> info.setdefault("stu1102","泷泽萝拉")
    'LongZe Luola'
    >>> info
    {'stu1103': 'XiaoZe Maliya', 'stu1102': 'LongZe Luola', 'stu1106': 'xxxx'}

    # update
    >>> info
    {'stu1103': 'XiaoZe Maliya', 'stu1102': 'LongZe Luola', 'stu1106': 'xxxx'}
    >>> b = {1:2,3:4,"stu1102":"泷泽萝拉"}
    >>> info.update(b)
    >>> info
    {'stu1103': 'XiaoZe Maliya', 'stu1102': '泷泽萝拉', 3: 4, 'stu1106': 'xxxx', 1: 2}

    # items
    >>> info.items()
    dict_items([('stu1103', 'XiaoZe Maliya'), ('stu1102', '泷泽萝拉'), (3, 4), ('stu1106', 'xxxx'), (1, 2)])

    # 通过一个列表生成默认dict,有个没办法解释的坑,少用这个
    >>> dict.fromkeys([1,2,3],'testd')
    {1: 'testd', 2: 'testd', 3: 'testd'}

``python 2.x`` 判断一个key是不是在字典里

.. code:: python

    d = {1:1}
    d.has_key(1) # 返回 True 或 False

循环dict
~~~~~~~~

.. code:: python

    # 遍历字典key
    for key in info:
        print(key,info[key])

    # 遍历字典值
    # for v in info.values():
          print(v)

    # 遍历字典项
    for k,v in info.items(): # 会先把dict转成list,数据大时莫用
        print(k,v)

setdefault
~~~~~~~~~~
