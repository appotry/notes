# Tutorial

本教程里面, 我们会创建一个简单的微博应用. 它仅支持一个用户, 可以创建文本条目, 没有提要和评论, 但是它仍然有我们需要的一切. 我们将使用`Flask`和`SQLite`.

示例代码 [example source](https://github.com/pallets/flask/tree/master/examples/flaskr/).

## 介绍Flaskr

我们将博客命名为Flaskr, 基本上, 它将实现这些功能:

1. 允许用户使用配置文件里面指定的凭证登录登出, 只支持一个用户.
2. 用户登录时, 可以新增条目到页面(包含文本标题以及一些HTML文本), 因为用户可信任, 这部分HTML文本不做审查,.
3. 首页倒序显示所有条目, 并且用户登录后可在这里添加新条目.

我们会直接使用`SQLite3`, 因为它足够应付这个应用. 对于大型项目可以使用 [SQLAlchemy](http://www.sqlalchemy.org/), 它可以智能的处理数据库连接, 允许你同时连接不同的关系型数据库. 如果你的数据更适合`NoSQL`, 你也可以考虑流行的`NoSQL`数据库.

这是应用最终的效果图

![python-flask-01](http://oi480zo5x.bkt.clouddn.com/python-flask-01.jpg)

## 步骤0: 创建目录

项目开始之前, 我们需要先将目录创建好

```shell
/flaskr
    /flaskr
        /static
        /templates
```

推荐使用Python包进行安装和运行应用.  稍后你可以看到怎么运行`flaskr` 现在继续创建应用目录结构. 接下来几个步骤将要创建数据库表结构以及主要模块.

`static`目录用来存放静态文件, 比如CSS, JavaScript, 通过HTTP的方式提供给用户.`templates`目录将用来存放 [Jinja2](http://jinja.pocoo.org/) 模板.

## 步骤1: 数据库配置

我们的应用只需要一张表, 将如下内容写到一个`schema.sql`文件, 并存放到`flaskr/flaskr`目录

```sql lite
drop table if exists entries;
create table entries (
  id integer primary key autoincrement,
  title text not null,
  'text' text not null
);
```

表名为`entries`, 有`id`, `title`, `text` 列, `id`列为自增主键.

## 步骤2: 应用安装代码

在`flaskr/flaskr`目录创建一个`flaskr.py`

```python
# all the imports
import os
import sqlite3
from flask import Flask, request, session, g, redirect, url_for, abort, \
     render_template, flash
```

The next couple lines will create the actual application instance and initialize it with the config from the same file in `flaskr.py`:

```python
app = Flask(__name__) # create the application instance :)
app.config.from_object(__name__) # load config from this file , flaskr.py

# Load default config and override config from an environment variable
app.config.update(dict(
    DATABASE=os.path.join(app.root_path, 'flaskr.db'),
    SECRET_KEY='development key',
    USERNAME='admin',
    PASSWORD='default'
))
app.config.from_envvar('FLASKR_SETTINGS', silent=True)
```

## 步骤3: 安装flaskr

```shell
/flaskr
    /flaskr
        __init__.py
        /static
        /templates
        flaskr.py
        schema.sql
    setup.py
    MANIFEST.in
```

The content of the `setup.py` file for `flaskr` is:

```Python
from setuptools import setup

setup(
    name='flaskr',
    packages=['flaskr'],
    include_package_data=True,
    install_requires=[
        'flask',
    ],
)
```

当使用setuptools工具时, 还需要将一些特殊文件及目录添加到包里面(`MANIFEST.in`). 在这种情况下, `static` 和 `templates`目录需要被包含进来, 同时还有`schema.sql`, 创建文件`MANIFEST.in` 并添加如下内容.

```python
graft flaskr/templates
graft flaskr/static
include flaskr/schema.sql
```

简化定位应用程序, 添加如下内容到`flaskr/__init__.py`:

```Python
from .flaskr import app
```
这个导入语句将把应用程序实例放在包顶部. 当运行应用程序的时候, Flask开发服务器需要定位app实例. 这个导入语句简化了定位过程. 如果没有这句, 下面的`export`语句需要改成 `export FLASK_APP=flaskr.flaskr`.

此时, 可以安装应用程序了, 通常, 推荐在虚拟环境下安装Flask应用. 继续安装应用:

```shell
pip install --editable .
```

上面的命令需要在项目根目录下执行`flaskr/`. 可编辑标记允许编辑源代码, 而无需在每次修改之后重新安装Flask应用, 此时Flask应用已经安装在你的虚拟环境中(具体可以查看`pip freeze`的输出)

完成上面这些步骤之后, 就可以使用下面的没给你了那个启动你的应用了.

```shell
export FLASK_APP=flaskr
export FLASK_DEBUG=true
flask run
```

(如果在Windows上, 你需要使用`set`代替`export`). `FLASK_DEBUG`用于启用或禁用交互式调试器. 永远不要在生产环境使用调试模式, 因为这会允许用户在服务器上执行代码.

你将可以看到一些消息, 你可以使用对应的地址访问它.

```shell
 * Serving Flask app "flaskr"
 * Forcing debug mode on
 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
 * Restarting with stat
 * Debugger is active!
 * Debugger PIN: 669-527-819
```

当你使用浏览器访问的时候, 浏览器会返回一个404错误, 因为我们还没有编写视图函数. 稍后我们会编写, 在这之前需要先让数据库工作.

> 服务器外部可见

如果想让你的服务器外部课件, 可以参考 [externally visible server](http://flask.pocoo.org/docs/0.12/quickstart/#public-server).

## 步骤4: 数据库连接

你现在有一个函数`connect_db`与数据库建立连接, 但本身不是特别有用. 不断创建和关闭数据库连接效率非常低, 所以你需要让它保持长连接. 因为数据库连接封装了事务, 你需要确保一次只有一个请求使用这个连接. 一种优雅的方式就是利用程序环境.

Flask提供两个环境: 应用环境(Application Context), 请求环境(Request Context). 不同环境有不同的特殊变量. 例如,  `request`变量与当前请求的请求对象有关. 而`g`是与当前应用环境有关的通用变量. 之后会深入了解`g`

那么你何时把数据库连接放到上面? 我们可以编写一个辅助函数. 在函数第一次被调用时, 它将为当前环境创建一个数据库连接, 调用成功后返回已经建立的连接.

```python
def get_db():
    """Opens a new database connection if there is none yet for the
    current application context.
    """
    if not hasattr(g, 'sqlite_db'):
        g.sqlite_db = connect_db()
    return g.sqlite_db
```

现在我们知道怎么连接数据库, 但我们应该如何正确断开呢? Flask提供了[`teardown_appcontext()`](http://flask.pocoo.org/docs/0.12/api/#flask.Flask.teardown_appcontext) 装饰器. 它会在应用环境销毁时执行:

```python
@app.teardown_appcontext
def close_db(error):
    """Closes the database again at the end of the request."""
    if hasattr(g, 'sqlite_db'):
        g.sqlite_db.close()
```

装饰器 [`teardown_appcontext()`](http://flask.pocoo.org/docs/0.12/api/#flask.Flask.teardown_appcontext) 标记的函数, 每次在应用环境销毁的时候执行, 这意味着什么? 本质上, 应用环境在请求到来之前被创建, 在请求结束时被销毁. 销毁有两种原因: 一切正常 (错误参数为`None`) 或发生异常, 第二种情况, 错误会被传递给销毁时调用的函数.

好奇环境的意义? [The Application Context](http://flask.pocoo.org/docs/0.12/appcontext/#app-context).

> 提示

我该把这段代码放在哪里?

如果你一直遵循本教程, 你可能想知道这步骤以及之后产生的代码放在什么地方. 逻辑上讲, 应该按模块来组织函数, 即把新的函数`get_db`和`close_db`函数放在之前的`connect_db`函数下面.

如果你想找准定位, 可以查看一下示例代码. 在Flask里面, 你可以把所有代码放在单一的python模块里, 但是当你的应用规模扩大时, 这不是一个好主意.

[example source](https://github.com/pallets/flask/tree/master/examples/flaskr/)  [grows larger](http://flask.pocoo.org/docs/0.12/patterns/packages/#larger-applications)

## 步骤5: 创建数据库

如前面介绍所说, Flasker是一个数据库驱动的应用程序. 更准确地说, 它是一个由关系型数据库系统驱动的应用程序. 这样的系统需要一个模式来决定存储信息的方式. 所以在第一次启动服务的时候, 需要创建schema.

可以通过管道把`schema.sql`作为sqlite3命令来创建.

```shell
sqlite3 /tmp/flaskr.db < schema.sql
```

但是执行该命令需要安装`sqlite3`命令, 而并不是所有的系统都会安装这个. 同时它也要求你需要提供数据库路径, 否则将会报错. 我们可以使用一个函数来初始化, 比使用上面的命令更好, 更方便.

在`flaskr.py connect_db函数前面` 创建一个`init_db()`函数

```python
def init_db():
    db = get_db()
    with app.open_resource('schema.sql', mode='r') as f:
        db.cursor().executescript(f.read())
    db.commit()

@app.cli.command('initdb')
def initdb_command():
    """Initializes the database."""
    init_db()
    print('Initialized the database.')
```

`app.cli.command()` 装饰器会使用 **flask** 脚本注册一个新的命令. 当命令执行的时候, Flask 会自动创建一个应用环境绑定到正确的应用. 使用这个函数, 你可以访问 [`flask.g`](http://flask.pocoo.org/docs/0.12/api/#flask.g) 以及其他你期望的东西. 当脚本结束的时候, 应用环境会被销毁, 数据库连接会被释放.

你会想要一个真正的函数初始化数据库, 尽管, 我们可以在单元测试里面轻松的创建数据库. (更多信息 [Testing Flask Applications](http://flask.pocoo.org/docs/0.12/testing/#testing).)

应用对象的[`open_resource()`](http://flask.pocoo.org/docs/0.12/api/#flask.Flask.open_resource)方法是一个辅助函数, 用来打开应用程序所提供的资源. 这个方法从资源位置 ( `flaskr/flaskr` 目录) 打开文件并允许我们阅读. 在本例中用于在数据库连接执行一个脚本.

SQLite提供的连接对象可以给你一个游标对象. 在这个游标里, 有一个方法执行完整的脚本. 最后, 你只需要提交改变. SQLite3和其他事务数据库在你没有明确表示要提交的时候, 不会进行提交.

现在, 可以使用**flask**创建数据库

```shell
flask initdb
Initialized the database.
```

> 故障排除

在你执行命令之后, 得到一个异常, 发现表没有被创建, 此时你可以检查`init_db`命令, 以及你的表名是否正确(比如,单数和复数)

## 步骤6: 视图函数

现在数据库正常, 你可以开始编写视图函数.

### 显示所有条目

这个视图显示数据库存储的所有条目. 它监听`/`, 应用将会从数据库查询`title`, `text`. 新的条目会显示在页面上面. 返回的行看上去有点像字典, 因为我们使用了`sqlite3.Row`.

这视图函数将返回`show_entries.html`模板, 并传递`entries`变量.

```python
@app.route('/')
def show_entries():
    db = get_db()
    cur = db.execute('select title, text from entries order by id desc')
    entries = cur.fetchall()
    return render_template('show_entries.html', entries=entries)
```

### 新增条目

这个视图函数在用户登录的前提下, 允许用户新增项目. 该视图仅响应`POST`请求, 表单显示在`show_entries`页面. 如果一切正常, 它将在下一次请求的时候`flash()`一条信息, 并重定向到`show_entries`.

```python
@app.route('/add', methods=['POST'])
def add_entry():
    if not session.get('logged_in'):
        abort(401)
    db = get_db()
    db.execute('INSERT INTO entries (title, text) VALUES (?, ?)',
               [request.form['title'], request.form['text']])
    db.commit()
    flash('New entry was successfully posted')
    return redirect(url_for('show_entries'))
```

注意, 这个视图检查用户是否登录(也就是说, 如果`logged_in`键存在于`session`,并且为`True`)

> 安全事项

在构建SQL语句的时候, 一定要使用`?`做占位符, 否则应用程序使用字符串构建时容易受到SQL注入,更多信息[Using SQLite 3 with Flask](http://flask.pocoo.org/docs/0.12/patterns/sqlite3/#sqlite3).

### 登录登出

这个函数用于登录用户以及退出. 登录时从配置里检查用户名和密码, 并设置`logged_in`键值, 如果用户登录成功, 设置为`True`, 用户将被重定向到`show_entries`页面, 同时会闪现一条消息, 提示用户登录成功. 如果发生错误, 会提示用户相关信息, 并要求用户重新输入.

```python
@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        if request.form['username'] != app.config['USERNAME']:
            error = 'Invalid username'
        elif request.form['password'] != app.config['PASSWORD']:
            error = 'Invalid password'
        else:
            session['logged_in'] = True
            flash('You were logged in')
            return redirect(url_for('show_entries'))
    return render_template('login.html', error=error)
```

`logout`函数, 会删除`session`中的`logged_in`key, 这里有一个窍门: 如果使用`pop()`方法并传递一个参数(默认), 如果存在该key这个方法将会从字典删除这个key,如果key不存在,则什么都不做. 这样就不需要检查用户是否登录.

```python
@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    flash('You were logged out')
    return redirect(url_for('show_entries'))
```

> 安全事项

密码不能使用纯文本存储, 本教程只是为了简单起见,. 如果你计划基于该项目发布一个项目, 密码应该使用散列并且加盐存储在数据库或文件里.  [hashed and salted](https://blog.codinghorror.com/youre-probably-storing-passwords-incorrectly/).

幸运的是, Flask有扩展插件, 所以添加这个功能很简单, 同时, python也有很多库可用于散列.

[Flask推荐的插件](http://flask.pocoo.org/extensions/)

## 步骤7: 模板

是时候使用模板了. 你可能会注意到, 当运行app的时候, 会触发异常, 提示Flask无法找到模板. Flask默认启用 [Jinja2](http://jinja.pocoo.org/docs/templates) 模板 . 这意味着除非你使用 [`Markup`](http://flask.pocoo.org/docs/0.12/api/#flask.Markup) 标记一段代码或者在模板中使用 `|safe` 过滤器,  否则Jinja2将自动转义, 确保特殊字符, 例如 `<` or `>` 被转义为等价的XML实体.

我们也会使用模板继承, 在所有网页中重用布局.

将下面的模板放置在`templates`目录

### layout.html

这个模板包含HTML主体, 标题,  和登录链接(如果用户已经登录, 则提供登出功能). 如果有, 也会显示闪现消息.  `{% block body %}` 将被子模板中的同名`blcok` (`body`)替换.

**session**字典在模板中也是可用的, 你可以用来检查, 用户是否登录. Jinja支持访问不存在的属性,对象/字典属性或成员, 即便`logged_in`key不存在.

```html
<!doctype html>
<title>Flaskr</title>
<link rel=stylesheet type=text/css href="{{ url_for('static', filename='style.css') }}">
<div class=page>
  <h1>Flaskr</h1>
  <div class=metanav>
  {% if not session.logged_in %}
    <a href="{{ url_for('login') }}">log in</a>
  {% else %}
    <a href="{{ url_for('logout') }}">log out</a>
  {% endif %}
  </div>
  {% for message in get_flashed_messages() %}
    <div class=flash>{{ message }}</div>
  {% endfor %}
  {% block body %}{% endblock %}
</div>
```

### show_entries.html

这个模板扩充`layout.html`模板. 注意`for`循环会遍历我们使用`render_template()`传入的变量. 配置表单提交到`add_entry`视图, 并且使用`POST`方法.

```html
{% extends "layout.html" %}
{% block body %}
  {% if session.logged_in %}
    <form action="{{ url_for('add_entry') }}" method=post class=add-entry>
      <dl>
        <dt>Title:
        <dd><input type=text size=30 name=title>
        <dt>Text:
        <dd><textarea name=text rows=5 cols=40></textarea>
        <dd><input type=submit value=Share>
      </dl>
    </form>
  {% endif %}
  <ul class=entries>
  {% for entry in entries %}
    <li><h2>{{ entry.title }}</h2>{{ entry.text|safe }}
  {% else %}
    <li><em>Unbelievable.  No entries here so far</em>
  {% endfor %}
  </ul>
{% endblock %}
```

### login.html

登录模板, 仅仅显示一个form表达, 供用户登录.

```html
{% extends "layout.html" %}
{% block body %}
  <h2>Login</h2>
  {% if error %}<p class=error><strong>Error:</strong> {{ error }}{% endif %}
  <form action="{{ url_for('login') }}" method=post>
    <dl>
      <dt>Username:
      <dd><input type=text name=username>
      <dt>Password:
      <dd><input type=password name=password>
      <dd><input type=submit value=Login>
    </dl>
  </form>
{% endblock %}
```

## 添加风格

给应用添加风格, 在 `static` 目录下创建一个 `style.css`样式表.

```css
body            { font-family: sans-serif; background: #eee; }
a, h1, h2       { color: #377ba8; }
h1, h2          { font-family: 'Georgia', serif; margin: 0; }
h1              { border-bottom: 2px solid #eee; }
h2              { font-size: 1.2em; }

.page           { margin: 2em auto; width: 35em; border: 5px solid #ccc;
                  padding: 0.8em; background: white; }
.entries        { list-style: none; margin: 0; padding: 0; }
.entries li     { margin: 0.8em 1.2em; }
.entries li h2  { margin-left: -1em; }
.add-entry      { font-size: 0.9em; border-bottom: 1px solid #ccc; }
.add-entry dl   { font-weight: bold; }
.metanav        { text-align: right; font-size: 0.8em; padding: 0.3em;
                  margin-bottom: 1em; background: #fafafa; }
.flash          { background: #cee5F5; padding: 0.5em;
                  border: 1px solid #aacbe2; }
.error          { background: #f0d6d6; padding: 0.5em; }
```

## 测试应用

现在已经完成应用,一切如如预期一样正常. 添加自动化测试来简化将来的修改是一个不错的主意. 上面的应用程序作为一个基本的例子, 用来介绍单元测试,可以查看 [Testing Flask Applications](http://flask.pocoo.org/docs/0.12/testing/#testing). 通过这个可以看到测试Flask应用多么容易.

### 添加测试到flaskr

假设你已经看了 [Testing Flask Applications](http://flask.pocoo.org/docs/0.12/testing/#testing), 并且已经为`flaskr`编写字自己的测试, 或者跟随示例提供的方法进行了测试. 你可能会想知道如何组织项目.

推荐使用下面结构

```shell
flaskr/
    flaskr/
        __init__.py
        static/
        templates/
    tests/
        test_flaskr.py
    setup.py
    MANIFEST.in
```

现在继续创建 `tests/` 目录以及 `test_flaskr.py` 文件.

### 运行测试

你可以运行测试, 这里将使用`pytest`

> 注意

确保你在开发`flaskr`的虚拟环境已经安装`pytest`. 否则`pytest`将无法导入依赖的组件来测试应用

```shell
pip install -e .
pip install pytest
```

运行以及观看测试过程,在项目根目录下执行

```shell
py.test
```

### Testing + setuptools

处理测试的一种方法就是使用`setuptools`集成, 它依赖一些设置. 我们在`setup.py`里面添加一些内容, 并常见一个`setup.cfg`文件, 以这种方式测试的好处是你不需要安装`pytest`.继续并更新`setup.py`.

```python
from setuptools import setup

setup(
    name='flaskr',
    packages=['flaskr'],
    include_package_data=True,
    install_requires=[
        'flask',
    ],
    setup_requires=[
        'pytest-runner',
    ],
    tests_require=[
        'pytest',
    ],
)
```

项目根目录下创建`setup.cfg` 文件 (跟 `setup.py`处于同一级目录):

```python
[aliases]
test=pytest
```

现在可以运行

```shell
python setup.py test
```

This calls on the alias created in `setup.cfg` which in turn runs `pytest` via `pytest-runner`, as the `setup.py` script has been called. (Recall the setup_requires argument in `setup.py`) Following the standard rules of test-discovery your tests will be found, run, and hopefully pass.

This is one possible way to run and manage testing. Here `pytest` is used, but there are other options such as `nose`. Integrating testing with `setuptools` is convenient because it is not necessary to actually download `pytest` or any other testing framework one might use.