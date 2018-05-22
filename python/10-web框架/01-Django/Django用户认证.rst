Django用户认证
==============

要实现这样的需求其实很简单：

-  使用django自带的装饰器 ``@login_required``\ 。
-  在相应的view方法的前面添加 ``@login_required``
-  并在settings.py中配置\ ``LOGIN_URL``\ 参数
-  修改login.html中的表单action参数

创建测试用户
------------

.. code:: shell

    python3 manage.py createsuperuser

登录后默认跳转到
----------------

登录后默认跳转到 ``/accounts/profile/``

可以在settings.py中进行设置

.. code:: python

    LOGIN_REDIRECT_URL = '/'

登录页面
--------

.. code:: html

    <form class="form-signin" action="/accounts/login/" method="post">{% csrf_token %}
    ...
    </form>
