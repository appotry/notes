# Tutorial 4: Authentication & Permissions

当前, 我们的 `API` 没有限制, 谁都可以编辑或删除 `snippets`. 我们需要一些更高级的行为来确保:

- 代码片段总是与创建者联系在一起
- 只有授权用户才能创建 `snippets`
- 只有 `snippet` 创建者可以更新或者删除它
- 未授权的请求只有只读权限.

## 添加信息到模型中

我们需要对我们的 `Snippet` 模型类做一些修改. 首先, 添加两个字段, 一个用来代表代码片段的创建者, 另一个用来储存高亮显示的HTML代码.

修改 `models.py` 添加字段到 `Snippet` 模型中.

```python
owner = models.ForeignKey('auth.User', related_name='snippets', on_delete=models.CASCADE)
highlighted = models.TextField()
```

同时, 我们需要确保, 模型在保存的时候, 使用 `pygments` 代码高亮库填充 `highlighted` 字段.

我们需要额外导入:

```python
from pygments.lexers import get_lexer_by_name
from pygments.formatters.html import HtmlFormatter
from pygments import highlight
```

添加 `.save()` 方法到模型类

```python
def save(self, *args, **kwargs):
    """
    Use the `pygments` library to create a highlighted HTML
    representation of the code snippet.
    """
    lexer = get_lexer_by_name(self.language)
    linenos = self.linenos and 'table' or False
    options = self.title and {'title': self.title} or {}
    formatter = HtmlFormatter(style=self.style, linenos=linenos,
                              full=True, **options)
    self.highlighted = highlight(self.code, lexer, formatter)
    super(Snippet, self).save(*args, **kwargs)
```

当我们完成这些, 我们需要更新我们的数据库表结构, 正常情况下, 我们创建数据库迁移(database migration), 但是在本教程中, 我们只需要删除原来的数据库, 重新创建.

```python
rm -f db.sqlite3
rm -r snippets/migrations
python manage.py makemigrations snippets
python manage.py migrate
```

你需要创建一些不同的用户, 用来测试 API, 最快的方式是使用 `createsuperuser` 命令

```python
python manage.py createsuperuser
```

## 为我们的用户模型添加端点

现在我们已经创建了一些用户, 我们最好将用户添加到我们的 API, 我们很容易创建一个新的序列. 在 `serializers.py` 文件中添加:

```python
from django.contrib.auth.models import User

class UserSerializer(serializers.ModelSerializer):
    snippets = serializers.PrimaryKeyRelatedField(many=True, queryset=Snippet.objects.all())

    class Meta:
        model = User
        fields = ('id', 'username', 'snippets')
```

因为在用户模型中 `snippets` 是一个相反的关系, 使用 `ModelSerializer` 类, 默认不会包含它, 所以我们需要手动为用户序列添加这个字段.

我们还需要添加两个视图到 `views.py` 中. 我们为用户添加只读视图, 因此我们使用基于视图的一般类 `ListAPIView` 和 `RetrieveAPIView`.

```python
from django.contrib.auth.models import User


class UserList(generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class UserDetail(generics.RetrieveAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
```

确保导入了 `UserSerializer` 类

```python
from snippets.serializers import UserSerializer
```

最后, 我们需要修改 `URL` 配置, 添加这些视图到 `API` 中, 添加一下内容到 `urls.py` 中.

```python
url(r'^users/$', views.UserList.as_view()),
url(r'^users/(?P<pk>[0-9]+)/$', views.UserDetail.as_view()),
```

## 将用户和 Snippets 联系起来

现在, 如果我们创建一个代码片段, 我们没法将用户和创建的 `snippet` 实例联系起来. 虽然用户不是序列表示的部分, 但是代表传入请求的一个属性

我们通过重写 `snippet` 视图的 `.perform_create()` 方法来处理这个问题. 它允许我们修改如何保存实例, 处理任何请求对象的信息或者请求链接的信息.

在 `SnippetList` 视图类下添加如下方法

```python
def perform_create(self, serializer):
    serializer.save(owner=self.request.user)
```

现在, 我们序列的 `create()` 方法将会传入一个有效请求数据的 `owner` 字段

## 更新我们的序列

现在, `snippets` 和创建他们的用户已经建立了联系, 更新我们的 `SnippetSerializer` 来表示用户. 在 `serializers.py` 的序列定义中添加一下字段:

```python
owner = serializers.ReadOnlyField(source='owner.username')
```

同时, **确保将 `'owner'` 添加到 `Meta` 类的字段中**.

这个字段会做一些有趣的事情. `source` 参数控制哪个属性被用作于一个字段, 并可以指向 `serialized` 实例的任何属性. 它也能像上面一样使用点标记(`.`), 这种情况下它会横贯给定的所有属性, 就像我们使用django模板语言一样.

我们添加的字段是无类型的 `ReadOnlyField` 类, 与其他类型的字段, 例如 `CharField`, `BooleanField` 等等...相比, 无类型的 `ReadOnlyField` 总是只读的, 用于序列化表示, 但不能用于数据反序列化的时候用来更新模型实例. 这里我们也可以使用 `CharField(read_only=True)`.

## 为视图添加依赖的权限

现在,用户已经和代码片段联系起来, 我们需要确保, 只有授权的用户可以创建, 更新, 删除代码片段

`REST` 框架包含许多权限类, 可以用来实现视图的访问权限. 这种情况下, 我们需要 `IsAuthenticatedOrReadOnly` 来确保授权请求获得读写权限, 未经授权的请求只有只读权限.

首先, 在视图模块中引入如下代码:

```python
from rest_framework import permissions
```

然后在 `SnippetList` 和 `SnippetDetail` 视图类中添加如下属性.

```python
permission_classes = (permissions.IsAuthenticatedOrReadOnly,)
```

## 在可浏览API中添加登录

如果你打开浏览器操控可浏览的API, 你将不再有创建新的代码片段的权限. 为此, 我们需要以用户身份登录.

我们添加一个登录视图, 编辑项目级别的 `URLconf`: `urls.py` 文件

添加导入语句

```python
from django.conf.urls import include
```

文件末尾, 添加一个包含登录和登出视图的url样式

```python
urlpatterns += [
    url(r'^api-auth/', include('rest_framework.urls')),
]
```

`r'^api-auth/'` 可以使用你想要的URL

现在, 如果再次打开浏览器, 刷新页面, 你将可以看到一个 `Login` 链接在页面的右上角. 现在可以使用已经创建的用户登录, 创建代码片段.

一旦您创建了一些代码片段, 访问 '/users/' 端点, 你会注意到在每个用户的 `snippets` 字段, 会显示跟用户有关的 `snippets` id.

## 对象级别权限

虽然我们想让所有人看到代码片段, 但同时也要确保只有创建代码片段的用户可以更新或删除它.

我们需要创建自定义权限.

在 `snippets` 应用中, 创建一个新的文件, `permissions.py`

```python
from rest_framework import permissions


class IsOwnerOrReadOnly(permissions.BasePermission):
    """
    Custom permission to only allow owners of an object to edit it.
    """

    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True

        # Write permissions are only allowed to the owner of the snippet.
        return obj.owner == request.user
```

现在, 通过编辑 `SnippetDetail` 视图类中的 `permission_classes` 属性, 我们可以添加自定义权限到我们的 `snippet` 实例端点

```python
permission_classes = (permissions.IsAuthenticatedOrReadOnly,
                      IsOwnerOrReadOnly,)
```

确保导入 `IsOwnerOrReadOnly` 类.

```python
from snippets.permissions import IsOwnerOrReadOnly
```

现在, 如果你再次使用浏览器, 你会发现只有你登录与创建代码片段一致的用户, 你才有权限使用 `'DELETE'` and `'PUT'` 动作.

## 验证 API

由于现在 API 有权限集合, 在我们需要编辑任何 `snippets` 的时候, 需要认证我们的请求, 我们没有设置其他任何认证类([authentication classes](http://www.django-rest-framework.org/api-guide/authentication/)), 默认情况下只有 `SessionAuthentication` 和 `BasicAuthentication`.

当我们通过浏览器进行交互时, 我们可以登录, 浏览器会话(session)将为请求提供认证.

如果我们以编程的方式使用 API, 我们需要为每个请求提供明确的 `认证凭证`.

如果我们尝试在没有认证的情况下创建 `snippet`, 我们会获得一个 error.

```python
http POST http://127.0.0.1:8000/snippets/ code="print 123"

{
    "detail": "Authentication credentials were not provided."
}
```

我们可以通过提供之前创建的用户的用户名和密码, 来创建 `snippet`

```python
http -a admin:password123 POST http://127.0.0.1:8000/snippets/ code="print 789"

{
    "id": 1,
    "owner": "admin",
    "title": "foo",
    "code": "print 789",
    "linenos": false,
    "language": "python",
    "style": "friendly"
}
```

## 概要

我们的 `API` 已经具有一个相当精细的权限集合, 同时为系统用户和他们创建的 `snippets` 提供了端点.

在教程的第5部分, 我们将介绍如何为高亮的 `snippets` 创建一个HTML端点, 将所有内容联系起来. 同时为系统中的关系使用超链接提高我们 `API` 的凝聚力.
