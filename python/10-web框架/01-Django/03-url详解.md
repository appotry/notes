# Url

    url(r'^add/(\d+)/(\d+)/$',add2,name='add2'),

这里的 `name='add2'`,可以用于在 templates, models, views...中得到对应的网址，相当于“给网址取了个名字”，只要这个名字不变，网址变了也能通过名字获取到。

## 修改 `calc/views.py`

```shell
def index(request):
    return render(request,'home.html')
```

render 是渲染模板

## 将 `calc` 这个app加入到 `mysite/settings.py`

```shell
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'learn',
    'calc',
]
```

这样配置之后,使用render的时候,Django会自动找到INSTALLED_APPS中列出的各个app下的templates中的文件

`DEBUG=True` 的时候，Django 还可以自动找到 各 app 下 static 文件夹中的静态文件（js，css，图片等资源），方便开发。

## 创建templates目录

编辑 `calc/templates/home.html`

```html
<!DOCTYPE html>
<html>
<head>
    <title>xxx</title>
</head>
<body>

<a href="/add/4/5/">计算 4+5</a>

</body>
</html>
```

修改 `mysite/urls.py`

```shell
from django.conf.urls import url
from django.contrib import admin
#from learn.views import index
from calc.views import add
from calc.views import add2
from calc.views import index

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^add/$',add,name='add'),
    url(r'^add/(\d+)/(\d+)/$',add2,name='add2'),
    url(r'^$',index,name='home'),
]
```

访问 `http://127.0.0.1:8000/`

![python-django-07](http://oi480zo5x.bkt.clouddn.com/python-django-07.png)

现在计算加法用 `/add/4/5/`,如果需求变了,`/new_add/4/5`,但是在代码中都写死的`/add/4/5/`.

**这样的话,会使得改了网址(正则)后,模板,视图(views.py,用以用于跳转),模型(models.py,可以用与获取对象对应的地址)用了此网址,都得进行相应的修改,代价会很大.**

如何解决这个问题?

```shell
➜  mysite git:(master) ✗ python3 manage.py shell

>>> from django.urls import reverse

>>> reverse('add2',args=(4,5))
'/add/4/5/'
>>> reverse('add2',args=(443,5))
'/add/443/5/'
```

`reverse`接收`url`中的name作为第一个参数,我们在代码中就可以通过reverse()来获取对应的网址(这个网址可以用来跳转,也可以用来就算相关页面的地址),只要对应的url的name不改,就不用改网址代码.

在网页模板中也是一样,可以方便使用

```html
不带参数的：
{% url 'name' %}
带参数的：参数可以是变量名
{% url 'name' 参数 %}

例如：
<a href="{% url 'add2' 4 5 %}">link</a>
```

对urls.py进行如下修改

    url(r'^new_add/(\d+)/(\d+)/$',add2,name='add2'),

如此就可以实现,修改网址的时候,只需要修改urls.py中正则表达式部分,name不变的前提下,其他地方都不需要修改

另外,如果用户收藏夹里面url仍然是旧的,怎么实现以前的 `/add/3/4` 会自动跳转到新网址呢?

Django不会帮我们做这个,需要自己实现

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