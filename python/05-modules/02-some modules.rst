一些模块
========

Celery
------

**Distributed Task Queue**

`Celery <http://docs.celeryproject.org/en/master/index.html#>`__ is a
simple, flexible, and reliable distributed system to process vast
amounts of messages, while providing operations with the tools required
to maintain such a system.

It’s a task queue with focus on real-time processing, while also
supporting task scheduling.

Celery has a large and diverse community of users and contributors, you
should come join us `on
IRC <http://docs.celeryproject.org/en/master/getting-started/resources.html#irc-channel>`__
or `our
mailing-list <http://docs.celeryproject.org/en/master/getting-started/resources.html#mailing-list>`__.

Celery is Open Source and licensed under the `BSD
License <http://www.opensource.org/licenses/BSD-3-Clause>`__.

docopt
------

用于参数解析的Python三方库

http://docopt.org/

https://github.com/docopt/docopt

six
---

**Python 2 and 3 compatibility utilities**

https://pypi.python.org/pypi/six

Gunicorn
--------

**WSGI server**

`http://docs.gunicorn.org <http://docs.gunicorn.org/>`__.

Pexpect
-------

**Pexpect allows easy control of interactive console applications.**

https://github.com/pexpect/pexpect

Pexpect makes Python a better tool for controlling other applications.

Pexpect is a pure Python module for spawning child applications;
controlling them; and responding to expected patterns in their output.
Pexpect works like Don Libes’ Expect. Pexpect allows your script to
spawn a child application and control it as if a human were typing
commands.

subprocess
----------

**Subprocess management**

```subprocess`` <https://docs.python.org/3.5/library/subprocess.html#module-subprocess>`__

The subprocess module allows you to spawn new processes, connect to
their input/output/error pipes, and obtain their return codes. This
module intends to replace several older modules and functions:

tablib
------

Pythonic Tabular Datasets

数据导出为XLS, CSV, JSON, YAML格式等等

-  `The Tablib Website <http://docs.python-tablib.org/>`__
-  `Tablib @ PyPI <http://pypi.python.org/pypi/tablib>`__
-  `Tablib @ GitHub <http://github.com/kennethreitz/tablib>`__

inspect
-------

click
-----

**Click is a command line library for Python.**

-  `The Click Website <http://click.pocoo.org/>`__
-  `Click @ PyPI <http://pypi.python.org/pypi/click>`__
-  `Click @ github <http://github.com/mitsuhiko/click>`__

``__future__``
--------------

Python提供了__future__模块，把下一个新版本的特性导入到当前版本，于是我们就可以在当前版本中测试一些新版本的特性。

Excel
-----

http://www.python-excel.org/

在处理excel数据时发现了xlwt的局限性–不能写入超过65535行、256列的数据（因为它只支持Excel
2003及之前的版本，在这些版本的Excel中行数和列数有此限制），这对于实际应用还是不够的。

openpyxl支持07/10/13版本Excel的, 功能很强大,
但是操作起来感觉没有xlwt方便.

-  读取Excel时，选择openpyxl和xlrd 都能满足需求.
-  写入少量数据且存为xls格式文件时, 用xlwt更方便.
-  写入大量数据（超过xls格式限制）或者必须存为xlsx格式文件时，使用openpyxl了.

xlrd
~~~~

读写Excel, 但是写操作会有一些问题. 用xlrd进行读取比较方便,
流程和平时都手操作Excel一样, 打开工作簿(Workbook), 选择工作表(sheets),
然后操作单元格(cell)

xlwt
~~~~

openpyxl
~~~~~~~~

https://openpyxl.readthedocs.io/en/default/

xlsxwriter
~~~~~~~~~~

https://openpyxl.readthedocs.io/en/default/

https://github.com/jmcnamara/XlsxWriter

db
--

pyodbc
~~~~~~

https://docs.scrapy.org/en/latest/index.html

爬虫
----

beautifulsoup4
~~~~~~~~~~~~~~

https://pypi.python.org/pypi/beautifulsoup4

`doc <https://www.crummy.com/software/BeautifulSoup/bs4/doc/>`__
