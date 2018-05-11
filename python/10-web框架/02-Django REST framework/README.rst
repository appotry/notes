Django REST framework
=====================

当前版本 ``version 3``

http://www.django-rest-framework.org/

``Django REST framework`` 用于构建 ``web api``, 具有强大,灵活的特性.

Requirements
------------

REST framework requires the following:

-  Python (2.7, 3.2, 3.3, 3.4, 3.5, 3.6)
-  Django (1.10, 1.11, 2.0)

可选包:

-  `coreapi <https://pypi.python.org/pypi/coreapi/>`__ (1.32.0+) -
   Schema generation support.
-  `Markdown <https://pypi.python.org/pypi/Markdown/>`__ (2.1.0+) -
   Markdown support for the browsable API.
-  `django-filter <https://pypi.python.org/pypi/django-filter>`__
   (1.0.1+) - Filtering support.
-  `django-crispy-forms <https://github.com/maraujop/django-crispy-forms>`__
   - Improved HTML display for filtering.
-  `django-guardian <https://github.com/django-guardian/django-guardian>`__
   (1.1.1+) - Object level permissions support.

安装
----

通过 ``pip`` 安装, 需要的可选包也可以一并安上

.. code:: shell

    pip install djangorestframework
    pip install markdown       # Markdown support for the browsable API.
    pip install django-filter  # Filtering support

配置
----

将 ‘rest_framework’ 添加到项目 ``INSTALLED_APPS`` 设置中.

.. code:: python

    INSTALLED_APPS = (
        ...
        'rest_framework',
    )

如果你打算使用可视化的 API 或者 REST framework 的登入登出视图.
添加如下配置到 ``urls.py`` 文件中.

.. code:: python

    # url路径自行修改
    urlpatterns = [
        ...
        url(r'^api-auth/', include('rest_framework.urls'))
    ]

示例
----

.. code:: shell

    # 安装 djangorestframework
    pip3 install djangorestframework

    # 创建项目
    django-admin startproject resttest
    cd resttest

    # 同步数据库
    python3 manage.py makemigrations
    python3 manage.py migrate

``REST framework API`` 全局配置均配置在名为 ``REST_FRAMEWORK`` 的字典中.

添加如下配置到 ``settings.py`` 中

.. code:: python

    REST_FRAMEWORK = {
        # Use Django's standard `django.contrib.auth` permissions,
        # or allow read-only access for unauthenticated users.
        'DEFAULT_PERMISSION_CLASSES': [
            'rest_framework.permissions.DjangoModelPermissionsOrAnonReadOnly'
        ]
    }

注册APP

.. code:: python

    INSTALLED_APPS = (
        ...
        'rest_framework',
    )

完整 ``urls.py`` 内容

.. code:: python

    from django.conf.urls import url, include
    from django.contrib.auth.models import User
    from rest_framework import routers, serializers, viewsets

    # Serializers define the API representation.
    class UserSerializer(serializers.HyperlinkedModelSerializer):
        class Meta:
            model = User
            fields = ('url', 'username', 'email', 'is_staff')

    # ViewSets define the view behavior.
    class UserViewSet(viewsets.ModelViewSet):
        queryset = User.objects.all()
        serializer_class = UserSerializer

    # Routers provide an easy way of automatically determining the URL conf.
    router = routers.DefaultRouter()
    router.register(r'users', UserViewSet)

    # Wire up our API using automatic URL routing.
    # Additionally, we include login URLs for the browsable API.
    urlpatterns = [
        url(r'^', include(router.urls)),
        url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
    ]

启动server

.. code:: python

    python3 manage.py runserver

访问 http://127.0.0.1:8000 即可看到我们的 ``users`` API.
