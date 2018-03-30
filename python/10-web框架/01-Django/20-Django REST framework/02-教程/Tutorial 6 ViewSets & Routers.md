# Tutorial 6: ViewSets & Routers

`REST` 框架包含一个处理 `ViewSets` 的抽象, 它可以让开发者将精力集中在构建API的状态和交互上, 同时帮助开发者, 基于共同约定, 自动处理 URL 构建.

`ViewSet` 类几乎和 `View` 类一样, 除了它提供的 `read` 或者 `update` 操作, 而不是像 `get` 或 `put` 一样的方法.

一个 `ViewSet` 类在它被实例化成一个视图集合的最后时刻, 通过一个处理复杂 URL 配置的 `Router` 类绑定一个方法集合, 且只绑定一个.

## 使用 ViewSets 重构

首先使用单个 `UserViewSet` 视图重构 `UserList` 和 `UserDetail` 视图.

```python
from rest_framework import viewsets

class UserViewSet(viewsets.ReadOnlyModelViewSet):
    """
    This viewset automatically provides `list` and `detail` actions.
    """
    queryset = User.objects.all()
    serializer_class = UserSerializer
```

这里我们使用 `ReadOnlyModelViewSet` 类自动提供默认的 `'read-only'` 操作. 我们需要像使用常规视图一样, 设置 `queryset` 和 `serializer_class` 属性, 但是我们不再需要为两个分开的类提供相同的信息.

接下来替换 `SnippetList`, `SnippetDetail` and `SnippetHighlight` 视图类.

```python
from rest_framework.decorators import detail_route
from rest_framework.response import Response

class SnippetViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.

    Additionally we also provide an extra `highlight` action.
    """
    queryset = Snippet.objects.all()
    serializer_class = SnippetSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,
                          IsOwnerOrReadOnly,)

    @detail_route(renderer_classes=[renderers.StaticHTMLRenderer])
    def highlight(self, request, *args, **kwargs):
        snippet = self.get_object()
        return Response(snippet.highlighted)

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)
```

这一次我们使用了 `ModelViewSet` 类获得默认的完整的读写操作.

注意, 我们同时使用了 `@detail_route` 装饰器, 用于创建一个自定义动作, 即 `highlight`. 这个装饰器可以用于添加任何不适合 `create/update/delete` 方式的自定义端点.

使用 `@detail_route` 装饰器自定义的动作默认会响应 `GET` 请求. 如果我们需要动作响应 `POST` 请求, 我们可以使用 `methods` 参数.

自定义动作的默认 `URLs` 取决于它们的名字. 如果你想改变url构建方法, 你可以在使用装饰器的时候传入 `url_path` 关键字参数.

## 明确绑定 ViewSets 到 URLs

处理方法, 只会按照我们的 URL 配置对相应方法进行绑定. 我们为我们的 ViewSets 显示地创建一个视图集合, 来看看发生了什么.

`snippets/urls.py` 文件, 我们绑定我们的 `ViewSet` 类到一组具体的视图.

```python
from snippets.views import SnippetViewSet, UserViewSet, api_root
from rest_framework import renderers

snippet_list = SnippetViewSet.as_view({
    'get': 'list',
    'post': 'create'
})
snippet_detail = SnippetViewSet.as_view({
    'get': 'retrieve',
    'put': 'update',
    'patch': 'partial_update',
    'delete': 'destroy'
})
snippet_highlight = SnippetViewSet.as_view({
    'get': 'highlight'
}, renderer_classes=[renderers.StaticHTMLRenderer])
user_list = UserViewSet.as_view({
    'get': 'list'
})
user_detail = UserViewSet.as_view({
    'get': 'retrieve'
})
```

注意我们如何从每个 `ViewSet` 类, 通过绑定http方法到响应的动作来创建多个视图.

现在, 我们将我们的资源绑定到了具体的视图, 我们可以像往常一样将我们的视图注册到url配置中

```python
urlpatterns = format_suffix_patterns([
    url(r'^$', api_root),
    url(r'^snippets/$', snippet_list, name='snippet-list'),
    url(r'^snippets/(?P<pk>[0-9]+)/$', snippet_detail, name='snippet-detail'),
    url(r'^snippets/(?P<pk>[0-9]+)/highlight/$', snippet_highlight, name='snippet-highlight'),
    url(r'^users/$', user_list, name='user-list'),
    url(r'^users/(?P<pk>[0-9]+)/$', user_detail, name='user-detail')
])
```

## 使用 Routers

因为我们使用 `ViewSet` 代替 `View`, 实际上我们不需要自己设计 URL 配置. 我们可以通过 `Router` 类, 将资源(`resources`), 视图(`views`), urls 自动联系起来. 我们只需要使用一个路由注册合适的视图集合.

重写 `snippets/urls.py`

```python
from django.conf.urls import url, include
from rest_framework.routers import DefaultRouter
from snippets import views

# Create a router and register our viewsets with it.
router = DefaultRouter()
router.register(r'snippets', views.SnippetViewSet)
router.register(r'users', views.UserViewSet)

# The API URLs are now determined automatically by the router.
urlpatterns = [
    url(r'^', include(router.urls))
]
```

使用 `router` 注册的视图集合提供一个 urlpattern. 包括两个参数 - 视图的URl前缀和视图集合本身.

我们使用的默认 `DefaultRouter` 类也会自动为我们创建 API 根视图. 现在我们可以从 `views` 模块中删除 `api_root` 方法

## 权衡使用 views 和 viewsets

`viewsets` 是一个非常有用的抽象. 它可以确保 `URL` 原型和你的 `API` 保持一致, 最大限度的减少代码量, 允许你将精力放在 API 的交互和表示上, 而不是放在编写 `URL conf` 上.

这并不意味在所有地方都要使用 `viewsets`. 在使用基于类的视图和基于函数的视图时, 需要进行权衡. 使用 `viewsets` 没有单独构建 `views` 明确.

在教程第7部分, 我们将介绍, 如何添加一个 `APP schema`, 并使用客户端库或命令行工具与我们的 `API` 进行交互.
