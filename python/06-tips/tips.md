# tips

<!-- TOC -->

- [tips](#tips)
    - [some tips](#some-tips)
        - [判断一个变量是否是某个类型可以用`isinstance()`判断](#判断一个变量是否是某个类型可以用isinstance判断)
        - [判断哪些名字是方法，用callable()判断](#判断哪些名字是方法用callable判断)
        - [列表生成式](#列表生成式)
        - [列表生成式和生成器完成杨辉三角](#列表生成式和生成器完成杨辉三角)
        - [使用Python设置环境变量](#使用python设置环境变量)
        - [实现进度条](#实现进度条)
    - [socket](#socket)
        - [获取域名对应IP](#获取域名对应ip)

<!-- /TOC -->

## some tips

### 判断一个变量是否是某个类型可以用`isinstance()`判断

    isinstance(a,list)

### 判断哪些名字是方法，用callable()判断

判断某个属性是否是方法的最简单办法就是利用callable：

    [f for f in dir('') if callable(getattr('',f))]

### 列表生成式

将列表L里面的字符转换为小写

```python
>>> L = ['Hello', 'World', 18, 'Apple', None]
>>> [ s.lower() for s in L if isinstance(s,str)]
['hello', 'world', 'apple']
```

### 列表生成式和生成器完成杨辉三角

```python
[1]
[1, 1]
[1, 2, 1]
[1, 3, 3, 1]
[1, 4, 6, 4, 1]
[1, 5, 10, 10, 5, 1]
[1, 6, 15, 20, 15, 6, 1]
[1, 7, 21, 35, 35, 21, 7, 1]
[1, 8, 28, 56, 70, 56, 28, 8, 1]
[1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
```

代码

```python
def triangles():
    L = [1]
    while True:
        yield L
        L = [1] + [ L[i] + L[i+1] for i in range(len(L) - 1)] + [1]
n = 0
for t in triangles():
    print(t)
    n = n + 1
    if n == 10:
        break
```

### 使用Python设置环境变量

```python
import os
path = os.environ["PATH"]
print("当前PATH变量:",path)
my = '/root/bin'
# 注意环境变量分隔符
os.environ["PATH"] = os.environ["PATH"]+';'+my
print("设置之后的环境变量:",os.environ["PATH"])
```

### 实现进度条

```python
import time
import sys
for i in range(50):
    sys.stdout.write("#")
    sys.stdout.flush()
    time.sleep(0.1)
```

## socket

### 获取域名对应IP

```python
import socket
ip = socket.gethostbyname("www.baidu.com")
```
