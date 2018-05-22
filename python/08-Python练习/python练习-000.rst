Python 练习册，每天一个小程序
=============================

说明
----

-  Python 练习册，每天一个小程序。注：将 Python
   换成其他语言，大多数题目也适用
-  不会出现诸如「打印九九乘法表」、「打印水仙花」之类的题目
-  `点此链接，会看到部分题目的代码，仅供参考 <https://github.com/Show-Me-the-Code/python>`__
-  本文本文由@史江歌（shijiangge@gmail.com
   QQ:499065469）根据互联网资料收集整理而成，感谢互联网，感谢各位的分享。鸣谢！本文会不断更新。

..

    Talk is cheap. Show me the code.–Linus Torvalds

--------------

第 0000 题
----------

**将你的 QQ
头像（或者微博头像）右上角加上红色的数字，类似于微信未读信息数量那种提示效果。**

类似于图中效果

.. figure:: http://i.imgur.com/sg2dkuY.png?1
   :alt: 头像

   头像

.. code:: python

    from PIL import Image, ImageDraw, ImageFont


    def draw_num(img):

        draw = ImageDraw.Draw(img)
        w, h = img.size
        Font = ImageFont.truetype('BeauRivageOne.ttf', size=60)
        draw.text((0.9* w, 0), '4', fill='red', font=Font)
        img.save('haha.jpg', 'jpeg')


    im = Image.open('pic-0000.jpg')
    print(im.size)
    draw_num(im)

第 0001 题
----------

**做为 Apple Store App
独立开发者，你要搞限时促销，为你的应用\ ``生成激活码``\ （或者优惠券），使用
Python 如何生成 200 个激活码（或者优惠券）？**

.. code:: shell

    import uuid


    def generate_code(count):
        code_list = []
        for i in range(count):
            code = str(uuid.uuid4()).replace('-', '').upper()
            if code not in code_list:
                code_list.append(code)

        return code_list


    if __name__ == '__main__':
        code_list = generate_code(200)
        print('\n'.join(code_list))

第 0002 题
----------

将 0001 题生成的 200 个激活码（或者优惠券）保存到MySQL关系型数据库中

.. code:: python

    import uuid
    import pymysql


    def generate_code(count):
        code_list = []
        for i in range(count):
            code = str(uuid.uuid4()).replace('-', '').upper()
            if code not in code_list:
                code_list.append(code)

        return code_list

    def add_to_mysql(codes):
        db = pymysql.connect(host='127.0.0.1', user='yang', passwd='111111', db='xxx')
        cursor = db.cursor()

        cursor.execute(r'''CREATE TABLE IF NOT EXISTS tb_code(
                        id INT NOT NULL AUTO_INCREMENT,
                        code VARCHAR(32) NOT NULL,
                        PRIMARY KEY(id) )''')
        for code in codes:
            cursor.execute('insert into tb_code(code) values(%s)', (code))
        cursor.connection.commit()
        db.close()


    if __name__ == '__main__':
        code_list = generate_code(200)
        # print('\n'.join(code_list))

        add_to_mysql(code_list)

第 0003 题
----------

将 0001 题生成的 200 个激活码（或者优惠券）保存到 **Redis**
非关系型数据库中。

.. code:: python

    import uuid
    import redis


    def generate_code(count):
        code_list = []
        for i in range(count):
            code = str(uuid.uuid4()).replace('-', '').upper()
            if code not in code_list:
                code_list.append(code)

        return code_list


    def insert_into_redis(codes):
        r = redis.Redis(host='127.0.0.1', port=6379, decode_responses=True)

        counter = 0
        for code in codes:
            r.set('code-%s' % counter, code)
            counter += 1
        print(r.get('code-0'))


    if __name__ == '__main__':
        code_list = generate_code(200)
        # print('\n'.join(code_list))

        insert_into_redis(code_list)

第 0004 题
----------

任一个英文的纯文本文件，统计其中的单词出现的个数。

简单版

.. code:: python

    import collections
    import re

    file_name = "The Old Man and the Sea.txt"

    c = collections.Counter()
    with open(file_name, 'r') as f:
        c.update(re.findall(r'\b[a-zA-Z\']+\b', f.read()))
        # c.update(re.findall(r'\b[a-zA-Z]+\b', f.read()))

    with open("WordCount.txt", 'w') as wf:
        for word in c.most_common():
            wf.write(word[0]+','+str(word[1])+'\n')

第 0005 题
----------

你有一个目录，装了很多照片，把它们的尺寸变成都不大于 iPhone5
分辨率的大小。

.. code:: python

    '''
    你有一个目录，装了很多照片，把它们的尺寸变成都不大于 iPhone5 分辨率的大小。
    '''

    import os
    from PIL import Image

    DIR_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'pic')


    def re_size(dirPath, size_w, size_h):
        f_list = os.listdir(dirPath)
        print(f_list)
        for i in f_list:
            if os.path.splitext(i)[1] == '.jpg':
                img = Image.open(os.path.join(dirPath, i))
                w, h = img.size
                if w < size_w and h < size_h:
                    continue
                img.thumbnail((size_w, size_h))

                img.save(os.path.join(dirPath, "thumbnail-%s" % i))

    re_size(DIR_PATH, 1100, 800)

第 0006 题
----------

你有一个目录，放了你一个月的日记，都是
txt，为了避免分词的问题，假设内容都是英文，请统计出你认为每篇日记最重要的词。

.. code:: python

    '''
    你有一个目录，放了你一个月的日记，都是 txt，为了避免分词的问题，假设内容都是英文，请统计出你认为每篇日记最重要的词。
    '''

    import collections
    import re

    file_name = "The Old Man and the Sea.txt"

    c = collections.Counter()
    with open(file_name, 'r') as f:
        c.update(re.findall(r'\b[a-zA-Z\']+\b', f.read()))
        # c.update(re.findall(r'\b[a-zA-Z]+\b', f.read()))

    l = filter(lambda x: len(x[0]) > 2 and x[0] != 'the' and x[0] != 'her' and x[0] != 'his', c.most_common())
    print(list(l))

第 0007 题
----------

有个目录，里面是你自己写过的程序，统计一下你写过多少行代码。包括空行和注释，但是要分别列出来。

第 0008 题
----------

一个HTML文件，找出里面的\ **正文**\ 。

.. code:: python

    '''
    一个HTML文件，找出里面的正文。
    '''

    from bs4 import BeautifulSoup


    html_doc = """
    <html><head><title>The Dormouse's story</title></head>
    <body>
    <p class="title"><b>The Dormouse's story</b></p>

    <p class="story">Once upon a time there were three little sisters; and their names were
    <a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>,
    <a href="http://example.com/lacie" class="sister" id="link2">Lacie</a> and
    <a href="http://example.com/tillie" class="sister" id="link3">Tillie</a>;
    and they lived at the bottom of a well.</p>

    <p class="story">...</p>
    """

    soup = BeautifulSoup(html_doc, "html.parser")
    print(soup.get_text())

第 0009 题
----------

一个HTML文件，找出里面的\ **链接**\ 。

.. code:: python

    '''
    一个HTML文件，找出里面的链接。
    '''

    from bs4 import BeautifulSoup

    html_doc = """
    <html><head><title>The Dormouse's story</title></head>
    <body>
    <p class="title"><b>The Dormouse's story</b></p>

    <p class="story">Once upon a time there were three little sisters; and their names were
    <a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>,
    <a href="http://example.com/lacie" class="sister" id="link2">Lacie</a> and
    <a href="http://example.com/tillie" class="sister" id="link3">Tillie</a>;
    and they lived at the bottom of a well.</p>

    <p class="story">...</p>
    """

    soup = BeautifulSoup(html_doc, "html.parser")

    for link in soup.find_all('a'):
        print(link.get('href'))

第 0010 题
----------

使用 Python 生成类似于下图中的\ **字母验证码图片**

.. figure:: http://i.imgur.com/aVhbegV.jpg
   :alt: 字母验证码

   字母验证码

-  `阅读资料 <http://stackoverflow.com/questions/2823316/generate-a-random-letter-in-python>`__

第 0011 题
----------

敏感词文本文件
filtered_words.txt，里面的内容为以下内容，当用户输入敏感词语时，则打印出
Freedom，否则打印出 Human Rights。

.. code:: shell

    北京
    程序员
    公务员
    领导
    牛比
    牛逼
    你娘
    你妈
    love
    sex
    jiangge

.. code:: python

    #!/usr/bin/env python
    # -*- coding: utf-8 -*-

    __author__ = "Ysara"

    '''
    敏感词文本文件 filtered_words.txt，里面的内容为以下内容，当用户输入敏感词语时，则打印出 Freedom，否则打印出 Human Rights。

    '''

    import re
    from functools import reduce

    with open('filtered_words.txt', 'r', encoding='utf8') as f:
        # filtered_words = list(map(lambda x: x.strip(), f.readlines()))
        filtered_pattern = reduce(lambda x, y: x.strip()+'|'+y, f.readlines())

    print(filtered_pattern)

    while True:
        i = input("请输入: ")
        if re.search(filtered_pattern, i):
            print('Freedom')
        else:
            print('Human Rights')

第 0012 题
----------

敏感词文本文件 filtered_words.txt，里面的内容 和
0011题一样，当用户输入敏感词语，则用 星号 ``*``
替换，例如当用户输入\ ``「北京是个好城市」``\ ，则变成
``「**是个好城市」``\ 。

.. code:: python

    '''
    敏感词文本文件 filtered_words.txt，里面的内容 和 0011题一样，当用户输入敏感词语，则用 星号 * 替换，例如当用户输入「北京是个好城市」，则变成「**是个好城市」。
    '''

    import re
    from functools import reduce

    with open('filtered_words.txt', 'r', encoding='utf8') as f:
        filtered_pattern = reduce(lambda x, y: x.strip()+'|'+y, f.readlines())

    print(filtered_pattern)

    while True:
        i = input("请输入: ")
        c = re.sub(filtered_pattern, '**', i)
        print(c)

第 0013 题
----------

用 Python 写一个爬图片的程序，爬 `这个链接里的日本妹子图片
:-) <http://tieba.baidu.com/p/2166231880>`__

-  `参考代码 <http://www.v2ex.com/t/61686>`__

第 0014 , 0015, 0016 题
-----------------------

0014
~~~~

.. code:: shell

    纯文本文件 student.txt为学生信息, 里面的内容（包括花括号）如下所示：

    {
        "1":["张三",150,120,100],
        "2":["李四",90,99,95],
        "3":["王五",60,66,68]
    }

请将上述内容写到 student.xls 文件中，如下图所示：

.. figure:: http://i.imgur.com/nPDlpme.jpg
   :alt: student.xls

   student.xls

.. _section-1:

0015
~~~~

.. code:: shell

    纯文本文件 city.txt为城市信息, 里面的内容（包括花括号）如下所示：
    {
        "1" : "上海",
        "2" : "北京",
        "3" : "成都"
    }

请将上述内容写到 ``city.xls`` 文件中，如下图所示：

.. figure:: http://i.imgur.com/rOHbUzg.png
   :alt: city.xls

   city.xls

.. _section-2:

0016
~~~~

.. code:: shell

    纯文本文件 numbers.txt, 里面的内容（包括方括号）如下所示：

    [
        [1, 82, 65535],
        [20, 90, 13],
        [26, 809, 1024]
    ]

.. figure:: http://i.imgur.com/iuz0Pbv.png
   :alt: numbers.xls

   numbers.xls

-  `阅读资料 <http://www.cnblogs.com/skynet/archive/2013/05/06/3063245.html>`__
   腾讯游戏开发 XML 和 Excel 内容相互转换

解答
~~~~

.. code:: python

    #!/usr/bin/env python
    # -*- coding: utf-8 -*-

    __author__ = "Ysara"


    '''
    0014

    纯文本文件 student.txt为学生信息, 里面的内容（包括花括号）如下所示：

    {
        "1":["张三",150,120,100],
        "2":["李四",90,99,95],
        "3":["王五",60,66,68]
    }
    ----
    0015

    纯文本文件 city.txt为城市信息, 里面的内容（包括花括号）如下所示：

    {
        "1" : "上海",
        "2" : "北京",
        "3" : "成都"
    }
    ----
    0016
    纯文本文件 numbers.txt, 里面的内容（包括方括号）如下所示：

    [
        [1, 82, 65535],
        [20, 90, 13],
        [26, 809, 1024]
    ]

    '''

    import json
    from collections import OrderedDict
    from openpyxl import Workbook


    with open('student.txt', 'r', encoding='utf8') as f:
        students_info = json.load(f, object_pairs_hook=OrderedDict)

    wb = Workbook()
    sheet = wb.active

    # 0014
    sheet.title = "student"

    for i in students_info:
        sheet.append([i] + students_info[i])


    # 0015
    with open('city.txt', 'r', encoding='utf8') as f:
        city = OrderedDict(json.load(f, object_pairs_hook=OrderedDict))

    sheet_city = wb.create_sheet('city', index=1)

    for item in city.items():
        # ('1', '上海')
        sheet_city.append(item)


    # 0016
    with open('numbers.txt', 'r', encoding='utf8') as f:
        numbers = json.load(f)

    sheet_num = wb.create_sheet('numbers', index=2)
    for num in numbers:
        sheet_num.append(num)


    wb.save(r'student-city-num.xlsx')

    print(students_info)
    print(city)
    print(numbers)

第 0017 题
----------

将 第 0014 题中的 student.xls 文件中的内容写到 student.xml 文件中，如

下所示：

.. code:: html

    <?xml version="1.0" encoding="UTF-8"?>
    <root>
    <students>
    <!--
        学生信息表
        "id" : [名字, 数学, 语文, 英文]
    -->
    {
        "1" : ["张三", 150, 120, 100],
        "2" : ["李四", 90, 99, 95],
        "3" : ["王五", 60, 66, 68]
    }
    </students>
    </root>

第 0018 题
----------

将 第 0015 题中的 city.xls 文件中的内容写到 city.xml 文件中，如下所示：

.. code:: html

    <?xmlversion="1.0" encoding="UTF-8"?>
    <root>
    <citys>
    <!--
        城市信息
    -->
    {
        "1" : "上海",
        "2" : "北京",
        "3" : "成都"
    }
    </citys>
    </root>

第 0019 题
----------

将 第 0016 题中的 numbers.xls 文件中的内容写到 numbers.xml 文件中，如下

所示：

.. code:: xml

    <?xml version="1.0" encoding="UTF-8"?>
    <root>
    <numbers>
    <!--数字信息-->
    [
        [1, 82, 65535],
        [20, 90, 13],
        [26, 809, 1024]
    ]

    </numbers>
    </root>

第 0020 题
----------

`登陆中国联通网上营业厅 <http://iservice.10010.com/index_.html>`__
后选择「自助服务」 –>
「详单查询」，然后选择你要查询的时间段，点击「查询」按钮，查询结果页面的最下方，点击「导出」，就会生成类似于
2014年10月01日～2014年10月31日通话详单.xls
文件。写代码，对每月通话时间做个统计。

第 0021 题
----------

通常，登陆某个网站或者
APP，需要使用用户名和密码。密码是如何加密后存储起来的呢？请使用 Python
对密码加密。

-  阅读资料 `用户密码的存储与 Python
   示例 <http://zhuoqiang.me/password-storage-and-python-example.html>`__

-  阅读资料 `Hashing Strings with
   Python <http://www.pythoncentral.io/hashing-strings-with-python/>`__

-  阅读资料 `Python’s safest method to store and retrieve passwords from
   a
   database <http://stackoverflow.com/questions/2572099/pythons-safest-method-to-store-and-retrieve-passwords-from-a-database>`__

第 0022 题
----------

iPhone 6、iPhone 6 Plus 早已上市开卖。请查看你写得 第 0005
题的代码是否可以复用。

第 0023 题
----------

使用 Python 的 Web 框架，做一个 Web 版本 留言簿 应用。

`阅读资料：Python 有哪些 Web 框架 <http://v2ex.com/t/151643#reply53>`__

-  |留言簿参考|

第 0024 题
----------

使用 Python 的 Web 框架，做一个 Web 版本 TodoList 应用。

-  |SpringSide 版TodoList|

第 0025 题
----------

使用 Python 实现：对着电脑吼一声,自动打开浏览器中的默认网站。

::

    例如，对着笔记本电脑吼一声“百度”，浏览器自动打开百度首页。

    关键字：Speech to Text

参考思路： 1：获取电脑录音–>WAV文件 python record wav

2：录音文件–>文本

::

    STT: Speech to Text

    STT API Google API

3:文本–>电脑命令

第 0026 题
----------

.. |留言簿参考| image:: http://i.imgur.com/VIyCZ0i.jpg
.. |SpringSide 版TodoList| image:: http://i.imgur.com/NEf7zHp.jpg

