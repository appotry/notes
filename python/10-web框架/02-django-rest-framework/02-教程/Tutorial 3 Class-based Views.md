# Tutorial 3: Class-based Views

我们也可以使用基于类的视图编写我们的 `API`, 如我们所见, 这是一个有利的模式, 允许我们重用共同的功能, 使我们的代码[不重复](https://en.wikipedia.org/wiki/Don't_repeat_yourself)

## 使用基于类的视图重新我们的API

重构 `views.py`

```python
from snippets.models import Snippet
from snippets.serializers import SnippetSerializer
from django.http import Http404
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status


class SnippetList(APIView):
    """
    List all snippets, or create a new snippet.
    """
    def get(self, request, format=None):
        snippets = Snippet.objects.all()
        serializer = SnippetSerializer(snippets, many=True)
        return Response(serializer.data)

    def post(self, request, format=None):
        serializer = SnippetSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
```

到目前为止, 一起都好. 它和之前的情况非常类似, 但我们可以更好的区分不同的 HTTP 方法, 我们需要继续更新 `views.py` 中的实例视图.

```python
class SnippetDetail(APIView):
    """
    Retrieve, update or delete a snippet instance.
    """
    def get_object(self, pk):
        try:
            return Snippet.objects.get(pk=pk)
        except Snippet.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        snippet = self.get_object(pk)
        serializer = SnippetSerializer(snippet)
        return Response(serializer.data)

    def put(self, request, pk, format=None):
        snippet = self.get_object(pk)
        serializer = SnippetSerializer(snippet, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk, format=None):
        snippet = self.get_object(pk)
        snippet.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
```

同时, 我们需要用基于类的视图的方式, 重构 `snippets/urls.py`.

```python
from django.conf.urls import url
from rest_framework.urlpatterns import format_suffix_patterns
from snippets import views

urlpatterns = [
    url(r'^snippets/$', views.SnippetList.as_view()),
    url(r'^snippets/(?P<pk>[0-9]+)/$', views.SnippetDetail.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)
```

Okay, 重构完成, 再运行开发服务器, 一切都和之前一样正常工作.

## 使用 mixins

使用基于类的视图的最大的好处就是, 允许我们快速的创建可复用的行为.

我们一直使用的 `create/retrieve/update/delete` 操作和我们创建的任何后端模型 API 很相似. 这些普遍的共同行为在 `REST` 框架的 `mixin` 类中实现.

让我们看看如何使用 `mixin` 类编写 `views.py` 模块.

```python
from snippets.models import Snippet
from snippets.serializers import SnippetSerializer
from rest_framework import mixins
from rest_framework import generics

class SnippetList(mixins.ListModelMixin,
                  mixins.CreateModelMixin,
                  generics.GenericAPIView):
    queryset = Snippet.objects.all()
    serializer_class = SnippetSerializer

    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)
```

我们话一些时间测试这里发生了什么, 我们使用 `GenericAPIView` 创建我们的视图, 同时加入 `ListModelMixin` 和 `CreateModelMixin`.

基础类提供核心功能, `mixin` 类提供 `.list()` 和 `.create()` 动作. 然后我们绑定 `get` 和 `post` 方法到合适的动作, 到目前为止, 已经变得足够简单.

```python
class SnippetDetail(mixins.RetrieveModelMixin,
                    mixins.UpdateModelMixin,
                    mixins.DestroyModelMixin,
                    generics.GenericAPIView):
    queryset = Snippet.objects.all()
    serializer_class = SnippetSerializer

    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)

    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)

    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)
```

相似地. 我们使用 `GenericAPIView` 类提供核心功能, 添加  `mixins` 提供 `.retrieve()`, `.update()` and `.destroy()` 动作.

## 使用基于视图的一般类

我们使用 `mixin` 类使用比之前较少的代码编写视图, 但我们可以更进一步. `REST` 框架提供一个已经混入一般视图的集合, 我们可以用他们进一步缩减 `views.py` 模块.

```python
from snippets.models import Snippet
from snippets.serializers import SnippetSerializer
from rest_framework import generics


class SnippetList(generics.ListCreateAPIView):
    queryset = Snippet.objects.all()
    serializer_class = SnippetSerializer


class SnippetDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Snippet.objects.all()
    serializer_class = SnippetSerializer
```

Wow, 我们的代码看起来如此简介, 如此的Django

接下来我们学习 `part 4 of the tutorial`, 我们将学到如何为我们的 `API` 处理授权(`authentication`)和权限(`permissions`)
