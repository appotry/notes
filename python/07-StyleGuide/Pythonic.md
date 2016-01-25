# Pythonic

## 交换两个数字

在其他语言里面

    t = a
    a = b
    b = t

在Python语言里面

    a, b = b, a

## 链式比较

```python
a = 3
b = 1

1 <= b <= a < 10  #True
```

## 真值测试

```python
name = 'Tim'
langs = ['AS3', 'Lua', 'C']
info = {'name': 'Tim', 'sex': 'Male', 'age':23 }

if name and langs and info:
    print('All True!')  #All True!
```

真值

| 真          | 假                           |
| ---------- | --------------------------- |
| True       | False                       |
| 任意非空字符串    | 空的字符串 `''`                  |
| 任意非0数字     | 数字`0`                       |
| 任意非空容器     | 空的容器 `[]` `()` `{}` `set()` |
| 其他任意非False | None                        |

真假值表中还有一类判断，如果是用户自定义类，还需要对该类的实例的`__nonzero__`和`__len__`的返回值进行判断。

## 字符串反转

```python
def reverse_str( s ):
    return s[::-1]
```

## 字符串列表连接

```python
strList = ["Python", "is", "good"]

res =  ' '.join(strList) #Python is good
```

## 列表求和,最大值,最小值,乘积

```python
numList = [1,2,3,4,5]

sum = sum(numList)  #sum = 15
maxNum = max(numList) #maxNum = 5
minNum = min(numList) #minNum = 1
from operator import mul
prod = reduce(mul, numList, 1) #prod = 120 默认值传1以防空列表报错
```



## 列表推导

列表推导是C、C++、Java里面没有的语法，但是，是Python里面使用非常广泛，是特别推荐的用法。

```python
l = [x*x for x in range(10) if x % 3 == 0]
#l = [0, 9, 36, 81]
```



与列表推导对应的，还有集合推导和字典推导。我们来演示一下。

### 列表：30~40 所有偶数的平方

    >>> [ i*i for i in range(30, 41) if i% 2 == 0 ]
    [900, 1024, 1156, 1296, 1444, 1600]

集合：1~20所有奇数的平方的集合

    >>> { i*i for i in range(1, 21) if i % 2 != 0 }
    {1, 225, 289, 9, 169, 361, 81, 49, 121, 25}

字典：30~40 所有奇数的平方

    >>> { i:i*i for i in range(30, 40) if i% 2 != 0 }
    {33: 1089, 35: 1225, 37: 1369, 39: 1521, 31: 961}

## enumerate

```python
array = [1, 2, 3, 4, 5]

for i, e in enumerate(array,0):
    print i, e
#0 1
#1 2
#2 3
#3 4
#4 5
```

## 使用zip创建键值对

```python
keys = ['Name', 'Sex', 'Age']
values = ['Tim', 'Male', 23]

dic = dict(zip(keys, values))
#{'Age': 23, 'Name': 'Tim', 'Sex': 'Male'}
```

