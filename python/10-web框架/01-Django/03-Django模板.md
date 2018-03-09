# Django模板

模板是一个文本,用于分离文档的表现形式和内容,模板定义了占位符以及各种用于规范文档该如何显示的各部分基本逻辑(模板标签).模板通常用于产生HTML,但是Django的模板也能产生任何给予文本格式的文档.

## 如何使用模板系统

在Python代码中使用Django模板的最基本方式如下:

1. 可以用原始的模板代码字符串创建一个`Template`对象,Django同样支持用指定模板文件路径的方式来创建`Template`对象;
2. 调用模板对象的`render`方法,并且传入一套变量`context`.它将返回一个基于模板的展现字符串,模板中的变量和标签会被`context`值替代

## 模板渲染

一旦你创建一个`Template`对象,你可以用`context`来传递数据给它.一个context是一系列变量和它们值得集合.

`context`在Django里表现为`Context`类,在`django.template`模块里,她的构造函数带有一个可选的参数: 一个字典映射变量和它们的值.调用`Template`对象的`render()`方法并传递`context`来填充模板

```python
>>> from django.template import Context, Template
>>> t = Template('My name is {{ name }}.')
>>> c = Context({'name': 'xxx'})
>>> t.render(c)
'My name is xxx.'
```

这就是Django模板系统的基本规则: 写模板,创建 `Template` 对象,创建 `Context` ,调用 `render()` 方法.

## 深度变量的查找

```python
>>> from django.template import Template,Context
>>> t = Template('{{ person.name }} is {{ person.age }} years old.')
>>> c = Context({'person': person})
>>> t.render(c)
'xxx is 43 years old.'
```

句点可以用来引用对象的 `方法` . 例如,每个Python字符串都有 `upper()` 和 `isdigit()` 方法,你在模板中可以使用同样的句点语法来调用它们

```python
>>> from django.template import Template,Context
>>> t = Template('{{ var }} upper: {{ var.upper }} isdigit: {{ var.isdigit }}')
>>> t.render(Context({'var': '123'}))
'123 upper: 123 isdigit: True'
>>> t.render(Context({'var': 'hello'}))
'hello upper: HELLO isdigit: False'
```

句点也可以用与访问列表索引,例如:

```python
>>> from django.template import Template,Context
>>> t = Template('Item 2 is {{ items.2 }}.')
>>> c = Context({'items': ['apple','bananas','carrote']})
>>> t.render(c)
'Item 2 is carrote.'
>>>
```

当模板系统在变量名中遇到点时，按照以下顺序尝试进行查找：

1. 字典类型查找(比如 `foo["bar"]` )
2. 属性查找(比如 `foo.bar` )
3. 方法调用(比如 `foo.bar()` )
4. 列表类型索引查找(比如 `foo[bar]` )

## jinja模板

...

## 在视图中使用模板

```python
# 首先你要导入os模块
'DIRS': [os.path.join(BASE_DIR, 'templates')],
```

### 加载模板

```jinja2
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
```

### render_to_response()

```python
from django.shortcuts import render_to_response

# def current_datetime(request):
#     now = datetime.datetime.now()
#     return render_to_response('current_datetime.html',{'current_datetime': now})
```

### locals()技巧

很多时候，就像在这个范例中那样，你发现自己一直在计算某个变量，保存结果到变量中（比如前面代码中的now），然后将这些变量发送给模板。尤其喜欢偷懒的程序员应该注意到了，不断地为临时变量和临时模板命名有那么一点点多余。不仅多余，而且需要额外的输入。

如果你是个喜欢偷懒的程序员并想让代码看起来更加简明，可以利用 Python 的内建函数`locals()`。它返回的字典对所有局部变量的名称与值进行映射。因此，前面的视图可以重写成下面这个样子

```python
def current_datetime(request):
    current_datetime = datetime.datetime.now()
    return render_to_response('current_datetime.html',locals())
```

在此，我们没有像之前那样手工指定`context`字典，而是传入了`locals()`的值，它囊括了函数执行到该时间点时所定义的一切变量。因此，我们将`now`变量重命名为`current_date`，因为那才是模板所预期的变量名称。在本例中，`locals()`并没有带来多大的改进，但是如果有多个模板变量要界定而你又想偷懒，这种技术可以减少一些键盘输入。

使用`locals()`时要注意是它将包括所有的局部变量，它们可能比你想让模板访问的要多。在前例中，`locals()`还包含了`request`。对此如何取舍取决你的应用程序。