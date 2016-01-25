# Django模型

## MTV开发模式

把数据存取逻辑、业务逻辑和表现逻辑组合在一起的概念有时被称为软件架构的`Model-View-Controller(MVC)`模式。在这个模式中，**Model**代表数据存取层，**View**代表的是系统中选择显示什么和怎么显示的部分，**Controller**指的是系统中根据用户输入并视需要访问模型，以决定使用哪个视图的那部分。

Django紧紧地遵循这种`MVC`模式，可以称得上是一种`MVC`框架。

以下是Django中`M、V`和`C`各自的含义：

1. `M`： 数据存取部分，由**django数据库层**处理;
2. `V`： 选择显示哪些数据要显示以及怎样显示的部分，由视图和模板处理;
3. `C`： 根据用户输入委派视图的部分，由Django框架根据URLconf设置，对给定URL调用适当的Python函数;

`C`由框架自行处理，而Django里更关注的是`模型(Model)`、`模板(Template)`和`视图(Views)`，Django也被称为`MTV`框架，在MTV开发模式中：

1. `M` 代表模型(Model)，即数据存取层，该层处理与数据相关的所有事务：如何存取、如何验证有效性、包含哪些行为以及数据之间的关系等;
2. `T` 代表模板(Template)，即表现层，该层处理与表现相关的决定：如何在页面或其他类型文档中进行显示;
3. `V` 代表视图(View)，即业务逻辑层，该层包含存取模型及调取恰当模板的相关逻辑，你可以把它看作模型与模板之间的桥梁;

## 数据库配置

```shell
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'yang',
        'USER': 'root',
        'PASSWORD': '111111',
        'HOST': '127.0.0.1',
        'PORT': '3306'
    }
}
```

以下是一个MySQL数据库的配置属性：

| 字段       | 描述        |
| -------- | --------- |
| ENGINE   | 使用的数据库引擎  |
| NAME     | 数据库名称     |
| USER     | 那个用户连接数据库 |
| PASSWORD | 用户的密码     |
| HOST     | 数据库服务器    |
| PORT     | 端口        |

ENGINE字段所支持的内置数据库

* django.db.backends.postgresql
* django.db.backends.mysql
* django.db.backends.sqlite3
* django.db.backends.oracle

无论你选择使用那个数据库都必须安装此数据库的驱动，即python操作数据库的介质，在这里你需要注意的是python3.x并不支持使用MySQLdb模块，但是你可以通过pymysql来替代mysqldb，首先你需要安装pymysql模块：

    pip3 install pymysql

然后在项目的`__init__.py`文件加入以下两行配置：

```shell
import pymysql
pymysql.install_as_MySQLdb()
```

当数据库配置完成之后，我们可以使用python manage.py shell进入项目测试，输入下面这些指令来测试你的数据库配置：

```shell
➜  yangxxx git:(master) ✗ python3 manage.py shell
Python 3.5.3 (v3.5.3:1880cb95a742, Jan 16 2017, 08:49:46)
[GCC 4.2.1 (Apple Inc. build 5666) (dot 3)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
(InteractiveConsole)
>>> from django.db import connection
>>> cursor = connection.cursor()
```

没有报错,则说明数据库配置正确.
