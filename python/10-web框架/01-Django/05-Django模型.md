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

## 实战

### 创建一个新的app

让我们来创建一个**Django app**，一个包含模型，视图和Django代码，并且形式为独立Python包的完整Django应用。

**Project**和**app**之间的不同就是一个是**配置**另一个是**代码**：

1. 一个**Project**包含很多个**Django app**以及对它们的配置;
2. 技术上，**Project**的作用是提供配置文件，比方说哪里定义数据库连接信息, 安装的**app**列表，**TEMPLATE**等等;
3. 一个**app**是一套Django功能的集合，通常包括模型和视图，按Python的包结构的方式存在;
4. 例如，Django本身内建有一些**app**，例如注释系统和自动管理界面，**app**的一个关键点是它们是很容易移植到其他**Project**和被多个**Project**复用。

如果你使用了Django的数据库层(模型)，你必须创建一个**Django app**，模型必须存放在apps中，因此，为了开始建造我们的模型，我们必须创建一个新的app：

```shell
➜  yangxxx git:(master) ✗ python3 manage.py startapp darker

➜  yangxxx git:(master) ✗ tree darker
darker
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

### 第一个模型

首先创建三张表

1. 学生表(student) , 拥有字段: id/sname/gender
2. 课程表(course) , 拥有字段: id/cname
3. 成绩表(score) , 拥有字段: id/student_id/course_id

打开app的`models.py`目录输入以下代码：

```python
from django.db import models

# Create your models here.

class student(models.Model):
    # 自增主键,如果没有定义,Django会自动帮我们创建一个
    id = models.AutoField
    sname = models.CharField(max_length=12)
    gender = models.CharField(max_length=2)

class course(models.Model):
    # 自增主键,如果没有定义,Django会自动帮我们创建一个
    id = models.AutoField
    cname = models.CharField(max_length=12)

class score(models.Model):
    # 自增主键,如果没有定义,Django会自动帮我们创建一个
    id = models.AutoField
    # 设置外键关联
    student_id = models.ForeignKey(student)
    course_id = models.ForeignKey(course)
```

每个数据模型都是`django.db.models.Model`的子类,它的父类`Model`包含了所有必要的和数据库交互的方法，并提供了一个简洁漂亮的定义数据库字段的语法,每个模型相当于单个数据库表，每个属性也是这个表中的一个字段,属性名就是字段名.

### 模型安装

要通过django在数据库中创建这些表，首先我们需要在项目中**激活**这些模型，将**darker app**添加到配置文件的已安装应用列表中即可完成此步骤;

编辑`settings.py`文件,找到`INSTALLED_APPS`设置,`INSTALLED_APPS`告诉Django项目哪些`app`处于激活状态：

```python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'darker',
]
```

通过下面的指令来创建数据表

```shell
# 检查是否正确
➜  yangxxx git:(master) ✗ python3 manage.py check
System check identified no issues (0 silenced).

# 在数据库中生成表
➜  yangxxx git:(master) ✗ python3 manage.py makemigrations
Migrations for 'darker':
  darker/migrations/0001_initial.py
    - Create model course
    - Create model score
    - Create model student
    - Add field student_id to score

# 生成数据
➜  yangxxx git:(master) ✗ python3 manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, darker, sessions
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
  Applying darker.0001_initial... OK
  Applying sessions.0001_initial... OK
```

`django1.7`之前的版本都是：

```shell
python manage.py syncdb
```

`django1.7`及之后的版本做了修改，把1步拆成了2步，变成

```shell
python manage.py makemigrations
python manage.py migrate
```

查看创建的数据表

```shell
mysql> use yang;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+----------------------------+
| Tables_in_yang             |
+----------------------------+
| auth_group                 |
| auth_group_permissions     |
| auth_permission            |
| auth_user                  |
| auth_user_groups           |
| auth_user_user_permissions |
| darker_course              |
| darker_score               |
| darker_student             |
| django_admin_log           |
| django_content_type        |
| django_migrations          |
| django_session             |
+----------------------------+
13 rows in set (0.01 sec)
```

### 基本数据访问

运行 `python3 manager.py shell` 并使用Django提供的高级Python API

```shell
➜  yangxxx git:(master) ✗ python3 manage.py shell
Python 3.5.3 (v3.5.3:1880cb95a742, Jan 16 2017, 08:49:46)
[GCC 4.2.1 (Apple Inc. build 5666) (dot 3)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
(InteractiveConsole)

# 导入student模型类,通过这个类我们可以与student数据表进行交互
>>> from darker.models import student

# 创建一个student类的实例并设置字段sname,gender
>>> s1 = student(sname='yang',gender='m')
# 调用该对象的save()方法,将对象保存到数据库中,Django会在后台执行一条INSERT语句
>>> s1.save()
>>> s2 = student(sname='s2',gender='w')
>>> s2.save()

# 使用student.objects属性从数据库取出student表的记录集,这个属性又许多方法,student.objects.all()方法获取数据库中student类的所有对象,实际上Django执行了一条SQL SELECT语句
>>> student_list = student.objects.all()
>>> student_list
<QuerySet [<student: student object>, <student: student object>, <student: student object>]>
```

### 让获取到的数据显示为字符串格式

只需要在上面三个表类中添加一个方法 `__str__`,如下:

```python
from django.db import models

# Create your models here.

class student(models.Model):
    id = models.AutoField
    sname = models.CharField(max_length=12)
    gender = models.CharField(max_length=2)

    def __str__(self):
        return self.sname

class course(models.Model):
    id = models.AutoField
    cname = models.CharField(max_length=12)

    def __str__(self):
        return self.cname

class score(models.Model):
    id = models.AutoField
    student_id = models.ForeignKey(student)
    course_id = models.ForeignKey(course)
```

重新进入shell

```shell
➜  yangxxx git:(master) ✗ python3 manage.py shell
Python 3.5.3 (v3.5.3:1880cb95a742, Jan 16 2017, 08:49:46)
[GCC 4.2.1 (Apple Inc. build 5666) (dot 3)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
(InteractiveConsole)
>>> from darker.models import student
>>> student_list = student.objects.all()
# 此次获取的是字符串而不是对象了
>>> student_list
<QuerySet [<student: yang>, <student: yang>, <student: s2>]>
```

### 插入和更新数据

```python
# 插入数据
>>> s1 = student(sname='qaz',gender='m')
# 将数据保存到数据库
>>> s1.save()
# 获取刚插入的数据的ID
>>> s1.id
4
# 修改数据内容
>>> s1.gender='w'
>>> s1.save()
# 相当于执行了命令:
# UPDATE darker_student SET gender = 'w' WHERE id=4;

```

### 选择对象

下面的指令是从数据库中获取所有的数据

```shell
>>> student.objects.all()
<QuerySet [<student: yang>, <student: yang>, <student: s2>, <student: qaz>]>
```

Django在选择所有数据时并没有使用 `SELECT *`,而是显式列出了所有字段, `SELECT *` 会更慢,而且最重要的是列出所有字段遵循了Python的一个信条: `明言胜于暗示`

数据过滤

使用`filter()`方法对数据过滤

```shell
>>> student.objects.filter(sname='qaz',gender='w')
<QuerySet [<student: qaz>]>
```

在`sname`和`contains`之间有双下划线,gender部分会被Django翻译成LIKE语句

```python
>>> student.objects.filter(sname__contains='y')
<QuerySet [<student: yang>, <student: yang>]>
```

翻译成下面的SQL语句:

    SELECT id,sname,gender FROM darker_student WHERE name LIKE '%y%'

获取单个对象

```python
>>> student.objects.get(sname='qaz')
<student: qaz>
```

数据排序

使用`order_by()`这个方法进行排序

```python
>>> student.objects.order_by("sname")
<QuerySet [<student: qaz>, <student: s2>, <student: yang>, <student: yang>]>
>>>
```

如果需要以多个字段为标准进行排序(第二个字段会在第一个字段的值相同的情况下被使用到),使用多个参数就可以了,如下:

```python
>>> student.objects.order_by("sname","gender")
<QuerySet [<student: qaz>, <student: s2>, <student: yang>, <student: yang>]>
```

**指定逆序排序**

```python
>>> student.objects.order_by('-sname')
<QuerySet [<student: yang>, <student: yang>, <student: s2>, <student: qaz>]>
```

**设置数据的默认排序**

如果你设置了这个选项,那么除非你检索时特意额外地使用了`order_by()`,否则,当你使用Django的数据库API去检索时,student对象的相关返回值默认地都会按`sname`字段排序.

```python
class student(models.Model):
    id = models.AutoField
    sname = models.CharField(max_length=12)
    gender = models.CharField(max_length=2)

    def __str__(self):
        return self.sname
    class Meta:
        ordering = ['sname']
```

连锁查询

```python
>>> from darker.models import student
>>> student.objects.filter(id='2').order_by('-sname')
<QuerySet [<student: yang>]>
```

**限制返回的数据**

```python
>>> student.objects.order_by('sname')[0]
<student: qaz>
>>> student.objects.order_by('sname')[1]
<student: s2>
```

类似的,你可以用python的列表切片来获取数据

```python
>>> student.objects.order_by('sname')[0:2]
<QuerySet [<student: qaz>, <student: s2>]>
```

虽然不支持负索引,但是我们可以使用其他的方法,比如稍微修改`order_by()`语句来实现

```python
>>> student.objects.order_by('-sname')[0]
<student: yang>
```

### 更新多个对象

更改某一指定的列,我们可以调用结果集(QuerySet)对象的`update()`方法

```python
>>> student.objects.filter(id=2).update(sname='Hello')
1

# update()方法对于任何结果集(QuerySet)均有效,这意味着你可以同时更新多条记录,比如将所有实例的性别都改为女
>>> student.objects.all().update(gender='w')
4
```

`update()`方法会返回一个整型数值,表示受影响的记录条数

### 删除对象

删除数据库中的对象只需要调用该对象的`delete()`方法

删除指定数据

```python
>>> student.objects.all().filter(sname='yang').delete()
(1, {'darker.score': 0, 'darker.student': 1})
>>> student.objects.all()
<QuerySet [<student: Hello>, <student: qaz>, <student: s2>]>
```

删除所有数据

```python
>>> student.objects.all().delete()
(3, {'darker.score': 0, 'darker.student': 3})
>>> student.objects.all()
<QuerySet []>
```

### 字段属性

| 属性                                 | 描述                                       |
| ---------------------------------- | ---------------------------------------- |
| `models.AutoField`                 | 自增列，默认会生成一个id列，如果要显示的自定义一个自增列，必须将给列设置为主键`primary_key=True` |
| `models.CharField`                 | 字符串字段，必须有`max_length`参数                  |
| `models.BooleanField`              | 布尔类型，不能为空，`Blank=True`                   |
| `models.ComaSeparatedIntegerField` | 用逗号分割的数字，必须有`max_lenght`参数               |
| `models.DateField`                 | 日期类型,对于参数，`auto_now = True`则每次更新都会更新这个时间；`auto_now_add`则只是第一次创建添加，之后的更新不再改变 |
| `models.DateTimeField`             | 日期类型`datetime`同`DateField`的参数            |
| `models.Decimal`                   | 十进制小数类型，必须指定整数位`max_digits`和小数位`decimal_places` |
| `models.EmailField`                | 字符串类型（正则表达式邮箱）                           |
| `models.FloatField`                | 浮点类型                                     |
| `models.IntegerField`              | 整形                                       |
| `models.BigIntegerField`           | 长整形                                      |
| `models.IPAddressField`            | 字符串类型（ip4正则表达式）                          |
| `models.GenericIPAddressField`     | 字符串类型（ip4和ip6是可选的），参数protocol可以是：both、ipv4、ipv6，验证时，会根据设置报错 |
| `models.NullBooleanField`          | 允许为空的布尔类型                                |
| `models.PositiveIntegerFiel`       | 正Integer                                 |
| `models.PositiveSmallIntegerField` | 正smallInteger                            |
| `models.SlugField`                 | 减号、下划线、字母、数字                             |
| `models.SmallIntegerField`         | 数字，数据库中的字段有：tinyint、smallint、int、bigint  |
| `models.TextField`                 | 字符串                                      |
| `models.TimeField`                 | 时间                                       |
| `models.URLField`                  | 字符串，地址正则表达式                              |
| `models.BinaryField`               | 二进制                                      |
| `models.ImageField`                | 图片                                       |
| `models.FilePathField`             | 文件                                       |

### 属性所拥有的方法

| 方法                    | 描述                                |
| --------------------- | --------------------------------- |
| `null=True`           | 数据库中字段是否可以为空                      |
| `blank=True`          | django的 Admin 中添加数据时是否可允许空值       |
| `primary_key = False` | 主键，对AutoField设置主键后，就会代替原来的自增 id 列 |
| `auto_now`            | 自动创建---无论添加或修改，都是当前操作的时间          |
| `auto_now_add`        | 自动创建---永远是创建时的时间                  |
| `max_length`          | 最大值                               |
| `default`             | 默认值                               |
| `verbose_name`        | Admin中字段的显示名称                     |
| `name竖线db_column`     | 数据库中的字段名称                         |
| `unique=True`         | 不允许重复                             |
| `db_index = True`     | 数据库索引                             |
| `editable=True`       | 在Admin里是否可编辑                      |
| `error_messages=None` | 错误提示                              |
| `auto_created=False`  | 自动创建                              |
| `help_text`           | 在Admin中提示帮助信息                     |

### 连表结构

| 方法                            | 描述   |
| ----------------------------- | ---- |
| `models.ForeignKey(其他表)`      | 一对多  |
| `models.ManyToManyField(其他表)` | 多对多  |
| `models.OneToOneField(其他表)`   | 一对一  |

### 报错信息

```shell
django.db.utils.InternalError: (1366, "Incorrect string value: '\\xE7\\x94\\xB7' for column 'gender' at row 1")

原因,| yang     | CREATE DATABASE `yang` /*!40100 DEFAULT CHARACTER SET latin1 */ |
```

## 实战3

### 连表操作一对一

在 `app` 的**models.py**文件内添加一下内容用户创建一对多关系表

```python
class UserType(models.Model):
    nid = models.AutoField(primary_key=True)
    caption = models.CharField(max_length=32)

class UserInfo(models.Model):
    username = models.CharField(max_length=32)
    password = models.CharField(max_length=16)
    user_type = models.ForeignKey('UserType')
```

把app的名字添加到项目的`settings.py`配置文件的INSTALLED_APPS中,然后在数据库中生成表

```shell
➜  yangxxx git:(master) ✗ python3 manage.py makemigrations
Migrations for 'darker':
  darker/migrations/0002_auto_20170617_0902.py
    - Create model UserInfo
    - Create model UserType
    - Change Meta options on student
    - Add field user_type to userinfo
➜  yangxxx git:(master) ✗ python3 manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, darker, sessions
Running migrations:
  Applying darker.0002_auto_20170617_0902... OK
```

### 基本操作

```python
➜  yangxxx git:(master) ✗ python3 manage.py shell
Python 3.5.3 (v3.5.3:1880cb95a742, Jan 16 2017, 08:49:46)
[GCC 4.2.1 (Apple Inc. build 5666) (dot 3)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
(InteractiveConsole)
>>> from darker import models

# 通过create方式进行数据的添加
>>> models.UserType.objects.create(caption='superadmin')
<UserType: UserType object>
# 通过save保存的方式添加数据
>>> obj = models.UserType(caption='admin')
>>> obj.save()
```

```python
# 通过字典的方式进行数据添加
>>> UserInfoDict = {'username': 'yang','password': 'helloword','user_type': models.UserType.objects.get(nid=1)}

# 通过**UserInfoDict把数据以字典的方式传给create
>>> models.UserInfo.objects.create(**UserInfoDict)
<UserInfo: UserInfo object>
>>> UserInfoDict = {'username': 'qwe','password': 'xxxxxxxx','user_type': models.UserType.objects.get(nid=2)}
>>> models.UserInfo.objects.create(**UserInfoDict)
<UserInfo: UserInfo object>
```

```python
# 如果知道user_type_id代表多少,可以直接写数字
>>> UserInfoDict = {'username': 'yang','password': 'helloworld','user_type_id': 2}
>>> models.UserInfo.objects.create(**UserInfoDict)
<UserInfo: UserInfo object>
```

修改数据

```python
# 指定条件更新
>>> models.UserInfo.objects.filter(password='helloword').update(password='hw')
1

# 获取id=1的这条数据对象
>>> obj = models.UserInfo.objects.get(id=1)
# 修改username字段
>>> obj.username = 'as'
# 保存操作
>>> obj.save()
```

删除数据

```python
>>> models.UserInfo.objects.filter(username='as').delete()
(1, {'darker.UserInfo': 1})
```

查询数据

```python
# 查询单条数据,不存在则报错
>>> models.UserInfo.objects.get(id=2)
<UserInfo: UserInfo object>
>>> models.UserInfo.objects.get(id=5)
Traceback (most recent call last):
  File "<console>", line 1, in <module>
  File "/Library/Frameworks/Python.framework/Versions/3.5/lib/python3.5/site-packages/django/db/models/manager.py", line 85, in manager_method
    return getattr(self.get_queryset(), name)(*args, **kwargs)
  File "/Library/Frameworks/Python.framework/Versions/3.5/lib/python3.5/site-packages/django/db/models/query.py", line 380, in get
    self.model._meta.object_name
darker.models.DoesNotExist: UserInfo matching query does not exist.
```

```python
# 获取全部数据
>>> models.UserInfo.objects.all()
<QuerySet [<UserInfo: UserInfo object>, <UserInfo: UserInfo object>]>
```

```python
# 获取指定条件的数据
>>> models.UserInfo.objects.filter(username='qwe')
<QuerySet [<UserInfo: UserInfo object>]>
```

### 单表查询

查询出来的结果都是QuerySet对象

query方法是用来查看查询语句的,及Django生成的SQL

```python
>>> ret = models.UserType.objects.all()
>>> print(ret.query)
SELECT `darker_usertype`.`nid`, `darker_usertype`.`caption` FROM `darker_usertype`
```

values与values_list

```python
>>> ret = models.UserType.objects.all().values('nid')
# 返回的列表,列表里面套字典
>>> print(type(ret),ret)
<class 'django.db.models.query.QuerySet'> <QuerySet [{'nid': 1}, {'nid': 2}]>
```

```python
>>> ret = models.UserType.objects.all().values_list('nid')
# 返回一个列表,列表里面套集合
>>> print(type(ret),ret)
<class 'django.db.models.query.QuerySet'> <QuerySet [(1,), (2,)]>
```

双下划线连表操作

```python
>>> ret = models.UserInfo.objects.all().values('username','user_type__caption')
>>> print(ret.query)
SELECT `darker_userinfo`.`username`, `darker_usertype`.`caption` FROM `darker_userinfo` INNER JOIN `darker_usertype` ON (`darker_userinfo`.`user_type_id` = `darker_usertype`.`nid`)
```

```python
>>> ret = models.UserInfo.objects.all()
>>> for item in ret:
...   print(item,item.id,item.user_type.nid,item.user_type.caption,item.user_type_id)
...
UserInfo object 2 2 admin 2
UserInfo object 3 2 admin 2
```

### 查询实例

获取用户类型是超级管理员的所有用户

正向查找

通过双下划线连表查询

```python
>>> ret = models.UserInfo.objects.filter(user_type__caption = 'admin').values('username','user_type__caption')
>>> print(ret,type(ret),ret.query)
<QuerySet [{'username': 'qwe', 'user_type__caption': 'admin'}, {'username': 'yang', 'user_type__caption': 'admin'}]> <class 'django.db.models.query.QuerySet'> SELECT `darker_userinfo`.`username`, `darker_usertype`.`caption` FROM `darker_userinfo` INNER JOIN `darker_usertype` ON (`darker_userinfo`.`user_type_id` = `darker_usertype`.`nid`) WHERE `darker_usertype`.`caption` = admin
```

反向查找

先查找UserType表中数据,再把这个数据和UserInfo表中进行过滤

```python
>>> obj = models.UserType.objects.filter(caption= 'admin').first()
>>> print(obj.nid,obj.caption)
2 admin
>>> print(obj.userinfo_set.all())
<QuerySet [<UserInfo: UserInfo object>, <UserInfo: UserInfo object>]>
```

把UserType表里的所有字段和userinfo表进行一个匹配,如果有匹配到就显示出来

```python
>>> ret = models.UserType.objects.all().values('nid','caption','userinfo__username')
>>> print(ret)
<QuerySet [{'userinfo__username': 'qwe', 'nid': 2, 'caption': 'admin'}, {'userinfo__username': 'yang', 'nid': 2, 'caption': 'admin'}, {'userinfo__username': None, 'nid': 1, 'caption': 'superadmin'}]>
```

### 连表操作多对多

两种创建多对多表的方式

**手动指定第三张表进行创建**

```python
class HostGroup(models.Model):
    hgid = models.AutoField(primary_key=True)
    host_id = models.ForeignKey('Host')
    group_id = models.ForeignKey('Group')

class Host(models.Model):
    hid = models.AutoField(primary_key=True)
    hostname = models.CharField(max_length=32)
    ip = models.CharField(max_length=32)

class Group(models.Model):
    gid = models.AutoField(primary_key=True)
    name = models.CharField(max_length=16)

    h2g = models.ManyToManyField('Host',through='HostGroup')
```

```python
➜  yangxxx git:(master) ✗ python3 manage.py makemigrations
Migrations for 'darker':
  darker/migrations/0003_auto_20170619_0137.py
    - Create model Group
    - Create model Host
    - Create model HostGroup
    - Add field h2g to group
➜  yangxxx git:(master) ✗ python3 manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, darker, sessions
Running migrations:
  Applying darker.0003_auto_20170619_0137... OK
```

**django帮我们创建第三张表**

创建一下表关系用于测试多对多

```python
class Host(models.Model):
    hid = models.AutoField(primary_key=True)
    hostname = models.CharField(max_length=32)
    ip = models.CharField(max_length=32)

class Group(models.Model):
    gid = models.AutoField(primary_key=True)
    name = models.CharField(max_length=16)
    # 任意一个字段，会自动生成第三张表，且第三张表会自动的添加联合唯一索引，Unique
    h2g = models.ManyToManyField('Host')
```

----

插入数据测试

```python
# Host插入数据
>>> from darker import models
>>> models.Host.objects.create(hostname='localhost',ip='192.168.1.1')
<Host: Host object>
>>> models.Host.objects.create(hostname='linux-node1',ip='192.168.1.2')
<Host: Host object>
>>> models.Host.objects.create(hostname='linux-node2',ip='192.168.1.3')
<Host: Host object>
>>> models.Host.objects.create(hostname='web-node1',ip='192.168.1.4')
<Host: Host object>
```

```python
# Group插入数据
>>> models.Group.objects.create(name='markte dep')
<Group: Group object>
>>> models.Group.objects.create(name='sales dep')
<Group: Group object>
>>> models.Group.objects.create(name='tec dep')
<Group: Group object>
```

单个添加数据

```python
>>> obj = models.Group.objects.get(name='tec dep')
>>> obj.gid, obj.name
(4, 'tec dep')
# 获取第三张表的内容
>>> obj.h2g.all()
<QuerySet []>
>>> h1 = models.Host.objects.get(hid=2)
>>> h1.ip
'192.168.1.2'
>>> obj.h2g.add(h1)
Traceback (most recent call last):
  File "<console>", line 1, in <module>
  File "/Library/Frameworks/Python.framework/Versions/3.5/lib/python3.5/site-packages/django/db/models/fields/related_descriptors.py", line 929, in add
    (opts.app_label, opts.object_name)
AttributeError: Cannot use add() on a ManyToManyField which specifies an intermediary model. Use darker.HostGroup's Manager instead.
```

### 批量导入bulk_create()

`User.objects.create()`每保存一条就执行一次SQL

`bulk_create()`是执行一条SQL存入多条数据，做会快很多！能用列表解析代替 for 循环就使用列表解析

如果导入数据重复时,只需要使用 `User.objects.get_or_create(title=title,content=content)`

`python_code/xxx/django_xxx/menjin/create_records.py`

```python
...
    user_card_dic = {}
    for tup in rows:
        if tup[2] in user_card_dic.keys():
            user_card_dic[tup[2]]["DoorName"] += "," + tup[0]
        else:
            tmp_dict = {}
            tmp_dict["DoorName"] = tup[0]
            tmp_dict["ConsumerName"] = tup[1]
            tmp_dict["CardNO"] = tup[2]
            tmp_dict["ConsumerID"] = tup[3]
            tmp_dict["GroopName"] = tup[4]
            user_card_dic[tup[2]] = tmp_dict
            #user_list.append(tmp_dict)
    #print(user_card_dic)
    user_object_list = []
    for user in user_card_dic.values():
        # user # {'ConsumerID': 700, 'ConsumerName': '张三', 'GroopName': '内部运营\\行政', 'DoorName': 'xxF-办公区', 'CardNO': 102999}
        print(user)
        user_object_list.append(User(**user))
    print(user_object_list)
    print(len(user_object_list))
    #print(user_list)

    # User.objects.bulk_create(user_object_list)
```
