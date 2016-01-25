# 遍历list和dict

## List遍历

最常用最简单的遍历list的方法

```Python
a = ["a", "b", "c", "d"]

for i in a:
    print i
```

但是, 如果我需要拿到list的 `index` , 很多人可能会这样写

```Python
a = ["a", "b", "c", "d"]

for i in xrange(len(a)):
    print i, a[i]
```

其实, python提供了一个方法 `enumerate` , 用法如下

```Python
a = ["a", "b", "c", "d"]

for i, el in enumerate(a):
    print i, el
```

上面两种方式的结果相同

```Python
0 a
1 b
2 c
3 d
```

这是一种更加方便便捷的方式, 虽然少写不了几个字符, 从代码可读性等方面来考量的话, 还是清晰很多的.

代码应该让人一目了然, 目的明确, 如果多种方式可以实现相同的功能, 那么我们应该选择一种大家更加容易理解的, enumerate就是这样的方式.

    enumerate(iterable[, start]) -> iterator for index, value of iterable

第二个参数在很多时候也是很有用的, 比如我不希望从0开始, 希望从1开始

```Python
a = ["a", "b", "c", "d"]

for i, el in enumerate(a, 1):
    print i, el
```

输出如下

```Python
1 a
2 b
3 c
4 d
```

如果你使用range的话, 会蹩脚很多.

## Dict遍历

dict最简单的遍历方式

**遍历字典key**

```Python
d = {'a': 1, 'c': 3, 'b': 2, 'd': 4}

>>> for k in d:
...   print(k)
...
c
a
d
b

>>> for k in d:
...   print(k,d[k])
...
c 3
a 1
d 4
b 2

>>> d.keys()
dict_keys(['c', 'a', 'd', 'b'])
```

**遍历字典值**

```python
>>> for k in d.values():
...   print(k)
...
3
1
4
2
```

**遍历字典的项**

```python
>>> for item in d.items():
...   print(item)
...
('c', 3)
('a', 1)
('d', 4)
('b', 2)
```

**遍历key,value**

dict本身提供了items()方法, 可以做到k,v对遍历.数据量大的时候不要使用,会把dict先转成list

```Python
d = {'a': 1, 'c': 3, 'b': 2, 'd': 4}

>>> for k,v in d.items():
...     print(k,v)
...
c 3
a 1
d 4
b 2
```

dict还有其他几个方法