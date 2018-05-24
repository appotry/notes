Django模板
==========

模板是一个文本,用于分离文档的表现形式和内容,模板定义了占位符以及各种用于规范文档该如何显示的各部分基本逻辑(模板标签).模板通常用于产生HTML,但是Django的模板也能产生任何给予文本格式的文档.

如何使用模板系统
----------------

在Python代码中使用Django模板的最基本方式如下:

1. 可以用原始的模板代码字符串创建一个\ ``Template``\ 对象,Django同样支持用指定模板文件路径的方式来创建\ ``Template``\ 对象;
2. 调用模板对象的\ ``render``\ 方法,并且传入一套变量\ ``context``.它将返回一个基于模板的展现字符串,模板中的变量和标签会被\ ``context``\ 值替代

模板渲染
--------

一旦你创建一个\ ``Template``\ 对象,你可以用\ ``context``\ 来传递数据给它.一个context是一系列变量和它们值得集合.

``context``\ 在Django里表现为\ ``Context``\ 类,在\ ``django.template``\ 模块里,
她的构造函数带有一个可选的参数:
一个字典映射变量和它们的值.调用\ ``Template``\ 对象的\ ``render()``\ 方法并传递\ ``context``\ 来填充模板

.. code:: python

    >>> from django.template import Context, Template
    >>> t = Template('My name is {{ name }}.')
    >>> c = Context({'name': 'xxx'})
    >>> t.render(c)
    'My name is xxx.'

这就是Django模板系统的基本规则: 写模板,创建 ``Template`` 对象,创建
``Context`` ,调用 ``render()`` 方法.

深度变量的查找
--------------

.. code:: python

    >>> from django.template import Template,Context
    >>> t = Template('{{ person.name }} is {{ person.age }} years old.')
    >>> c = Context({'person': person})
    >>> t.render(c)
    'xxx is 43 years old.'

句点可以用来引用对象的 ``方法`` . 例如,每个Python字符串都有 ``upper()``
和 ``isdigit()`` 方法,你在模板中可以使用同样的句点语法来调用它们

.. code:: python

    >>> from django.template import Template,Context
    >>> t = Template('{{ var }} upper: {{ var.upper }} isdigit: {{ var.isdigit }}')
    >>> t.render(Context({'var': '123'}))
    '123 upper: 123 isdigit: True'
    >>> t.render(Context({'var': 'hello'}))
    'hello upper: HELLO isdigit: False'

句点也可以用与访问列表索引,例如:

.. code:: python

    >>> from django.template import Template,Context
    >>> t = Template('Item 2 is {{ items.2 }}.')
    >>> c = Context({'items': ['apple','bananas','carrote']})
    >>> t.render(c)
    'Item 2 is carrote.'
    >>>

当模板系统在变量名中遇到点时，按照以下顺序尝试进行查找：

1. 字典类型查找(比如 ``foo["bar"]`` )
2. 属性查找(比如 ``foo.bar`` )
3. 方法调用(比如 ``foo.bar()`` )
4. 列表类型索引查找(比如 ``foo[bar]`` )

jinja模板
---------

…

在视图中使用模板
----------------

.. code:: python

    # 首先你要导入os模块
    'DIRS': [os.path.join(BASE_DIR, 'templates')],

加载模板
~~~~~~~~

.. code:: html

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
    </head>
    <body>
    It is now {{ current_date }}.
    </body>
    </html>

render_to_response()
~~~~~~~~~~~~~~~~~~~~

.. code:: python

    from django.shortcuts import render_to_response

    # def current_datetime(request):
    #     now = datetime.datetime.now()
    #     return render_to_response('current_datetime.html',{'current_datetime': now})

locals()技巧
~~~~~~~~~~~~

很多时候，就像在这个范例中那样，你发现自己一直在计算某个变量，保存结果到变量中（比如前面代码中的now），然后将这些变量发送给模板。尤其喜欢偷懒的程序员应该注意到了，不断地为临时变量和临时模板命名有那么一点点多余。不仅多余，而且需要额外的输入。

如果你是个喜欢偷懒的程序员并想让代码看起来更加简明，可以利用 Python
的内建函数\ ``locals()``\ 。它返回的字典对所有局部变量的名称与值进行映射。因此，前面的视图可以重写成下面这个样子

.. code:: python

    def current_datetime(request):
        current_datetime = datetime.datetime.now()
        return render_to_response('current_datetime.html',locals())

在此，我们没有像之前那样手工指定\ ``context``\ 字典，而是传入了\ ``locals()``\ 的值，
它囊括了函数执行到该时间点时所定义的一切变量。因此，我们将\ ``now``\ 变量重命名为\ ``current_date``\ ，
因为那才是模板所预期的变量名称。在本例中，\ ``locals()``\ 并没有带来多大的改进，
但是如果有多个模板变量要界定而你又想偷懒，这种技术可以减少一些键盘输入。

使用\ ``locals()``\ 时要注意是它将包括所有的局部变量，它们可能比你想让模板访问的要多。
在前例中，\ ``locals()``\ 还包含了\ ``request``\ 。对此如何取舍取决你的应用程序。

模板方法
--------

内置方法，类似于python的内置函数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: shell

    {% raw %}
    {{ k1|lower }}  # 将所有字母都变为小写
    {{ k1|first|upper }}  # 将首字母变为大写
    {{ k1|truncatewords:"30" }}  # 取变量k1的前30个字符
    {{ item.createTime|date:"Y-m-d H:i:s" }}    # 将时间转为对应格式显示
    {% endraw %}

自定义方法
~~~~~~~~~~

在内置的方法满足不了我们的需求的时候，就需要自己定义属于自己的方法了，自定义方法分别分为
``filter`` 和 ``simple_tag``

区别
^^^^

.. code:: shell

    ① 传参：
        filter默认最多只支持2个参数：可以用{{ k1|f1:"s1, s2, s3" }}这种形式将参数传递个函数，由函数去split拆分
        simple_tag支持多个参数：{% f1 s1 s2 s3 s4 %}  有多少就写多少

    ② 模板语言if条件：
        filter：
            {% if k1|f1 %}   # 函数的结果作为if语句的条件
                <h1>True</h1>
            {% else %}
                <h1>False</h1>
        simple_tag:  不支持模板语言if条件

自定义方法使用流程
^^^^^^^^^^^^^^^^^^

a、在app中创建templatetags目录,目录名必须为templatetags
b、在目录templatetags中创建一个.py文件，例如 s1.py c、html模板顶部通过{%
load s1 %}导入py文件 d、settings.py中注册app

.. code:: python

    #!/usr/bin/env python
    # -*- coding: utf-8 -*-

    from django import template

    register = template.Library()   # 这一句必须这样写


    @register.filter
    def f1(value):
        return value + "666"


    @register.filter
    def f2(value, arg):
        return value + "666" + arg


    @register.simple_tag
    def f3(value, s1, s2, s3, s4):
        return value + "666" + s1 + s2 + s3 + s4

.. code:: html

    {% raw %}
    {% load s1 %}
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>

        <h1>{{ title }}</h1>

        {#  使用filter方式调用自定义方法  #}
        <!-- 将k1当做参数传递给f1函数进行处理    处理方式 f1(k1) -->
        <p>{{ k1|f1 }}</p>
        <!-- 将k1当做参数传递给f2函数进行处理,接受2个参数  处理方式 f2(k1, "xxx") -->
        <p>{{ k1|f2:"xxx" }}</p>

        {#  使用simple_tag方式调用自定义方法  #}
        <!-- 将k1当做参数传递给f3函数进行处理,接收多个参数  处理方式 f3(k1, "s1", "s2", "s3", "s4") -->
        <p>{% f3 k1 "s1" "s2" "s3" "s4" %}</p>
    </body>
    </html>
    {% endraw %}
