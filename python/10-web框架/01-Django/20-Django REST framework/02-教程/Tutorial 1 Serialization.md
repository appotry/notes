# Tutorial 1: Serialization

## 介绍

本教程将会通过一些简单的代码来实现 Web API. 这个过程将会介绍 `REST framework` 的各个组件, 带你深入理解各个组件是如何一起工作.

本教程需要花一些时间, 所以在开始之前, 你可以去准备一些饼干和你喜欢的啤酒. 如果你只是想快速浏览, 请直接查看 `快速浏览` 的文档.

> 本教程的代码在GitHub [tomchristie/rest-framework-tutorial](https://github.com/encode/rest-framework-tutorial) 中, 在 [https://restframework.herokuapp.com/](https://restframework.herokuapp.com/) 有一个沙箱版本用于测试, 它完整实现了该教程.

## 创建一个新环境

在做任何事情之前, 我们先使用 `virtualenv` 创建一个全新的虚拟环境. 这将确保我们的配置跟我们其他的项目完全隔离.

```shell
virtualenv env
source env/bin/activate
```

```shell
pip install django
pip install djangorestframework
pip install pygments  # We'll be using this for the code highlighting
```

> 注意: 退出虚拟环境, 只需要执行 `deactivate`. 更多信息查看 [virtualenv documentation](http://www.virtualenv.org/en/latest/index.html)

## 开始

首先, 创建一个新项目.

```shell
cd ~
django-admin.py startproject tutorial
cd tutorial
```

创建一个应用, 用于创建简单的 `Web API`

```shell
python manage.py startapp snippets
```

添加 `snippets` , `rest_framework` 应用到 `INSTALLED_APPS`. 编辑 `tutorial/settings.py`.

```python
INSTALLED_APPS = (
    ...
    'rest_framework',
    'snippets.apps.SnippetsConfig',
)
```

ok, 我们准备下一步

## 创建一个 model

为了实现本教程, 我们创建一个 `Snippet` 模型, 用于存储代码片段. 开始编辑 `snippets/models.py` 文件. 注意: 优秀的编程实践都会对代码进行注释. 本教程的代码仓库有详细的注释, 在这里我们忽略它, 关注代码本身.

```python
from django.db import models
from pygments.lexers import get_all_lexers
from pygments.styles import get_all_styles

LEXERS = [item for item in get_all_lexers() if item[1]]
LANGUAGE_CHOICES = sorted([(item[1][0], item[0]) for item in LEXERS])
STYLE_CHOICES = sorted((item, item) for item in get_all_styles())


class Snippet(models.Model):
    created = models.DateTimeField(auto_now_add=True)
    title = models.CharField(max_length=100, blank=True, default='')
    code = models.TextField()
    linenos = models.BooleanField(default=False)
    language = models.CharField(choices=LANGUAGE_CHOICES, default='python', max_length=100)
    style = models.CharField(choices=STYLE_CHOICES, default='friendly', max_length=100)

    class Meta:
        ordering = ('created',)

```

为 `snippet` 模型创建初始迁移, 并在第一次同步数据库

```shell
python manage.py makemigrations snippets
python manage.py migrate
```

## 创建一个序列化类(Serializer class)

The first thing we need to get started on our Web API is to provide a way of serializing and deserializing the snippet instances into representations such as json. We can do this by declaring serializers that work very similar to Django's forms. Create a file in the snippets directory named serializers.py and add the following.

```python
from rest_framework import serializers
from snippets.models import Snippet, LANGUAGE_CHOICES, STYLE_CHOICES


class SnippetSerializer(serializers.Serializer):
    id = serializers.IntegerField(read_only=True)
    title = serializers.CharField(required=False, allow_blank=True, max_length=100)
    code = serializers.CharField(style={'base_template': 'textarea.html'})
    linenos = serializers.BooleanField(required=False)
    language = serializers.ChoiceField(choices=LANGUAGE_CHOICES, default='python')
    style = serializers.ChoiceField(choices=STYLE_CHOICES, default='friendly')

    def create(self, validated_data):
        """
        Create and return a new `Snippet` instance, given the validated data.
        """
        return Snippet.objects.create(**validated_data)

    def update(self, instance, validated_data):
        """
        Update and return an existing `Snippet` instance, given the validated data.
        """
        instance.title = validated_data.get('title', instance.title)
        instance.code = validated_data.get('code', instance.code)
        instance.linenos = validated_data.get('linenos', instance.linenos)
        instance.language = validated_data.get('language', instance.language)
        instance.style = validated_data.get('style', instance.style)
        instance.save()
        return instance
```

The first part of the serializer class defines the fields that get serialized/deserialized. The create() and update() methods define how fully fledged instances are created or modified when calling serializer.save()

A serializer class is very similar to a Django Form class, and includes similar validation flags on the various fields, such as required, max_length and default.

The field flags can also control how the serializer should be displayed in certain circumstances, such as when rendering to HTML. The {'base_template': 'textarea.html'} flag above is equivalent to using widget=widgets.Textarea on a Django Form class. This is particularly useful for controlling how the browsable API should be displayed, as we'll see later in the tutorial.

We can actually also save ourselves some time by using the ModelSerializer class, as we'll see later, but for now we'll keep our serializer definition explicit.

用序列化(Serializers)工作

在我们深入之前, 我们需要熟练使用新的序列化类(Serializer class). 让我们进入Django命令行

```shell
python manage.py shell
```

导入相关依赖, 并创建一堆代码片段

```python
from snippets.models import Snippet
from snippets.serializers import SnippetSerializer
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser

snippet = Snippet(code='foo = "bar"\n')
snippet.save()

snippet = Snippet(code='print "hello, world"\n')
snippet.save()
```

我们已经有了一些 `snippet` 实例, 让我们看看如何将其中一个实例序列化

> 注: Model -> Serializer

```python
serializer = SnippetSerializer(snippet)
serializer.data
# {'style': 'friendly', 'code': u'print "hello, world"\n', 'language': 'python', 'title': u'', 'linenos': False, 'id': 2}
```

现在我们将模型实例(model instance)转化成Python原生数据类型. 为了完成实例化过程, 我们将数据渲染成 `json`.

> 注: Serializer -> JSON

```python
content = JSONRenderer().render(serializer.data)
content
# '{"id":2,"title":"","code":"print \\"hello, world\\"\\n","linenos":false,"language":"python","style":"friendly"}'
```

反序列化相似, 首先我们将流(stream)解析成Python原生数据类型...

```python
from django.utils.six import BytesIO

stream = BytesIO(content)
data = JSONParser().parse(stream)
```

...然后, 我们将Python原生数据恢复成正常的对象实例

> 注: json -> serializer

```python
serializer = SnippetSerializer(data=data)
serializer.is_valid()
# True
serializer.validated_data
# OrderedDict([(u'title', u''), (u'code', u'print "hello, world"'), (u'linenos', False), (u'language', 'python'), (u'style', 'friendly')])
serializer.save()
# <Snippet: Snippet object>
```

可以看到, API和表单很相似. 当我们用我们的序列(serializer)写视图的时候, 相似性会更明显.

除了将模型模型实例(model instance)序列化外, 我们也能序列化查询集(querysets), 只需要添加一个序列化参数 `many=True`

```python
serializer = SnippetSerializer(Snippet.objects.all(), many=True)
serializer.data
# [OrderedDict([('id', 1), ('title', u''), ('code', u'foo = "bar"\n'), ('linenos', False), ('language', 'python'), ('style', 'friendly')]), OrderedDict([('id', 2), ('title', u''), ('code', u'print "hello, world"\n'), ('linenos', False), ('language', 'python'), ('style', 'friendly')]), OrderedDict([('id', 3), ('title', u''), ('code', u'print "hello, world"'), ('linenos', False), ('language', 'python'), ('style', 'friendly')])]
```

## 使用模型序列化(ModelSerializers)

我们的 `SnippetSerializer` 类复制了包含 `Snippet` 模型在内的很多信息. 如果能够简化我们的代码, 那是极好的.

和Django提供的 `Form` 类和 `ModelFrom` 类相同, `REST` 框架包含了 `Serializer` 类和 `ModelSerializer` 类.

让我们使用 `ModelSerializer` 重构我们的Serializer,
再次打开 `snippets/serializers.py`, 重写 `SnippetSerializer` 类.

```python
class SnippetSerializer(serializers.ModelSerializer):
    class Meta:
        model = Snippet
        fields = ('id', 'title', 'code', 'linenos', 'language', 'style')
```

序列一个非常棒的属性就是, 你可以通过打印序列实例的结构(representation)查看它的所有字段. 输入 `python manage.py shell` 打开Django shell, 尝试如下代码:

```python
from snippets.serializers import SnippetSerializer
serializer = SnippetSerializer()

print(repr(serializer))
# SnippetSerializer():
#     id = IntegerField(label='ID', read_only=True)
#     title = CharField(allow_blank=True, max_length=100, required=False)
#     code = CharField(style={'base_template': 'textarea.html'})
#     linenos = BooleanField(required=False)
#     language = ChoiceField(choices=[('abap', 'ABAP'), ('abnf', 'ABNF'),...
#     style = ChoiceField(choices=[('abap', 'abap'), ('algol', 'algol'),...

```