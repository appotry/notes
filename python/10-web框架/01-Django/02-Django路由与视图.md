# Django路由与视图

路由说白了就是视图(函数)的对应关系,一个路由对应一个视图,如上面文章所提到的,当打开`/users/`路径的时候会让`users`这个函数来进行逻辑处理,把处理的结果再返回到前端

路由的配置文件入口在 `settings.py` 文件中已经定义.

```python
ROOT_URLCONF = 'yang.urls'
```

## 路由

### 路由的配置

#### 绝对地址访问

```python
# 访问地址必须是http://127.0.0.1:8000/hello/
url(r'^hello/$', views.hello),
```

#### 使用正则与分组

```python
# http://127.0.0.1:8000/detail-2-2.html
# url(r'^detail-(\d+)-(\d+).html', views.detail),
# 括号内匹配到的内容会当做参数传给detail函数
def detail(request, nid, uid):
    print(nid, uid)
    return HttpResponse(nid)

# 分组匹配
# url(r'^detail-(?P<uid>\d+)-(?P<nid>\d+).html', views.detail),
# 使用 *args, **kwargs 接受所有参数
def detail(request, *args, **kwargs):
    print(nid, uid)
    return HttpResponse(nid)
```

在函数内需要接受year,month,day参数

```python
url(r'^(?P<year>[0-9]{4})/(?P<month>[0-9]{2})/(?P<day>[0-9]{2})/$', views.date),
# 使用分组匹配就不用考虑视图函数的参数位置了
```

`date`视图必须接收以下参数

```python
def date(request, year, month, day):
```

访问地址为: [http://127.0.0.1:8000/2017/3/14/](http://127.0.0.1:8000/2017/3/14/)

#### 传值

    url(r'^(?P<year>[0-9]{4})/$', views.id, {'foo': 'bar'}),

`id`函数必须接受`year`和`foo`参数

#### 别名

对URL路由关系进行命名,以后可以通过此名字获取URL(通过别名获取URL,就算URL调整也不会影响之前所有的别名)

可用于前端的from表单验证,如下实例,URLs地址的时候,因为from表单提交的地址使用了别名,所以会自动替换

```python
    # urls.py
    from django.conf.urls import url
    from app01 import views
    urlpatterns = [
        url(r'^index/$', views.index, name='bieming'),
    ]

    # views.py
    from django.shortcuts import render,HttpResponse
    def index(request):
        if request.method=='POST':
            username=request.POST.get('username')
            password=request.POST.get('password')
            if username=='as' and password=='123':
                return HttpResponse("登陆成功")
        return render(request, 'index.html')

    # index.html
    <form action="{% url 'bieming' %}" method="post">
         用户名:<input type="text" name="username">
         密码:<input type="password" name="password">
         <input type="submit" value="submit">
    </form>
```

#### CBV

```python
url(r'^home/', views.Home.as_view()),
```

### 路由分发

include分发,有利于解耦

```python
# 当访问二级路由是cmdb的时候转发给app01.urls处理
url(r'^cmdb/$', include('app01.urls')),
```

#### 路由分发实例

可以使用`incloud`把很多个路由进行拆封,然后把不同的业务放到不同的urls中,首先我们创建项目及应用

```python
    # 创建DjangoProjects项目
    django-admin.py startproject DjangoProjects
    cd DjangoProjects
    # 在项目内创建app1和app2应用
    python3 manage.py startapp app1
    python3 manage.py startapp app2
```

项目的**urls.py**文件内容

```python
    # DjangoProjects/DjangoProjects/urls.py
    from django.conf.urls import url, include
    from django.contrib import admin
    urlpatterns = [
        # 当路由匹配到一级路径为app1时，就把这个URL交给app1.urls再次进行匹配
        url(r'^app1/', include('app1.urls')),
        url(r'^app2/', include('app2.urls')),
    ]
```

应用**urls.py**和**view.py**文件内容

```python
    # DjangoProjects/app1/urls.py
    from django.conf.urls import url,include
    from django.contrib import admin
    from app1 import views
    urlpatterns = [
        url(r'^hello/$', views.hello),
    ]
    # DjangoProjects/app1/views.py
    from django.shortcuts import render,HttpResponse
    def hello(request):
        return HttpResponse("Hello App1")
    # DjangoProjects/app2/urls.py
    from django.conf.urls import url
    from django.contrib import admin
    from app2 import views
    urlpatterns = [
        url(r'^hello/$', views.hello),
    ]
    # DjangoProjects/app2/views.py
    from django.shortcuts import render,HttpResponse
    def hello(request):
        return HttpResponse("Hello App2")
```

1. 当访问 [http://127.0.0.1:8000/app1/hello/](http://127.0.0.1:8000/app1/hello/) 时返回内容 `Hello App1`
2. 当访问 [http://127.0.0.1:8000/app2/hello/](http://127.0.0.1:8000/app2/hello/) 时返回内容 `Hello App2`

## 视图

### FBV & CBV

Django两者都支持

- function base view
- class base view

### 请求与响应

http请求: **HttpRequest对象**

http响应: **HttpResponse对象**

HttpRequest对象属性

| 属性                      | 描述            |
| ---------------------- | ------------ |
| request.path            | 请求页面的路径,不包括域名 |
| request.path_info       | 可用于跳转到当前页面    |
| request.get_full_path() | 获取带参数的路径      |
| request.method          | 页面的请求方式       |
| request.GET             | GET请求方式的数据    |
| request.POST            | POST请求方式的数据   |

HttpResponse对象属性

| 属性                                | 描述         |
| --------------------------------- | ---------- |
| render(request, 'index.html')     | 返回一个模板页面   |
| render_to_response( 'index.html') | 返回一个模板页面   |
| redirect('/login')                | 页面跳转       |
| HttpResponseRedirect('/login')    | 页面跳转       |
| HttpResponse('yang')              | 给页面返回一个字符串 |

## 简单实例

### 创建项目

```shell
➜  django_xxx git:(master) ✗ django-admin startproject mysite
➜  django_xxx git:(master) ✗ cd mysite
➜  mysite git:(master) ✗ tree
.
├── manage.py
└── mysite
    ├── __init__.py
    ├── settings.py
    ├── urls.py
    └── wsgi.py

1 directory, 5 files
```

### 创建app

新建app,名称为learn,会自动生成一个learn目录

```shell
➜  mysite git:(master) ✗ python3 manage.py startapp learn
➜  mysite git:(master) ✗ tree
.
├── learn
│   ├── __init__.py
│   ├── admin.py
│   ├── apps.py    # Django 1.9.x 以上会在Django 1.8基础上多出此文件
│   ├── migrations # Django 1.8.x 以上会生成此目录
│   │   └── __init__.py
│   ├── models.py
│   ├── tests.py
│   └── views.py
├── manage.py
└── mysite
    ├── __init__.py
    ├── __pycache__
    │   ├── __init__.cpython-35.pyc
    │   └── settings.cpython-35.pyc
    ├── settings.py
    ├── urls.py
    └── wsgi.py

4 directories, 14 files
```

### 将新定义的app添加到settings.py中的INSTALL_APPS中

```shell
➜  mysite git:(master) ✗ ls
learn     manage.py mysite
➜  mysite git:(master) ✗ vim mysite/settings.py

# 修改内容如下

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'learn',
]
```

### 定义视图函数

```shell
➜  mysite git:(master) ✗ vim learn/views.py

from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse

def index(request):
    return HttpResponse('Hello World')
```

### 定义视图函数相关的url

即规定 访问什么网址对应什么内容

Django 1.8.x以后,官方要求以如下方式导入,再使用

```shell
from learn.views import index   # 导入

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^$', index),   # 使用index
]
```

### 运行

    python manage.py runserver

打开 `http://127.0.0.1:8000/` 即可看到效果,页面会显示 `Hello World`

如需修改监听IP,及端口

    python manage.py runserver 0.0.0.0:8000

## 视图及url进阶

通过url传值,做加减法

### /add?a=4&b=5

url 通过 `/add?a=4&b=5`方式传值

```shell
➜  mysite git:(master) ✗ ls
db.sqlite3 learn      manage.py  mysite
➜  mysite git:(master) ✗ python3 manage.py startapp calc

➜  mysite git:(master) ✗ tree calc
calc
├── __init__.py
├── admin.py
├── apps.py
├── migrations
│   └── __init__.py
├── models.py
├── tests.py
└── views.py

1 directory, 7 files
```

将 `calc` 这个app加入到 `mysite/settings.py`

```shell
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    ...
    'calc',
]
```

修改 `calc/views.py`

    ➜  mysite git:(master) ✗ vim calc/views.py

```shell
from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse

def add(request):
    a = request.GET['a']
    b = request.GET['b']
    c = int(a) + int(b)
    return HttpResponse(str(c))
```

**request.GET 类似于一个字典，更好的办法是用 request.GET.get('a', 0) 当没有传递 a 的时候默认 a 为 0**

修改 mysite/urls.py

    ➜  mysite git:(master) ✗ vim mysite/urls.py

```shell
from django.conf.urls import url
from django.contrib import admin
from learn.views import index
from calc.views import add

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^$', index),
    url(r'^add/$',add,name='add'),
]
```

运行

    ➜  mysite git:(master) ✗ python3 manage.py runserver

访问

`http://127.0.0.1:8000/add/?a=4&b=5`

会显示 `a + b` 的结果

试试 `http://127.0.0.1:8000/add/?a=157&b=5`

### /add/3/4/

url 通过 `/add/3/4/` 传值

修改 `calc/views.py`

    vim calc/views.py

```shell
def add2(request,a,b):
    c = int(a) + int(b)
    return HttpResponse(str(c))
```

修改 `mysite/urls.py`

    url(r'^add/(\d+)/(\d+)/$',add2,name='add2'),

访问 `http://127.0.0.1:8000/add/100/200/`

新地址自动跳转到旧地址的一种方式:

```python
from django.http import HttpResponseRedirect
# from django.core.urlresolvers import reverse  # django 1.4.x - django 1.10.x
from django.urls import reverse

def old_add2_redirect(request,a,b):
    return HttpResponseRedirect(reverse('add2',args=(a,b)))
```

urls.py

```python
url(r'^new_add/(\d+)/(\d+)/$',add2,name='add2'),
url(r'^add/(\d+)/(\d+)/$',old_add2_redirect),
```