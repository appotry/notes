Django实例2
===========

第一部分
--------

.. code:: shell

    ➜  PycharmProjects django-admin startproject django_project2
    ➜  PycharmProjects cd django_project2
    ➜  django_project2 python3 manage.py startapp app01

配置
~~~~

``django_project2/settings.py``

.. code:: shell

    INSTALLED_APPS = [
        'django.contrib.admin',
        'django.contrib.auth',
        'django.contrib.contenttypes',
        'django.contrib.sessions',
        'django.contrib.messages',
        'django.contrib.staticfiles',
        # 注册app01
        'app01',
    ]

    TEMPLATES = [
        {
            'BACKEND': 'django.template.backends.django.DjangoTemplates',
            'DIRS': [os.path.join(BASE_DIR, 'templates')],
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

    STATICFILES_DIRS = (
        os.path.join(BASE_DIR,'static'),
    )

urls
~~~~

.. code:: python

    from django.conf.urls import url
    from django.contrib import admin
    from app01 import views

    urlpatterns = [
        url(r'^admin/', admin.site.urls),
        url(r'^login/', views.login),
        url(r'^home/', views.Home.as_view()),
    ]

templates
~~~~~~~~~

login.html
^^^^^^^^^^

.. code:: html

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
    </head>
    <body>
        <!-- 上传文件需要增加enctype="multipart/form-data" 属性 -->
        <form action="/login/" method="post" enctype="multipart/form-data">
            <p>
                篮球: <input type="checkbox" name="favor" value="1">
                足球: <input type="checkbox" name="favor" value="2">
                台球: <input type="checkbox" name="favor" value="3">
                乒乓球: <input type="checkbox" name="favor" value="4">
            </p>
            <p>
                <select name="city" multiple>
                    <option value="sh">上海</option>
                    <option value="bj">北京</option>
                    <option value="tj">天津</option>
                </select>
            </p>
            <input type="file" name="xxx">
            <input type="submit" value="提交">
        </form>

    </body>
    </html>

home.html
^^^^^^^^^

.. code:: html

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
    </head>
    <body>
        <form action="/home/" method="post">
            <input type="text" name="zxc">
            <input type="submit">
        </form>
        <span>method: {{ request.method }}</span>
    </body>
    </html>

views
~~~~~

.. code:: python

    from django.shortcuts import render
    from django.shortcuts import redirect
    from django.shortcuts import HttpResponse
    import os
    # Create your views here.
    from django.views import View
    from django.core.files.uploadedfile import InMemoryUploadedFile


    def index(request):
        return HttpResponse('<h1>Index</h1>')


    def login(request):
        if request.method == "GET":
            return render(request, 'login.html')
        elif request.method == "POST":
            # 获取的是一个列表,适用于复选框,select
            v = request.POST.getlist("favor")
            ct = request.POST.getlist("city")
            print(v)
            print(ct)

            obj = request.FILES.get("xxx")
            if obj:
                # <class 'django.core.files.uploadedfile.InMemoryUploadedFile'>
                # from django.core.files.uploadedfile import InMemoryUploadedFile
                # 可以通过上述对象,查看obj详细信息
                # obj.name 为文件名
                print(obj, type(obj), obj.name)
                # upload/文件名
                file_path = os.path.join('upload', obj.name)
                # 如果目录不存在,则创建
                if not os.path.exists(os.path.dirname(file_path)):
                    os.makedirs(os.path.dirname(file_path))
                # 打开一个文件,将用户上传的内容写入文件,并关闭文件
                f = open(file_path, mode='wb')
                for i in obj.chunks():
                    f.write(i)
                f.close()

            return redirect('/login/')
        else:
            return redirect('index')


    # views里面也可以使用类
    class Home(View):
        # 需要from django.views import View

        def dispatch(self, request, *args, **kwargs):
            # 每一次执行对应方法的时候,会在执行之前打印"before",执行之后打印"after"
            print('before')
            # 调用父类中的dispatch
            result = super(Home,self).dispatch(request, *args, **kwargs)
            print('after')
            return result

        def get(self, request):
            # return HttpResponse('<h1> class Home get</h1>')
            print(request.method)
            return render(request, 'home.html')

        def post(self, request):
            print(request.method)
            return render(request, 'home.html')

第二部分-路由
-------------

访问index,显示用户,点击用户名,显示详细用户信息

.. _templates-1:

templates
~~~~~~~~~

index.html
^^^^^^^^^^

.. code:: html

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
    </head>
    <body>
        {{ user_dict.k1 }}
        <ul>
            {% for k,row in user_dict.items %}
                <li><a href="/detail/?nid={{ k }}">{{ row.name }}</a></li>

                <!--
                <li><a href="/detail/?nid={{ k }}">{{ row.name }}</a></li>
                -->
            {% endfor %}
        </ul>

        <ul>
            {% for k in user_dict.keys %}
                <li>{{ k }}</li>
            {% endfor %}
        </ul>

        <ul>
            {% for val in user_dict.values %}
                <li>{{ val }}</li>
            {% endfor %}
        </ul>
        <ul>
            {% for k,row in user_dict.items %}
                <li>{{ k }}-{{ row }}</li>
            {% endfor %}
        </ul>
    </body>
    </html>

.. _views-1:

views
~~~~~

添加如下内容

.. code:: python

    USER_DICT = {
        '1': {'name': 'root1', 'email': 'root@163.com'},
        '2': {'name': 'root2', 'email': 'root@163.com'},
        '3': {'name': 'root3', 'email': 'root@163.com'},
        '4': {'name': 'root4', 'email': 'root@163.com'},
        '5': {'name': 'root5', 'email': 'root@163.com'},
    }


    def index(request):
        return render(request, 'index.html', {'user_dict': USER_DICT})


    # 第一版
    def detail(request):
        nid = request.GET.get('nid')
        return HttpResponse(USER_DICT[nid].items())

.. _urls-1:

urls
~~~~

.. code:: python

        url(r'^index/', views.index),
        url(r'^detail/', views.detail),

第二版
~~~~~~

.. code:: python

    # 对应 urls
    # url(r'^detail-(\d+).html', views.detail),
    # 第二版,需要传一个参数,url匹配的时候(括号里面的内容会当做参数餐给对应的试图函数)
    def detail(request, nid):
        nid = nid
        print(nid)
        return HttpResponse(USER_DICT[nid].items())

动态路由系统
~~~~~~~~~~~~

.. code:: python

    # url(r'^detail-(\d+)-(\d+).html', views.detail),
    如果用这种方式传参,试图函数接收参数时,顺序不能错,否则就会有问题

    # 分组匹配,对应参数传给对应名字的形参
    url(r'^detail-(?P<uid>\d+)-(?P<nid>\d+).html', views.detail),

    # 视图函数使用 *args, **kwargs 接收所有参数
    def detail(request, *args, **kwargs):
        # 访问 http://127.0.0.1:8112/detail-3-2.html
        # 使用对应url出现的结果

        # url(r'^detail-(\d+)-(\d+).html', views.detail),
        # ('3', '2')
        print(args)

        # url(r'^detail-(?P<uid>\d+)-(?P<nid>\d+).html', views.detail),
        # {'uid': '3', 'nid': '2'}
        print(kwargs)
        return HttpResponse("  ")

第三部分-模型
-------------

在第一部分已经在\ ``settings.py``\ 中注册过\ ``app01``

数据库配置
~~~~~~~~~~

sqlite
^^^^^^

.. code:: python

    # Database
    # https://docs.djangoproject.com/en/1.11/ref/settings/#databases

    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.sqlite3',
            'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
        }
    }

mysql
^^^^^

Django默认使用MySQLdb模块链接Mysql

主动修改为\ ``pymysql``\ 操作数据库

.. code:: python

    # 安装
    pip3 install pymysql

    # 然后在项目的`__init__.py`文件加入以下两行配置：

    ​```shell
    import pymysql
    pymysql.install_as_MySQLdb()
    ​```

``settings.py``\ 配置

.. code:: python

    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.mysql',
            'NAME': 'yang',
            'USER': 'root',
            'PASSWORD': '111xxx',
            'HOST': '127.0.0.1',
            'PORT': '3306'
        }
    }

models.py
~~~~~~~~~

创建类

.. code:: python

    from django.db import models

    # Create your models here.


    class UserInfo(models.Model):
        # Django会自动创建一个id列,自增,主键
        # 用户名,及密码,字符串类型,指定最大长度
        username = models.CharField(max_length=32)
        password = models.CharField(max_length=64)

执行命令,会根据\ ``app``\ 下的\ ``models.py``\ 自动创建数据库表

.. code:: shell

    python3 manage.py makemigrations
    python3 manage.py migrate

添加url,views,通过访问url进行测试
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

urls

.. code:: python

    url(r'^orm/', views.orm),

views

.. code:: python

    from app01 import models
    def orm(requeset):
        # 增加操作进行测试

        return HttpResponse('orm')

基本操作
~~~~~~~~

增
^^

.. code:: python

    from app01 import models
    def orm(requeset):
        # 增加操作进行测试

        # 创建
        # 方法一
        models.UserInfo.objects.create(username='root',password='123')

        # 方法二
        obj = models.UserInfo(username='xxx',password='qwe')
        obj.save()
        return HttpResponse('orm')

.. figure:: http://oi480zo5x.bkt.clouddn.com/python-django-models-01.jpg
   :alt: python-django-models-01

   python-django-models-01

继续修改视图函数

.. code:: python

    def orm(requeset):
        # 增加操作进行测试

        # 创建
        # 方法一
        # models.UserInfo.objects.create(username='root',password='123')

        # 方法二
        # obj = models.UserInfo(username='xxx',password='qwe')
        # obj.save()

        # 方法三,传入字典
        dic = {'username': 'abc', 'password': '666'}
        models.UserInfo.objects.create(**dic)
        return HttpResponse('orm')

查
^^

.. code:: python

    def orm(requeset):
        # 增加操作进行测试

        # 创建
        # 方法一
        # models.UserInfo.objects.create(username='root',password='123')

        # 方法二
        # obj = models.UserInfo(username='xxx',password='qwe')
        # obj.save()

        # 方法三,传入字典
        # dic = {'username': 'abc', 'password': '666'}
        # models.UserInfo.objects.create(**dic)

        # 查
        # 查询所有,返回的是一个QuerySet
        result = models.UserInfo.objects.all()
        # <QuerySet [<UserInfo: UserInfo object>, <UserInfo: UserInfo object>, <UserInfo: UserInfo object>]>
        print(result)

        for row in result:
            print(row.id, row.username, row.password)
        # 过滤
        result = models.UserInfo.objects.filter(username='root')
        # 多个条件
        result = models.UserInfo.objects.filter(username='root', password='123')

        # 删
        # models.UserInfo.objects.filter(username='root').delete()
        # 改
        # models.UserInfo.objects.filter(username='root').update(password='asd')

        return HttpResponse('orm')

简单登录验证
^^^^^^^^^^^^

.. code:: python

    def orm(request):
        if request.method == "GET":
            return render(request, 'orm.html')
        elif request.method == "POST":
            u = request.POST.get('username')
            p = request.POST.get('password')
            # 使用first(),如果有则返回一个对象,如果没有则返回一个None
            obj = models.UserInfo.objects.filter(username=u, password=p).first()
            # 获取obj之后,可以在页面显示用户信息
            if obj:
                return redirect('/index/')
            else:
                return render(request, 'orm.html')
        return HttpResponse('orm')

``orm.html``

.. code:: html

    <body>
        <form action="/orm/" method="post">
            <p>
                用户名: <input type="text" name="username">
            </p>
            <p>
                密码: <input type="password" name="password">
            </p>
            <input type="submit" value="提交">
        </form>
    </body>

第四部分-简单用户管理
---------------------

project.urls
~~~~~~~~~~~~

.. code:: python

    from django.conf.urls import include

    urlpatterns = [
        # 添加如下语句,使用路由分发
        url(r'^cmdb/', include('app01.urls')),
    ]

app01.urls
~~~~~~~~~~

文件若不存在,则创建

.. code:: python

    from django.conf.urls import url
    from django.contrib import admin
    from app01 import views

    from django.conf.urls import include

    urlpatterns = [
        url(r'^user_info/', views.user_info),
        url(r'^userdetail-(?P<nid>\d+)/', views.user_detail),
        url(r'^userdel-(?P<nid>\d+)/', views.user_del),
        url(r'^useredit-(?P<nid>\d+)/', views.user_edit),
    ]

.. _views-2:

views
~~~~~

.. code:: python

    def user_info(request):
        if request.method == "GET":

            user_list = models.UserInfo.objects.all()
            # print(user_list.query)
            # SELECT "app01_userinfo"."id", "app01_userinfo"."username", "app01_userinfo"."password" FROM "app01_userinfo"

            # QuerySet [obj, obj, ]
            return render(request, 'user_info.html', {'user_list': user_list})
        elif request.method == "POST":
            u = request.POST.get('user')
            p = request.POST.get('pwd')
            models.UserInfo.objects.create(username=u, password=p)
            return redirect('/cmdb/user_info/')


    def user_detail(request, nid):
        # 取单条数据,如果不存在,会直接报错
        # obj = models.UserInfo.objects.get(id=nid)

        obj = models.UserInfo.objects.filter(id=nid).first()
        return render(request, 'user_detail.html', {'obj': obj})


    def user_del(request, nid):
        models.UserInfo.objects.filter(id=nid).delete()
        return redirect('/cmdb/user_info')


    def user_edit(request, nid):
        if request.method == "GET":
            obj = models.UserInfo.objects.filter(id=nid).first()
            return render(request, 'user_edit.html', {'obj': obj})
        elif request.method == "POST":
            nid = request.POST.get('id')
            u = request.POST.get('username')
            p = request.POST.get('password')
            models.UserInfo.objects.filter(id=nid).update(username=u, password=p)
            return redirect('/cmdb/user_info/')

.. _templates-2:

templates
~~~~~~~~~

base.html
^^^^^^^^^

.. code:: html

    {% load staticfiles %}
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
        <link rel="stylesheet" href="/static/common.css">
    </head>
    <body>
        <div class="pg-header">
            xxxxxxxx
        </div>

        <div>
            <div class="menu-header">
                <p><a class="menu" href="/cmdb/user_info/">用户管理</a></p>
                <p><a class="menu" href="/cmdb/user_group/">用户组管理</a></p>
            </div>
        </div>

        {% block content-wrapper %}

        {% endblock %}

    </body>
    </html>

user_info.html
^^^^^^^^^^^^^^

.. code:: html

    {% extends 'base.html' %}
    {% load staticfiles %}

    {% block content-wrapper %}
        <div class="pg-content">
            <h3>添加用户</h3>
            <form action="/cmdb/user_info/" method="post">
                <input type="text" name="user">
                <input type="password" name="pwd">
                <input type="submit" value="添加">
            </form>
            <h3>用户列表</h3>
            <ul>
                {%  for row in user_list %}
                    <li>
                        <a href="/cmdb/userdetail-{{ row.id }}/">{{ row.username }}</a> |
                        <a href="/cmdb/useredit-{{ row.id }}/">编辑</a> |
                        <a href="/cmdb/userdel-{{ row.id }}/">删除</a>
                    </li>
                {% endfor %}
            </ul>
        </div>
    {% endblock %}

user_detail.html
^^^^^^^^^^^^^^^^

.. code:: html

    {% extends 'base.html' %}
    {% load staticfiles %}

    {% block content-wrapper %}

        <div class="pg-content">
            <h1>用户详细信息</h1>

            <h5>{{ obj.id }}</h5>
            <h5>{{ obj.name }}</h5>
            <h5>{{ obj.password }}</h5>
        </div>

    {% endblock %}

user_edit.html
^^^^^^^^^^^^^^

.. code:: html

    {% extends 'base.html' %}
    {% load staticfiles %}

    {% block content-wrapper %}

        <div class="pg-content">

            <h1>编辑用户</h1>
            <form action="/cmdb/useredit-{{ obj.id }}/" method="post">
                <input style="display: none;" type="text" name="id" value="{{ obj.id }}">
                <input type="text" name="username" value="{{ obj.username }}">
                <input type="password" name="password" value="{{ obj.password }}">
                <input type="submit" value="提交">
            </form>

        </div>
    {% endblock %}

本实例相关知识
==============

getlist
-------

用于CheckBox,select等多选的内容,获取到的内容为一个列表

.. code:: python

    ct = request.POST.getlist("city")

上传文件
--------

-  form表单需要做特殊设置, ``enctype="multipart/form-data"``
-  服务端接收文件并保存

form表单需要添加enctype属性
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: html

        <!-- 上传文件需要增加enctype="multipart/form-data" 属性 -->
        <form action="/login/" method="post" enctype="multipart/form-data">
            <p>
                篮球: <input type="checkbox" name="favor" value="1">
                足球: <input type="checkbox" name="favor" value="2">
                台球: <input type="checkbox" name="favor" value="3">
                乒乓球: <input type="checkbox" name="favor" value="4">
            </p>
            <input type="file" name="xxx">
            <input type="submit" value="提交">
        </form>

request.FILES
~~~~~~~~~~~~~

.. code:: python

    def login(request):
        if request.method == "GET":
            return render(request, 'login.html')
        elif request.method == "POST":
            obj = request.FILES.get("xxx")
            if obj:
                # <class 'django.core.files.uploadedfile.InMemoryUploadedFile'>
                # from django.core.files.uploadedfile import InMemoryUploadedFile
                # 可以通过上述对象,查看obj详细信息
                # obj.name 为文件名
                print(obj, type(obj), obj.name)
                # upload/文件名
                file_path = os.path.join('upload', obj.name)
                # 如果目录不存在,则创建
                if not os.path.exists(os.path.dirname(file_path)):
                    os.makedirs(os.path.dirname(file_path))
                # 打开一个文件,将用户上传的内容写入文件,并关闭文件
                f = open(file_path, mode='wb')
                for i in obj.chunks():
                    f.write(i)
                f.close()

            return redirect('/login/')
        else:
            return redirect('index')

FBV & CBV
---------

function base view

class base view

Django支持FBV和CBV
------------------

views里面也可以使用类
~~~~~~~~~~~~~~~~~~~~~

.. _urls-2:

urls
~~~~

.. code:: python

    from django.conf.urls import url
    from django.contrib import admin
    from app01 import views

    urlpatterns = [
        url(r'^admin/', admin.site.urls),
        url(r'^login/', views.login),
        url(r'^home/', views.Home.as_view()),
    ]

.. _views-3:

views
~~~~~

详细信息看父类View

.. code:: python

    from django.views import View


    # views里面也可以使用类
    class Home(View):
        # 需要from django.views import View

        def get(self, request):
            # return HttpResponse('<h1> class Home get</h1>')
            print(request.method)
            return render(request, 'home.html')

        def post(self, request):
            print(request.method)
            return render(request, 'home.html')

父类View
~~~~~~~~

.. code:: python

    class View(object):
        """
        Intentionally simple parent class for all views. Only implements
        dispatch-by-method and simple sanity checking.
        """

        http_method_names = ['get', 'post', 'put', 'patch', 'delete', 'head', 'options', 'trace']
        # 编写对应方法,对应的请求则会触发对应的方法
        # Django会先拿到请求,执行dispatch方法,通过getattr方法获取对应方法
        # 再执行对应方法
        def dispatch(self, request, *args, **kwargs):
            # Try to dispatch to the right method; if a method doesn't exist,
            # defer to the error handler. Also defer to the error handler if the
            # request method isn't on the approved list.
            if request.method.lower() in self.http_method_names:
                handler = getattr(self, request.method.lower(), self.http_method_not_allowed)
            else:
                handler = self.http_method_not_allowed
            return handler(request, *args, **kwargs)

我们也可以自己定义dispatch

.. code:: python

    class Home(View):
        # 需要from django.views import View

        def dispatch(self, request, *args, **kwargs):
            # 每一次执行对应方法的时候,会在执行之前打印"before",执行之后打印"after"
            print('before')
            # 调用父类中的dispatch
            result = super(Home,self).dispatch(request, *args, **kwargs)
            print('after')
            return result

        def get(self, request):
            # return HttpResponse('<h1> class Home get</h1>')
            print(request.method)
            return render(request, 'home.html')

        def post(self, request):
            print(request.method)
            return render(request, 'home.html')

models基本操作
--------------

.. _增-1:

增
~~

.. code:: python

    from app01 import models
    def orm(requeset):
        # 增加操作进行测试

        # 创建
        # 方法一
        # models.UserInfo.objects.create(username='root',password='123')

        # 方法二
        # obj = models.UserInfo(username='xxx',password='qwe')
        # obj.save()

        # 方法三,传入字典
        dic = {'username': 'abc', 'password': '666'}
        models.UserInfo.objects.create(**dic)
        return HttpResponse('orm')

.. _查-1:

查
~~

.. code:: python

        # 查
        # 查询所有,返回的是一个QuerySet
        result = models.UserInfo.objects.all()
        # <QuerySet [<UserInfo: UserInfo object>, <UserInfo: UserInfo object>, <UserInfo: UserInfo object>]>

        # 过滤
        result = models.UserInfo.objects.filter(username='root')
        # 多个条件
        result = models.UserInfo.objects.filter(username='root', password='123')

删
~~

.. code:: python

    models.UserInfo.objects.filter(username='root').delete()

改
~~

.. code:: python

    models.UserInfo.objects.filter(username='root').update(password='asd')

first
~~~~~

.. code:: python

    obj = models.UserInfo.objects.filter(username=u, password=p).first()

count
~~~~~

统计数量

.. code:: python

    models.UserInfo.objects.all().count()
