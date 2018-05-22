contextlib
==========

在Python中操作文件可以使用\ ``try...finally``\ 写\ ``try...finally``\ 非常繁琐。Python的with语句允许我们非常方便地使用资源，而不必担心资源没有关闭

.. code:: python

    with open('/path/to/file', 'r') as f:
        f.read()

并不是只有open()函数返回的fp对象才能使用with语句。实际上，任何对象，只要正确实现了上下文管理，就可以用于with语句。

实现上下文管理是通过\ ``__enter__``\ 和\ ``__exit__``\ 这两个方法实现的。例如，下面的class实现了这两个方法

.. code:: python

    class Query:
        def __init__(self,name):
            self.name = name

        def __enter__(self):
            print('Begin')
            return self

        def __exit__(self, exc_type, exc_val, exc_tb):
            if exc_type:
                print('Error')
            else:
                print('End')

        def query(self):
            print('Query info about %s ... ' % self.name)


    with Query('Bob') as q:
        q.query()

@contextmanager
---------------

编写\ ``__enter__``\ 和\ ``__exit__``\ 仍然很繁琐，因此Python的标准库\ ``contextlib``\ 提供了更简单的写法，上面的代码可以改写如下：

.. code:: python

    from contextlib import contextmanager

    class Query(object):

        def __init__(self,name):
            self.name = name

        def query(self):
            print('Query info about %s...' % self.name)

    @contextmanager
    def create_query(name):
        print('Begin')
        q = Query(name)
        yield q
        print('End')


    with create_query('Bob') as q:
        q.query()
