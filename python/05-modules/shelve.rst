shelve
======

shelve模块是一个简单的k,v将内存数据通过文件持久化的模块,可以持久化任何pickle可支持的Python数据格式

.. code:: python

    import shelve
    import datetime

    d = shelve.open('shelve_test') # 打开一个文件

    class Test(object):
        def __init__(self,n):
            self.n = n

    t = Test(123)
    t2 = Test(123456)

    name = ['xxx','ooo','test']
    info = {'age':18, 'job': 'it'}

    d['name'] = name # 持久化列表
    d['t1'] = t      # 持久化类
    d['t2'] = t2
    d['info'] = info # 持久化字典
    d['date] = datetime.datetime.now()

    d.close()

会在当前目录生成一个\ ``shelve_test.db``
