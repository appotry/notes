queue
=====

https://docs.python.org/3/library/queue.html

**``queue``\ 模块定义了如下类, 以及异常.**

-  class ``queue.Queue(maxsize=0)``

``FIFO``\ 先进先出队列. ``maxsize``\ 是一个整数, 限制队列最大值.
当队列大小达到最大值, 会导致阻塞插入. 当\ ``maxsize``\ 小于或等于0,
队列大小无限.

-  class ``queue.LifoQueue(maxsize=0)``

``LIFO``\ 后进先出队列. ``maxsize``\ 作用同上.

-  class ``queue.PriorityQueue(maxsize=0)``

``priority queue``\ 优先队列. ``maxsize``\ 作用同上.

优先值最小的, 最先出队,
优先值通过\ ``sorted(list(entries))[0]``\ 排序获得,
返回的第一个即为最小值.
典型的参数为一个元组\ ``(priority_number, data)``.

-  exception ``queue.Empty``

当队列为空, 使用
```get()`` <https://docs.python.org/3/library/queue.html#queue.Queue.get>`__
(或者
```get_nowait()`` <https://docs.python.org/3/library/queue.html#queue.Queue.get_nowait>`__)方法,
不阻塞的时候会触发该异常, ``queue.Empty``.

如果队列为空, 使用\ ``get()``\ 方法的时候, 会导致阻塞,
可以使用\ ``timeout``\ 参数, 设定超时时间.

-  exception ``queue.Full``

当队列已满, 使用
```put()`` <https://docs.python.org/3/library/queue.html#queue.Queue.put>`__
(或
```put_nowait()`` <https://docs.python.org/3/library/queue.html#queue.Queue.put_nowait>`__)方法,
不阻塞的时候会触发该异常, ``queue.Full``

**Queue对象
(```Queue`` <https://docs.python.org/3/library/queue.html#queue.Queue>`__,
```LifoQueue`` <https://docs.python.org/3/library/queue.html#queue.LifoQueue>`__,
or
```PriorityQueue`` <https://docs.python.org/3/library/queue.html#queue.PriorityQueue>`__)
提供了如下公共方法.**

队列方法
--------

Queue.qsize()
~~~~~~~~~~~~~

返回队列的近似大小. 注意, ``qsize() > 0`` 不能保证随后的 ``get()``
不阻塞, ``qsize() < maxsize`` 也不能保证 ``put()`` 不阻塞.

Queue.empty()
~~~~~~~~~~~~~

如果队列为空, 返回\ ``True``, 否则返回\ ``False``. 如果
``empty()``\ 但会\ ``True``\ 不能保证随后调用\ ``put()``\ 不阻塞.
同样地, 如果\ ``empty()`` 返回 ``False`` 同样不能随后调用 ``get()``
不阻塞.

Queue.full()
~~~~~~~~~~~~

如果队列满了, 返回 ``True``, 否则返回 ``False``. 如果 ``full()`` 返回
``True`` 不能保证随后调用 ``get()``\ 不阻塞. 同样地, 如果 ``full()``
返回 ``False`` 不能保证随后调用 ``put()`` 不阻塞.

Queue.put(item, block=True, timeout=None)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

在队尾插入一个项目, ``item``\ 为必需的, 为插入项目的值. 如果可选参数
``block`` 为 ``true`` 并且 ``timeout`` 为 ``None`` (默认值),
队列会一直阻塞, 知道有位置可用. 如果 ``timeout`` 是一个正数,
在放入项目的时候, 队列没有可用的空间, 它最多阻塞 ``timeout`` 传入的秒数,
之后会触发
```Full`` <https://docs.python.org/3/library/queue.html#queue.Full>`__
异常. 反之 (``block`` 为 ``False``), 如果有空间可用将立刻放入项目,
否则触发
```Full`` <https://docs.python.org/3/library/queue.html#queue.Full>`__
异常 (这种情况下``timeout``\ 参数会被忽略).

Queue.put_nowait(item)
~~~~~~~~~~~~~~~~~~~~~~

等价于 ``put(item, False)``.

Queue.get(block=True, timeout=None)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

从队头删除并返回一个项目, ``block``\ 为是否阻塞,
``timeout``\ 为等待时间. 如果可选参数 ``block``\ is ``True`` 并且
``timeout`` 为 ``None`` (默认值), 阻塞知道有项目可用.
如果\ ``timeout``\ 为正数, 在队列没有项目可用的时候,
它最多阻塞\ ``timeout``\ 传入的秒数, 之后会触发
```Empty`` <https://docs.python.org/3/library/queue.html#queue.Empty>`__
异常. 反之 (``block`` 为 ``False``), 项目可用直接返回, 否则触发
```Empty`` <https://docs.python.org/3/library/queue.html#queue.Empty>`__
异常 (这种情况下``timeout``\ 参数被忽略).

Queue.get_nowait()
~~~~~~~~~~~~~~~~~~

相当于 ``get(False)``.

两个方法用于支持追踪入队任务是否被消费者线程完整地处理.

Two methods are offered to support tracking whether enqueued tasks have
been fully processed by daemon consumer threads.

Queue.task_done()
~~~~~~~~~~~~~~~~~

表明之前入队的任务完成了. 被用于队列消费者线程. 每个
```get()`` <https://docs.python.org/3/library/queue.html#queue.Queue.get>`__
用于获取一个任务,
随后调用\ ```task_done()`` <https://docs.python.org/3/library/queue.html#queue.Queue.task_done>`__
告诉队列任务完成. 如果此时使用
```join()`` <https://docs.python.org/3/library/queue.html#queue.Queue.join>`__
, 会导致线程阻塞, 当所有项目完成, 线程恢复, 不再阻塞
(意味着放入队列的每个项目都收到了
```task_done()`` <https://docs.python.org/3/library/queue.html#queue.Queue.task_done>`__
调用).

Raises a
```ValueError`` <https://docs.python.org/3/library/exceptions.html#ValueError>`__
if called more times than there were items placed in the queue.

q.join() 实际上意味着等到队列为空，再执行别的操作

Queue.join()
~~~~~~~~~~~~

阻塞, 直到队列里面的所有项目被获取并处理完成. 未完成的任务有一个计数器,
项目入队, 计数器增加. 当消费者线程调用
```task_done()`` <https://docs.python.org/3/library/queue.html#queue.Queue.task_done>`__
表明该项目完成, 计数器减少. 当计数器下降至0,
```join()`` <https://docs.python.org/3/library/queue.html#queue.Queue.join>`__\ 不再阻塞.

实例
----

等待队列完成任务.

.. code:: python

    def worker():
        while True:
            item = q.get()
            if item is None:
                break
            do_work(item)
            q.task_done()

    q = queue.Queue()
    threads = []
    for i in range(num_worker_threads):
        t = threading.Thread(target=worker)
        t.start()
        threads.append(t)

    for item in source():
        q.put(item)

    # block until all tasks are done
    q.join()

    # stop workers
    for i in range(num_worker_threads):
        q.put(None)
    for t in threads:
        t.join()

其他
----

-  Class
   ```multiprocessing.Queue`` <https://docs.python.org/3/library/multiprocessing.html#multiprocessing.Queue>`__

``queue``\ 类, 用于多进程(而不是多线程)上下文.

```collections.deque`` <https://docs.python.org/3/library/collections.html#collections.deque>`__
is an alternative implementation of unbounded queues with fast atomic
```append()`` <https://docs.python.org/3/library/collections.html#collections.deque.append>`__
and
```popleft()`` <https://docs.python.org/3/library/collections.html#collections.deque.popleft>`__
operations that do not require locking.

``collections.deque`` 是无界队列的另一种实现, 具有不需要锁的快速原子操作
``append()`` 和 ``popleft()``
