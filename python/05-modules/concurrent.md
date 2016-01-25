# concurrent.futures

`python 3` 为我们提供的标准库, 提供了`ThreadPoolExecutor`和`ProcessPoolExecutor`两个类，实现了对`threading`和`multiprocessing`的更高级的抽象，对编写线程池/进程池提供了直接的支持。

`concurrent.futures` 基础模块是 `executor` 和 `future`

**python 2.7 需要安装futures模块，使用命令pip install futures安装即可**

[https://docs.python.org/3/library/concurrent.futures.html](https://docs.python.org/3/library/concurrent.futures.html)

[http://blog.csdn.net/dutsoft/article/details/54728706](http://blog.csdn.net/dutsoft/article/details/54728706)

[http://www.cnblogs.com/skiler/p/7080179.html](http://www.cnblogs.com/skiler/p/7080179.html)

## 类的方法

`concurrent.futures.wait(fs, timeout=None, return_when=ALL_COMPLETED)`：wait等待fs里面所有的Future实例（由不同的Executors实例创建的）完成。返回两个命名元祖，第一个元祖名为done，存放完成的futures对象，第二个元祖名为not_done，存放未完成的futures。return_when参数必须是concurrent.futures里面定义的常量：FIRST_COMPLETED,FIRST_EXCEPTION,ALL_COMPLETED

`concurrent.futures.as_completed(fs, timeout=None)`：返回一个迭代器，yield那些完成的futures对象。fs里面有重复的也只可能返回一次。任何`futures`在调用`as_completed()`调用之前完成首先被yield。

## Executor Objects

一个抽象类, 提供方法来执行异步调用. 不应该直接使用, 可以通过具体子类使用.

## ThreadPoolExecutor

`ThreadPoolExecutor` 是 `Executor`的子类, 使用线程池执行异步调用.

示例:

下面会造成死锁

```python
import time
def wait_on_b():
    time.sleep(5)
    print(b.result())  # b will never complete because it is waiting on a.
    return 5

def wait_on_a():
    time.sleep(5)
    print(a.result())  # a will never complete because it is waiting on b.
    return 6


executor = ThreadPoolExecutor(max_workers=2)
a = executor.submit(wait_on_b)
b = executor.submit(wait_on_a)
```

```python
def wait_on_future():
    f = executor.submit(pow, 5, 2)
    # This will never complete because there is only one worker thread and
    # it is executing this function.
    print(f.result())

executor = ThreadPoolExecutor(max_workers=1)
executor.submit(wait_on_future)
```

###  ThreadPoolExecutor Example

```python
import concurrent.futures
import urllib.request

URLS = ['http://www.foxnews.com/',
        'http://www.cnn.com/',
        'http://europe.wsj.com/',
        'http://www.bbc.co.uk/',
        'http://some-made-up-domain.com/']

# Retrieve a single page and report the URL and contents
def load_url(url, timeout):
    with urllib.request.urlopen(url, timeout=timeout) as conn:
        return conn.read()

# We can use a with statement to ensure threads are cleaned up promptly
with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
    # Start the load operations and mark each future with its URL
    future_to_url = {executor.submit(load_url, url, 60): url for url in URLS}
    for future in concurrent.futures.as_completed(future_to_url):
        url = future_to_url[future]
        try:
            data = future.result()
        except Exception as exc:
            print('%r generated an exception: %s' % (url, exc))
        else:
            print('%r page is %d bytes' % (url, len(data)))
```

## ProcessPoolExecutor

### ProcessPoolExecutor Example

```python
import concurrent.futures
import math

PRIMES = [
    112272535095293,
    112582705942171,
    112272535095293,
    115280095190773,
    115797848077099,
    1099726899285419]

def is_prime(n):
    if n % 2 == 0:
        return False

    sqrt_n = int(math.floor(math.sqrt(n)))
    for i in range(3, sqrt_n + 1, 2):
        if n % i == 0:
            return False
    return True

def main():
    with concurrent.futures.ProcessPoolExecutor() as executor:
        for number, prime in zip(PRIMES, executor.map(is_prime, PRIMES)):
            print('%d is prime: %s' % (number, prime))

if __name__ == '__main__':
    main()
```

## Future 对象

`Future`类封装了一个可调用的异步执行,  [`Future`](https://docs.python.org/3/library/concurrent.futures.html#concurrent.futures.Future) 对象通过 [`Executor.submit()`](https://docs.python.org/3/library/concurrent.futures.html#concurrent.futures.Executor.submit)创建.

- `cancel`()

  Attempt to cancel the call. If the call is currently being executed and cannot be cancelled then the method will return `False`, otherwise the call will be cancelled and the method will return `True`.

- `cancelled`()

  Return `True` if the call was successfully cancelled.

- `running`()

  Return `True` if the call is currently being executed and cannot be cancelled.

- `done`()

  Return `True` if the call was successfully cancelled or finished running.

- `result`(*timeout=None*)

  Return the value returned by the call. If the call hasn’t yet completed then this method will wait up to *timeout* seconds. If the call hasn’t completed in *timeout* seconds, then a [`concurrent.futures.TimeoutError`](https://docs.python.org/3/library/concurrent.futures.html#concurrent.futures.TimeoutError) will be raised. *timeout* can be an int or float. If *timeout* is not specified or `None`, there is no limit to the wait time.If the future is cancelled before completing then [`CancelledError`](https://docs.python.org/3/library/concurrent.futures.html#concurrent.futures.CancelledError) will be raised.If the call raised, this method will raise the same exception.

- `exception`(*timeout=None*)

  Return the exception raised by the call. If the call hasn’t yet completed then this method will wait up to *timeout* seconds. If the call hasn’t completed in *timeout* seconds, then a [`concurrent.futures.TimeoutError`](https://docs.python.org/3/library/concurrent.futures.html#concurrent.futures.TimeoutError) will be raised. *timeout* can be an int or float. If *timeout* is not specified or `None`, there is no limit to the wait time.If the future is cancelled before completing then [`CancelledError`](https://docs.python.org/3/library/concurrent.futures.html#concurrent.futures.CancelledError) will be raised.If the call completed without raising, `None` is returned.

- `add_done_callback`(*fn*)

还有一些方法用于单元测试和`Executor`实现

