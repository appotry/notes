# Django

## 快速开始

1. 安装python
2. 安装Django
3. 创建工程

```shell
在t_django目录执行命令
➜  t_django django-admin startproject mysite # mysite为工程名
➜  t_django cd mysite
➜  mysite tree
.
├── manage.py # 管理Django程序
└── mysite
    ├── __init__.py
    ├── settings.py # 配置文件
    ├── urls.py     # url对应关系
    └── wsgi.py     # 遵循WSGI规范,发布的话使用 uwsgi+Nginx
```

运行

    python manage.py runserver 0.0.0.0:8000

访问127.0.0.1:8000

![python-django-01](http://oi480zo5x.bkt.clouddn.com/python-django-01.jpg)

## Django的历史

## Django访问流程

Django请求生命周期

- URL对应关系(匹配) -> 视图函数 -> 返回用户字符串
- URL对应关系(匹配) -> 视图函数 -> 打开一个HTML,读取内容

## WSGI规范

只要遵循这个规范,就可以用来创建socket

## 安装python

```python
➜  python3 -V
Python 3.5.3
```

## 安装django

我的操作系统是`Mac`,并且已经配置安装好了`pip3`和`python3`,可以直接使用`pip`来进行安装

```python
# 默认安装最近稳定版本
pip3 install django
```

指定安装`django`版本

    pip install django==1.9

进入`python`解释器,导入`django`模块来进行校验是否正确安装

在导入的时候没有报错就表示已经安装成功,否则需要重新安装

```python
➜  ~ python3
Python 3.5.3 (v3.5.3:1880cb95a742, Jan 16 2017, 08:49:46)
[GCC 4.2.1 (Apple Inc. build 5666) (dot 3)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> import django
>>> django.get_version()
'1.10.6'
```

## 创建Django项目

`django`为我们提供了一个`django-admin`的指令,以方便与我们在命令行下创建`django`项目,可以使用`django-admin --help`查看该指令的帮助信息.

常用参数:

| 参数             | 描述                   |
| -------------- | -------------------- |
| startproject   | 创建一个完整的项目            |
| startapp       | 创建一个app              |
| runserver      | 运行django为我们提供的http服务 |
| shell          | 进入待django环境的shell    |
| makemigrations | 生成数据库命令              |
| migrate        | 执行生成好的数据库命令          |

使用`startproject`创建项目

```python
➜  ~ django-admin startproject yang
➜  ~ cd yang
➜  yang ls
manage.py yang
```

`manage.py`文件是一种命令行工具,允许你以多种方式与该`Django`项目进行交互,输入`python mange.py help`可以看到他为我们提供了哪些指令,比如如下是常用的

| 指令              | 描述                 |
| --------------- | ------------------ |
| createsuperuser | 创建一个django后台的超级管理员 |
| changepassword  | 修改超级管理员的密码         |

`django-admin —help` 查看帮助

`yang/settings.py`项目的全局配置文件,很重要
`yang/urls.py`项目的路由配置文件,这是一个django项目的主入口文件

## 创建APP

使用如下命令

```shell
python3 manage.py startapp cmdb # app名字
# 可以通过app将业务分开
```

```shell
➜  yang python3 manage.py startapp cmdb
➜  yang tree
.
├── cmdb                # 刚创建的app
│   ├── __init__.py
│   ├── admin.py        # Django提供的后台管理
│   ├── apps.py         # 配置当前app
│   ├── migrations      # 记录数据库表结构修改
│   │   └── __init__.py
│   ├── models.py       # ORM,写指定的类,通过命令就可以创建数据库结构
│   ├── tests.py        # 单元测试
│   └── views.py        # 业务代码
├── manage.py
└── yang
    ├── __init__.py
    ├── __pycache__
    │   ├── __init__.cpython-35.pyc
    │   └── settings.cpython-35.pyc
    ├── settings.py
    ├── urls.py
    └── wsgi.py

4 directories, 14 files
```

## 运行Django项目

`django`内部是有一个內建的轻量的web开发服务器,在开发期间你完全可以使用內建的服务器,避免安装`Nginx`或者`Apache`等

```python
➜  yang python3 manage.py runserver
Performing system checks...

System check identified no issues (0 silenced).

You have 13 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, contenttypes, sessions.
Run 'python manage.py migrate' to apply them.

March 14, 2017 - 07:37:08
Django version 1.10.6, using settings 'yang.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.
```

![python-django-01](http://oi480zo5x.bkt.clouddn.com/python-django-01.jpg)

更改这个`Development Server`的主机地址或端口

默认情况下,`runserver`命令在`8000`端口启动开发服务器,且监听本地连接,要想更改端口,可将端口作为命令参数传入:

    python manage.py runserver 8080

通过指定一个`IP`地址,你可以告诉服务器-允许非本地连接访问.指定监听网络地址.

    python manage.py runserver 0.0.0.0:8080

## 实例

后台添加用户,前台展示用户

继续上面创建好的项目`yang`之上创建一个`app`:`users`

    python3 manage.py startapp users

除此之外,需要把`app`注册到我们的项目中,可以在`yang/setting.py`中找到`INSTALLED_APPS`字典,把刚创建的app名字添加进去

```python
    INSTALLED_APPS = [
        ......
        'users',
    ]
```

我们需要用到`html`,所以我们也需要配置模板路径文件,先创建一个存放模板文件的路径.

    mkdir templates

继续编辑`settings.py`,找到`TEMPLATES`,把`DIRS`修改如下

    'DIRS': [os.path.join(BASE_DIR, 'templates')],

在`yang/urls.py`中添加一条路由配置

```python
from django.conf.urls import url
from django.contrib import admin
# 导入app下面的视图函数users
from users.views import users

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    # 指定路由对应的函数
    url(r'^users/$',users),
]
```

`users/views.py`视图函数内容如下:

```python
➜  yang cat users/views.py
from django.shortcuts import render
# 导入模型中的UserInfo表
from .models import UserInfo

# Create your views here.

def users(request):
    # 获取所有的用户
    all_user = UserInfo.objects.all()
    # 把用户信息和前端文件一起发送到浏览器
    return render(request,'users.html',{'all_user': all_user})
➜  yang
```

`templates/users.html`内容如下

```python
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
<ul>
    <!-- 循环传过来的所有用户，显示其用户名 -->
    {% for user in all_user %}
        <li>{{ user.name }}</li>
    {% endfor %}
</ul>
</body>
</html>
```

`users/models.py`配置文件

```python
from django.db import models

__all__ = [
    'UserInfo'
]
# Create your models here.

class UserInfo(models.Model):
    name = models.CharField(max_length=30,verbose_name='用户名')
    email = models.EmailField(verbose_name='用户邮箱')
```

`user/admin.py`配置文件

```python
from django.contrib import admin
from .models import *

# Register your models here.

admin.site.register(UserInfo)
```

最后生成数据库

```python
➜  yang python3 manage.py makemigrations
Migrations for 'users':
  users/migrations/0001_initial.py:
    - Create model UserInfo
➜  yang python3 manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions, users
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying sessions.0001_initial... OK
  Applying users.0001_initial... OK
```

创建超级管理员用户

```python
用户名 yang
密码 yang111111
➜  yang python3 manage.py createsuperuser
Username (leave blank to use 'yang'): yang
# 邮箱地址,可以为空
Email address:
# 密码
Password:
Password (again):
Superuser created successfully.
```

打开`http://127.0.0.1:8000/admin/`登录后台，输入我们刚才创建好的用户和密码

![python-django-02](http://oi480zo5x.bkt.clouddn.com/python-django-02.jpg)

找到刚刚添加的`app`,添加一个或多个用户

![python-django-03](http://oi480zo5x.bkt.clouddn.com/python-django-03.jpg)

![python-django-04](http://oi480zo5x.bkt.clouddn.com/python-django-04.jpg)

![python-django-05](http://oi480zo5x.bkt.clouddn.com/python-django-05.jpg)

继续打开[http://127.0.0.1:8000/users/](http://127.0.0.1:8000/users/)就能够看到刚才添加的用户了，你可以试着再添加一个用户然后刷新页面，看看是否会显示出来你刚刚新添加的用户。

## 附,使用PyCharm创建Django项目

新建项目,可直接选择Django,输入项目名称,模板文件夹名字,应用名字,创建即可

![python-django-08](http://oi480zo5x.bkt.clouddn.com/python-django-08.jpg)

相关配置

可以在此处直接进行运行Django(免去使用命令行运行的麻烦),相关配置也可以在此处进入,如配置端口等

![python-django-09](http://oi480zo5x.bkt.clouddn.com/python-django-09.jpg)

![python-django-10](http://oi480zo5x.bkt.clouddn.com/python-django-10.jpg)

# 进阶(实例)

使用PyCharm直接创建mysite项目

## 配置

mysite/settings.py

### 配置模板路径

```shell
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')]
        ,
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
```

### 配置静态目录

```shell
# 配置静态目录
STATIC_URL = '/static/'
STATICFILES_DIRS = (
    os.path.join(BASE_DIR, 'static'),
)
```

### 暂时注释CSRF

```shell
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    # 'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
```

### 注册APP

```shell
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'cmdb',
]
```

## urls

mysite/urls.py

```python
from django.conf.urls import url
from django.contrib import admin
from cmdb import views

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^index/', views.index),
    url(r'^login/', views.login),
    url(r'^home/', views.home),
]

```

## templates

templates/home.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        body {
            margin:0 auto;
        }
        #i1 {
            height: 48px;
            background-color: #dddddd;
        }
    </style>
</head>
<body>
    <div id="i1"></div>
    <div>
        <form action="/home/" method="post">
            <input type="text" name="username" placeholder="用户名">
            <input type="text" name="email" placeholder="邮箱">
            <input type="text" name="gender" placeholder="性别">
            <input type="submit" value="添加">
        </form>
    </div>
    <div>
        <table>
            {% for row in user_list %}
                <tr>
                    <td>{{ row.username }}</td>
                    <td>{{ row.email }}</td>
                    <td>{{ row.gender }}</td>
                </tr>
            {% endfor %}
        </table>
    </div>
</body>
</html>
```

templates/login.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        label {
            width: 80px;
            text-align: right;
            display: inline-block;
        }
        .sp1 {
            color: red;
        }
    </style>
</head>
<body>
    <form action="/login/" method="post">
        <p>
            <label for="username">用户名: </label>
            <input id="username" name="user" type="text">
        </p>
        <p>
            <label for="password">密 码: </label>
            <input id="password" name="pwd" type="password">
            <input type="submit" value="提交">
            <!-- 使用下面这个标签巧妙的显示错误信息 -->
            <span class="sp1">{{ error_msg }}</span>
        </p>
    </form>
</body>
</html>
```

## views

cmdb/views.py

```Python
from django.shortcuts import render
from django.shortcuts import HttpResponse
from django.shortcuts import redirect

# Create your views here.


def index(request):
    return HttpResponse('<h1>Index cmdb</h1>')


def login(request):
    # 包含用户提交的所有信息
    print(request)

    # <class 'django.core.handlers.wsgi.WSGIRequest'>
    print(type(request))

    # 获取用户提交方法
    print(request.method)

    error_msg = ""
    if request.method == "POST":
        # 获取用户通过POST请求提交过来的数据
        # 如果不存在会返回一个None
        user = request.POST.get("user",None)
        pwd = request.POST.get("pwd",None)
        print(user,pwd)

        # 使用这种方法,如果key不存在,会报错,所以推荐使用get方法获取
        # user = request.POST['user']
        # pwd = request.POST['pwd']

        if user == 'qwe' and pwd == '123':
            # redirect 跳转
            return redirect('https://www.baidu.com')
        else:
            error_msg = "用户名或密码错误"

    return render(request, 'login.html', {'error_msg': error_msg})


USER_LIST = [
    {'username': 'xxx', 'email': 'xxx@xx.com', 'gender': '男'}
]

for i in range(20):
    temp = {'username': 'xxx' + str(i), 'email': 'xxx@xx.com', 'gender': '男'}
    USER_LIST.append(temp)


def home(request):
    if request.method == "POST":
        # 接收用户提交的数据,添加到USER_LIST并显示到页面
        u = request.POST.get('username')
        e = request.POST.get('email')
        g = request.POST.get('gender')
        temp = {'username': u, 'email': e, 'gender': g}
        USER_LIST.append(temp)

    return render(request, 'home.html',{'user_list': USER_LIST})
    # 如果模板在templates目录下的某个子目录下,则只需要加上路径就行了,例如 test下
    # return render(request, 'test/home.html',{'user_list': USER_LIST})
```

## 总结

- 创建Django工程
  - django-admin startproject 工程名
- 创建app
  - cd 工程名
  - python manage.py startapp cmdb

- 静态文件
  - project.settings.py
  - ```shell
    STATICFILES_DIRS = (
        os.path.join(BASE_DIR,'static'),
    )
    ```
- 模板路径
  - ```shell
    'DIRS': [os.path.join(BASE_DIR, 'templates')]
    ```
- settings
  - 暂时注释CSRF
- 定义路由规则
  - url.py     "login"  —> 函数名
- 定义视图函数
  - app下views.py
  - ```python
    def func(request):
        # request.method
        # request.GET.get('',None)

        # return HttpResponse("字符串")
        # return render(request,"HTML模板路径")
        # return redirect('/只能填URL')
    ```
