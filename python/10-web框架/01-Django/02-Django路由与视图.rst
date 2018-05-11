Django路由与视图
================

路由说白了就是视图(函数)的对应关系,一个路由对应一个视图,如上面文章所提到的,当打开\ ``/users/``\ 路径的时候会让\ ``users``\ 这个函数来进行逻辑处理,把处理的结果再返回到前端

路由的配置文件入口在 ``settings.py`` 文件中已经定义.

.. code:: python

    ROOT_URLCONF = 'yang.urls'

路由
----

路由的配置
~~~~~~~~~~

绝对地址访问
^^^^^^^^^^^^

.. code:: python

    # 访问地址必须是http://127.0.0.1:8000/hello/
    url(r'^hello/$', views.hello),

使用正则与分组
^^^^^^^^^^^^^^

.. code:: python

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

在函数内需要接受year,month,day参数

.. code:: python

    url(r'^(?P<year>[0-9]{4})/(?P<month>[0-9]{2})/(?P<day>[0-9]{2})/$', views.date),
    # 使用分组匹配就不用考虑视图函数的参数位置了

``date``\ 视图必须接收以下参数

.. code:: python

    def date(request, year, month, day):

访问地址为: http://127.0.0.1:8000/2017/3/14/

传值
^^^^

::

    url(r'^(?P<year>[0-9]{4})/$', views.id, {'foo': 'bar'}),

``id``\ 函数必须接受\ ``year``\ 和\ ``foo``\ 参数

别名
^^^^

对URL路由关系进行命名,以后可以通过此名字获取URL(通过别名获取URL,就算URL调整也不会影响之前所有的别名)

可用于前端的from表单验证,如下实例,URLs地址的时候,因为from表单提交的地址使用了别名,所以会自动替换

.. code:: python

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

CBV
^^^

.. code:: python

    url(r'^home/', views.Home.as_view()),

路由分发
~~~~~~~~

include分发,有利于解耦

.. code:: python

    # 当访问二级路由是cmdb的时候转发给app01.urls处理
    url(r'^cmdb/$', include('app01.urls')),

路由分发实例
^^^^^^^^^^^^

可以使用\ ``incloud``\ 把很多个路由进行拆封,然后把不同的业务放到不同的urls中,首先我们创建项目及应用

.. code:: python

        # 创建DjangoProjects项目
        django-admin.py startproject DjangoProjects
        cd DjangoProjects
        # 在项目内创建app1和app2应用
        python3 manage.py startapp app1
        python3 manage.py startapp app2

项目的\ **urls.py**\ 文件内容

.. code:: python

        # DjangoProjects/DjangoProjects/urls.py
        from django.conf.urls import url, include
        from django.contrib import admin
        urlpatterns = [
            # 当路由匹配到一级路径为app1时，就把这个URL交给app1.urls再次进行匹配
            url(r'^app1/', include('app1.urls')),
            url(r'^app2/', include('app2.urls')),
        ]

应用\ **urls.py**\ 和\ **view.py**\ 文件内容

.. code:: python

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

1. 当访问 http://127.0.0.1:8000/app1/hello/ 时返回内容 ``Hello App1``
2. 当访问 http://127.0.0.1:8000/app2/hello/ 时返回内容 ``Hello App2``

视图
----

FBV & CBV
~~~~~~~~~

Django两者都支持

-  function base view
-  class base view

请求与响应
~~~~~~~~~~

http请求: **HttpRequest对象**

http响应: **HttpResponse对象**

HttpRequest对象属性

+-------------------------+---------------------------+
| 属性                    | 描述                      |
+=========================+===========================+
| request.path            | 请求页面的路径,不包括域名 |
+-------------------------+---------------------------+
| request.path_info       | 可用于跳转到当前页面      |
+-------------------------+---------------------------+
| request.get_full_path() | 获取带参数的路径          |
+-------------------------+---------------------------+
| request.method          | 页面的请求方式            |
+-------------------------+---------------------------+
| request.GET             | GET请求方式的数据         |
+-------------------------+---------------------------+
| request.POST            | POST请求方式的数据        |
+-------------------------+---------------------------+

HttpResponse对象属性

+-----------------------------------+----------------------+
| 属性                              | 描述                 |
+===================================+======================+
| render(request, ‘index.html’)     | 返回一个模板页面     |
+-----------------------------------+----------------------+
| render_to_response( ‘index.html’) | 返回一个模板页面     |
+-----------------------------------+----------------------+
| redirect(‘/login’)                | 页面跳转             |
+-----------------------------------+----------------------+
| HttpResponseRedirect(‘/login’)    | 页面跳转             |
+-----------------------------------+----------------------+
| HttpResponse(‘yang’)              | 给页面返回一个字符串 |
+-----------------------------------+----------------------+
