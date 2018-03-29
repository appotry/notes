# Tutorial 2: Requests and Responses

从这节开始, 我们会接触到 `REST` 框架的核心. 让我们介绍一些基本构建组件.

## Request 对象

`REST framework` 引入了一个 `Request` 对象, 它扩展了常规的 `HttpRequest`,  并提供了灵活的请求解析. `Request` 对象的核心功能是 `request.data` 属性, 它和 `request.POST` 属性很相似, 但是它对 `Web APIs` 更加有用.

```python
request.POST  # 只处理表单数据. 仅用于 'POST' 方法.
request.data  # 处理任意数据. 可以用于 'POST', 'PUT' and 'PATCH' 方法.
```

## Response 对象

`REST framework` 也引入了 `Response` 对象, 它是一类用为渲染和使用内容协商来决定返回给客户端的正确内容类型的  `TemplateResponse`.

```python
return Response(data)  # Renders to content type as requested by the client.
```

## Status codes

在你的视图中使用数字HTTP状态码并不总是易读的, 错误代码也容易被忽略. `REST framework` 为每个状态码提供更明确的标识符, 例如 状态模块中的 `HTTP_400_BAD_REQUEST` . 使用这种标识符代替纯数字标识符是一个不错的主意.

## 装饰 API 视图

`REST framework` 提供两个装饰器.

- `@api_view` 装饰器用在基于视图的方法.
- `APIView` 类用于基于类的视图上.

这些装饰器提供一些功能. 例如确保从你的视图中获取 `Request` 对象, 例如在 `Response` 对象中添加上下文.

同时还提供一些行为, 例如在合适的时候返回 `405 Method Not Allowed` 响应, 例如处理在访问错误输入的 `request.data` 时出现的 `ParseError` 异常.

## 协同工作

Okay, 让我们使用这些新的组件去一些视图.

在 `views.py` 中不再需要 `JSONResponse` 类, 现在删除他们, 然后轻微地重构我们的视图

```python
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from snippets.models import Snippet
from snippets.serializers import SnippetSerializer


@api_view(['GET', 'POST'])
def snippet_list(request):
    """
    List all code snippets, or create a new snippet.
    """
    if request.method == 'GET':
        snippets = Snippet.objects.all()
        serializer = SnippetSerializer(snippets, many=True)
        return Response(serializer.data)

    elif request.method == 'POST':
        serializer = SnippetSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

```

我们的实例视图是前面的修改版, 更简洁, 和我们使用的 `Form API` 很相似, 同时使用了命名状态码, 让响应代码意义更明显.

`views.py` 中独立 `snippet` 的视图:

```python
@api_view(['GET', 'PUT', 'DELETE'])
def snippet_detail(request, pk):
    """
    Retrieve, update or delete a code snippet.
    """
    try:
        snippet = Snippet.objects.get(pk=pk)
    except Snippet.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = SnippetSerializer(snippet)
        return Response(serializer.data)

    elif request.method == 'PUT':
        serializer = SnippetSerializer(snippet, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        snippet.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
```

这对我们来说应该非常熟悉, 跟常规的Django视图没什么区别.

注意, 我们不再明确指定请求或响应的上下文类型. `request.data` 可以处理的 `json` 格式的请求, 同样也可以处理其他格式. 同样的, 我们允许 `REST` 框架将响应对象的数据渲染成正确的内容类型返回给客户端.

## 在URLs后添加可选的格式后缀

我们的响应不再是单一的内容格式, 根据这个事实, 我们可以在API尾部添加格式后缀, 格式后缀给我们一个参考的格式, 这意味着我们的API可以处理 `http://example.com/api/items/4.json.` 这样的URLs.

在视图中添加一个 `format` 关键字参数, 像这样

```python
def snippet_list(request, format=None):
```

和

```python
def snippet_detail(request, pk, format=None):
```

现在更新 `snippets/urls.py` 文件, 在已经存在的URL中添加一个 `format_suffix_patterns` 集合.

```python
from django.conf.urls import url
from rest_framework.urlpatterns import format_suffix_patterns
from snippets import views

urlpatterns = [
    url(r'^snippets/$', views.snippet_list),
    url(r'^snippets/(?P<pk>[0-9]+)$', views.snippet_detail),
]

urlpatterns = format_suffix_patterns(urlpatterns)
```

我们不必添加额外的URL模式, 但是它给我们一个简单, 清楚的方式指定特定的格式.

## 测试

继续像 `tutorial part 1` 中一样, 通过命令行测试 API, 一切都相当类似, 同时我们可以很好地处无效请求产生的错误.

我们可以像之前一样, 获得 `snippets` 列表

```shell
http http://127.0.0.1:8000/snippets/

HTTP/1.1 200 OK
...
[
  {
    "id": 1,
    "title": "",
    "code": "foo = \"bar\"\n",
    "linenos": false,
    "language": "python",
    "style": "friendly"
  },
  {
    "id": 2,
    "title": "",
    "code": "print \"hello, world\"\n",
    "linenos": false,
    "language": "python",
    "style": "friendly"
  }
]
```

我们可以通过使用 `Accept` 响应头控制返回的响应的格式.

```shell
http http://127.0.0.1:8000/snippets/ Accept:application/json  # Request JSON
http http://127.0.0.1:8000/snippets/ Accept:text/html         # Request HTML
```

或者在URL后添加格式后缀：

```shell
http http://127.0.0.1:8000/snippets.json  # JSON 后缀
http http://127.0.0.1:8000/snippets.api   # 可浏览的 API 后缀
```

同样的, 我们可以使用 `Content-Type` 头控制我们请求的格式.

```shell
# POST using form data
http --form POST http://127.0.0.1:8000/snippets/ code="print 123"

{
  "id": 3,
  "title": "",
  "code": "print 123",
  "linenos": false,
  "language": "python",
  "style": "friendly"
}

# POST using JSON
http --json POST http://127.0.0.1:8000/snippets/ code="print 456"

{
    "id": 4,
    "title": "",
    "code": "print 456",
    "linenos": false,
    "language": "python",
    "style": "friendly"
}
```

如果你使用 `--debug` 参数, 你可以看到请求头中的请求类型.

使用浏览器打开 [http://127.0.0.1:8000/snippets/](http://127.0.0.1:8000/snippets/).

## Browsability

Because the API chooses the content type of the response based on the client request, it will, by default, return an HTML-formatted representation of the resource when that resource is requested by a web browser. This allows for the API to return a fully web-browsable HTML representation.

Having a web-browsable API is a huge usability win, and makes developing and using your API much easier. It also dramatically lowers the barrier-to-entry for other developers wanting to inspect and work with your API.

See the [browsable api](http://www.django-rest-framework.org/topics/browsable-api/) topic for more information about the browsable API feature and how to customize it.

## What's next

In tutorial part 3, we'll start using class-based views, and see how generic views reduce the amount of code we need to write.
