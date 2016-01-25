# hashlib

代替了md5模块和sha模块，主要提供 SHA1, SHA224, SHA256, SHA384, SHA512 ，MD5算法

摘要算法简介

Python的hashlib提供了常见的摘要算法，如MD5，SHA1等等。

什么是摘要算法呢？摘要算法又称哈希算法、散列算法。它通过一个函数，把任意长度的数据转换为一个长度固定的数据串（通常用16进制的字符串表示）。

举个例子，你写了一篇文章，内容是一个字符串`'how to use python hashlib - by Michael'`，并附上这篇文章的摘要是`'2d73d4f15c0db7f5ecb321b6a65e5d6d'`。如果有人篡改了你的文章，并发表为`'how to use python hashlib - by Bob'`，你可以一下子指出Bob篡改了你的文章，因为根据`'how to use python hashlib - by Bob'`计算出的摘要不同于原始文章的摘要。

可见，摘要算法就是通过摘要函数`f()`对任意长度的数据`data`计算出固定长度的摘要`digest`，目的是为了发现原始数据是否被人篡改过。

摘要算法之所以能指出数据是否被篡改过，就是因为摘要函数是一个单向函数，计算f(data)很容易，但通过digest反推data却非常困难。而且，对原始数据做一个bit的修改，都会导致计算出的摘要完全不同。

我们以常见的摘要算法MD5为例，计算出一个字符串的MD5值

如果数据量很大，可以分块多次调用`update()`，最后计算的结果是一样的

```python
>>> md1 = hashlib.md5()
>>> md1.update("what's your name".encode('utf-8'))
>>> md2 = hashlib.md5()
>>> md2.update("what's your name".encode('utf-8'))
>>> print(md1.hexdigest())
21d3ccbf3dd3e0d8c641bc574084fe46
>>> print(md2.hexdigest())
21d3ccbf3dd3e0d8c641bc574084fe46

>>> md2.update("x".encode('utf-8'))
>>> print(md2.hexdigest())
a340a72f8cdc0890e210770946577668

>>> md6 = hashlib.md5()
>>> md6.update("what's your namex".encode('utf-8'))
>>> print(md6.hexdigest())
a340a72f8cdc0890e210770946577668
```

## SHA1

```python
>>> sha1 = hashlib.sha1()
>>> sha1.update('xxxx'.encode('utf-8'))
>>> sha1.update('xxxx'.encode('utf-8'))
>>> print(sha1.hexdigest())
bcf22dfc6fb76b7366b1f1675baf2332a0e6a7ce
```

## sha256,sha512..

```python
import hashlib

# ######## md5 ########

hash = hashlib.md5()
hash.update('admin')
print hash.hexdigest()

# ######## sha1 ########

hash = hashlib.sha1()
hash.update('admin')
print hash.hexdigest()

# ######## sha256 ########

hash = hashlib.sha256()
hash.update('admin')
print hash.hexdigest()

# ######## sha384 ########

hash = hashlib.sha384()
hash.update('admin')
print hash.hexdigest()

# ######## sha512 ########

hash = hashlib.sha512()
hash.update('admin')
print hash.hexdigest()
```

以上加密算法虽然依然非常厉害，但时候存在缺陷，即：通过撞库可以反解。所以，有必要对加密算法中添加自定义key再来做加密。

```python
import hashlib

# ######## md5 ########

hash = hashlib.md5('898oaFs09f')
hash.update('admin')
print hash.hexdigest()
```

python 还有一个 **hmac** 模块，它内部对我们创建 key 和 内容 再进行处理然后再加密

```python
import hmac
h = hmac.new('hello')
h.update('world')
print h.hexdigest()
```

## 摘要算法应用

允许用户登录的网站可以存储用户口令的摘要,而不存储用户的明文口令.

当用户登录时，首先计算用户输入的明文口令的MD5，然后和数据库存储的MD5对比，如果一致，说明口令输入正确，如果不一致，口令肯定错误。

**在程序设计上对简单口令加强保护呢？**

由于常用口令的MD5值很容易被计算出来，所以，要确保存储的用户口令不是那些已经被计算出来的常用口令的MD5，这一方法通过对原始口令加一个复杂字符串来实现，俗称“加盐”：

```python
def calc_md5(password):
    return get_md5(password + 'the-Salt')
```

但是如果有两个用户都使用了相同的简单口令比如123456，在数据库中，将存储两条相同的MD5值，这说明这两个用户的口令是一样的。有没有办法让使用相同口令的用户存储不同的MD5呢？

如果假定用户无法修改登录名，就可以通过把登录名作为Salt的一部分来计算MD5，从而实现相同口令的用户也存储不同的MD5。

## 小结

摘要算法在很多地方都有广泛的应用。要注意摘要算法不是加密算法，不能用于加密（因为无法通过摘要反推明文），只能用于防篡改，但是它的单向计算特性决定了可以在不存储明文口令的情况下验证用户口令。

## 实例

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
根据用户输入的登录名和口令模拟用户注册，计算更安全的MD5：
然后，根据修改后的MD5算法实现用户登录的验证：
"""
import hashlib,getpass

db = {}

def get_md5(str):
    md5 = hashlib.md5()
    md5.update((str + 'xxxx').encode('utf-8'))
    return md5.hexdigest()


def register(username,password):
    db[username] = get_md5(password + username)

def login(username, password):
    if username in db:
        if get_md5(password + username) == db[username]:
            print("success")
        else:
            print('failure')
    else:
        print('用户不存在')


def main():
    username = input("Please input your name: ")
    password = getpass.getpass()
    register(username,password)
    print(db)
    username = input("Please input your name: ")
    password = getpass.getpass()
    login(username, password)

if __name__ == '__main__':
    main()
```