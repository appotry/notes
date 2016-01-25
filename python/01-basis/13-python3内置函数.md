# 1. Python3内置函数

The Python interpreter has a number of functions and types built into it that are always available. They are listed here in alphabetical order.

|                                          |                                          | Built-in Functions                       |                                          |                                          |
| ---------------------------------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- |
| [`abs()`](https://docs.python.org/3/library/functions.html#abs) | [`dict()`](https://docs.python.org/3/library/functions.html#func-dict) | [`help()`](https://docs.python.org/3/library/functions.html#help) | [`min()`](https://docs.python.org/3/library/functions.html#min) | [`setattr()`](https://docs.python.org/3/library/functions.html#setattr) |
| [`all()`](https://docs.python.org/3/library/functions.html#all) | [`dir()`](https://docs.python.org/3/library/functions.html#dir) | [`hex()`](https://docs.python.org/3/library/functions.html#hex) | [`next()`](https://docs.python.org/3/library/functions.html#next) | [`slice()`](https://docs.python.org/3/library/functions.html#slice) |
| [`any()`](https://docs.python.org/3/library/functions.html#any) | [`divmod()`](https://docs.python.org/3/library/functions.html#divmod) | [`id()`](https://docs.python.org/3/library/functions.html#id) | [`object()`](https://docs.python.org/3/library/functions.html#object) | [`sorted()`](https://docs.python.org/3/library/functions.html#sorted) |
| [`ascii()`](https://docs.python.org/3/library/functions.html#ascii) | [`enumerate()`](https://docs.python.org/3/library/functions.html#enumerate) | [`input()`](https://docs.python.org/3/library/functions.html#input) | [`oct()`](https://docs.python.org/3/library/functions.html#oct) | [`staticmethod()`](https://docs.python.org/3/library/functions.html#staticmethod) |
| [`bin()`](https://docs.python.org/3/library/functions.html#bin) | [`eval()`](https://docs.python.org/3/library/functions.html#eval) | [`int()`](https://docs.python.org/3/library/functions.html#int) | [`open()`](https://docs.python.org/3/library/functions.html#open) | [`str()`](https://docs.python.org/3/library/functions.html#func-str) |
| [`bool()`](https://docs.python.org/3/library/functions.html#bool) | [`exec()`](https://docs.python.org/3/library/functions.html#exec) | [`isinstance()`](https://docs.python.org/3/library/functions.html#isinstance) | [`ord()`](https://docs.python.org/3/library/functions.html#ord) | [`sum()`](https://docs.python.org/3/library/functions.html#sum) |
| [`bytearray()`](https://docs.python.org/3/library/functions.html#func-bytearray) | [`filter()`](https://docs.python.org/3/library/functions.html#filter) | [`issubclass()`](https://docs.python.org/3/library/functions.html#issubclass) | [`pow()`](https://docs.python.org/3/library/functions.html#pow) | [`super()`](https://docs.python.org/3/library/functions.html#super) |
| [`bytes()`](https://docs.python.org/3/library/functions.html#func-bytes) | [`float()`](https://docs.python.org/3/library/functions.html#float) | [`iter()`](https://docs.python.org/3/library/functions.html#iter) | [`print()`](https://docs.python.org/3/library/functions.html#print) | [`tuple()`](https://docs.python.org/3/library/functions.html#func-tuple) |
| [`callable()`](https://docs.python.org/3/library/functions.html#callable) | [`format()`](https://docs.python.org/3/library/functions.html#format) | [`len()`](https://docs.python.org/3/library/functions.html#len) | [`property()`](https://docs.python.org/3/library/functions.html#property) | [`type()`](https://docs.python.org/3/library/functions.html#type) |
| [`chr()`](https://docs.python.org/3/library/functions.html#chr) | [`frozenset()`](https://docs.python.org/3/library/functions.html#func-frozenset) | [`list()`](https://docs.python.org/3/library/functions.html#func-list) | [`range()`](https://docs.python.org/3/library/functions.html#func-range) | [`vars()`](https://docs.python.org/3/library/functions.html#vars) |
| [`classmethod()`](https://docs.python.org/3/library/functions.html#classmethod) | [`getattr()`](https://docs.python.org/3/library/functions.html#getattr) | [`locals()`](https://docs.python.org/3/library/functions.html#locals) | [`repr()`](https://docs.python.org/3/library/functions.html#repr) | [`zip()`](https://docs.python.org/3/library/functions.html#zip) |
| [`compile()`](https://docs.python.org/3/library/functions.html#compile) | [`globals()`](https://docs.python.org/3/library/functions.html#globals) | [`map()`](https://docs.python.org/3/library/functions.html#map) | [`reversed()`](https://docs.python.org/3/library/functions.html#reversed) | [`__import__()`](https://docs.python.org/3/library/functions.html#__import__) |
| [`complex()`](https://docs.python.org/3/library/functions.html#complex) | [`hasattr()`](https://docs.python.org/3/library/functions.html#hasattr) | [`max()`](https://docs.python.org/3/library/functions.html#max) | [`round()`](https://docs.python.org/3/library/functions.html#round) |                                          |
| [`delattr()`](https://docs.python.org/3/library/functions.html#delattr) | [`hash()`](https://docs.python.org/3/library/functions.html#hash) | [`memoryview()`](https://docs.python.org/3/library/functions.html#func-memoryview) | [`set()`](https://docs.python.org/3/library/functions.html#func-set) |                                          |

[官方介绍](https://docs.python.org/3/library/functions.html)

<!-- TOC -->

- [1. Python3内置函数](#1-python3内置函数)
    - [1.1. 内置函数详解](#11-内置函数详解)
        - [1.1.1. abs(x)](#111-absx)
        - [1.1.2. all(iterable)](#112-alliterable)
        - [1.1.3. any(iterable)](#113-anyiterable)
        - [1.1.4. ascii(object)](#114-asciiobject)
        - [1.1.5. bin(x)](#115-binx)
        - [1.1.6. bool([x])](#116-boolx)
        - [1.1.7. bytearray()](#117-bytearray)
        - [1.1.8. bytes()](#118-bytes)
        - [1.1.9. callable(object)](#119-callableobject)
        - [1.1.10. chr(i)](#1110-chri)
        - [1.1.11. classmethod(function)](#1111-classmethodfunction)
        - [1.1.12. compile()](#1112-compile)
        - [1.1.13. complex()](#1113-complex)
        - [1.1.14. delattr(object,name)](#1114-delattrobjectname)
        - [1.1.15. dict(**kwarg)](#1115-dictkwarg)
        - [1.1.16. dir([object])](#1116-dirobject)
        - [1.1.17. divmod(a,b)](#1117-divmodab)
        - [1.1.18. enumerate(iterable,start=0)](#1118-enumerateiterablestart0)
        - [1.1.19. eval()](#1119-eval)
        - [1.1.20. exec()](#1120-exec)
        - [1.1.21. filter(function,iterable)](#1121-filterfunctioniterable)
        - [1.1.22. float([x])](#1122-floatx)
        - [1.1.23. format()](#1123-format)
        - [1.1.24. frozenset([iterable])](#1124-frozensetiterable)
        - [1.1.25. getattr(object,name[,default])](#1125-getattrobjectnamedefault)
        - [1.1.26. globals](#1126-globals)
        - [1.1.27. hasattr(object,name)](#1127-hasattrobjectname)
        - [1.1.28. hash(object)](#1128-hashobject)
        - [1.1.29. help([object])](#1129-helpobject)
        - [1.1.30. hex(x)](#1130-hexx)
        - [1.1.31. id(object)](#1131-idobject)
        - [1.1.32. input([prompt])](#1132-inputprompt)
        - [1.1.33. int(x,base=10)](#1133-intxbase10)
        - [1.1.34. isinstance(object,classinfo)](#1134-isinstanceobjectclassinfo)
        - [1.1.35. issubclass(class,classinfo)](#1135-issubclassclassclassinfo)
        - [1.1.36. iter(object[,sentinel])](#1136-iterobjectsentinel)
        - [1.1.37. len(s)](#1137-lens)
        - [1.1.38. list([iterable])](#1138-listiterable)
        - [1.1.39. locals()](#1139-locals)
        - [1.1.40. map(function,iterable,...)](#1140-mapfunctioniterable)
        - [1.1.41. max()](#1141-max)
        - [1.1.42. memoryview(obj)](#1142-memoryviewobj)
        - [1.1.43. min()](#1143-min)
        - [1.1.44. next()](#1144-next)
        - [1.1.45. object](#1145-object)
        - [1.1.46. oct(x)](#1146-octx)
        - [1.1.47. open()](#1147-open)
        - [1.1.48. ord(c)](#1148-ordc)
        - [1.1.49. pow(x,y[,z])](#1149-powxyz)
        - [1.1.50. print()](#1150-print)
        - [1.1.51. properyt()](#1151-properyt)
        - [1.1.52. range(start,stop[,step])](#1152-rangestartstopstep)
        - [1.1.53. repr(object)](#1153-reprobject)
        - [1.1.54. reversed(seq)](#1154-reversedseq)
        - [1.1.55. round(number[,ndigits])](#1155-roundnumberndigits)
        - [1.1.56. set([iterable])](#1156-setiterable)
        - [1.1.57. setattr()](#1157-setattr)
        - [1.1.58. slice()](#1158-slice)
        - [1.1.59. sorted(iterable[,key][,reverse])](#1159-sortediterablekeyreverse)
        - [1.1.60. staticmethod(function)](#1160-staticmethodfunction)
        - [1.1.61. str()](#1161-str)
        - [1.1.62. sum()](#1162-sum)
        - [1.1.63. super()](#1163-super)
        - [1.1.64. tuple([iterable])](#1164-tupleiterable)
        - [1.1.65. type(object)](#1165-typeobject)
        - [1.1.66. vars([object])](#1166-varsobject)
        - [1.1.67. zip(*iterables)](#1167-zipiterables)
        - [1.1.68. __import__()](#1168-__import__)
    - [1.2. 生成随机验证码例子](#12-生成随机验证码例子)

<!-- /TOC -->

## 1.1. 内置函数详解

### 1.1.1. abs(x)

> 返回数字的绝对值,参数可以是整数或浮点数,如果参数是复数,则返回其大小

```python
>>> abs(-517)
517
```

### 1.1.2. all(iterable)

> all()会循环括号内的每一个元素,如果括号内的所有元素都是真的,或者如果iterable为空,则返回`True`,如果有一个为假,那么久返回`False`

```python
>>> all([])
True
>>> all([1,2,3])
True
>>> all([1,2,""])
False
>>> all([1,2,None])
False
```

假的参数有：False、0、None、""、[]、()、{}等，查看一个元素是否为假可以使用bool进行查看。

### 1.1.3. any(iterable)

> 循环元素,如果有一个元素为真,那么久返回True,否则就返回False

```python
>>> any([0,1])
True
>>> any([0])
False
```

### 1.1.4. ascii(object)

> 在对象的类中寻找`__repr__`方法,获取返回值

```python
>>> class Foo:
...   def __repr_(self):
...     return "hello"
...
>>> obj = Foo()
>>> r = ascii(obj)
>>> print(r)
<__main__.Foo object at 0x101a9fe80>
# 返回的是一个可迭代的对象
```

### 1.1.5. bin(x)

> 将整数x转换为二进制字符串,如果x不为python中int类型,x必须包含方法`__index__()`并且返回值为`integer`

```python
# 返回一个整数的二进制
>>> bin(999)
'0b1111100111'
```

```python
>>> class myType:
...   def __index__(self):
...     return 35
...
>>> myvar = myType()
>>> bin(myvar)
'0b100011'
```

### 1.1.6. bool([x])

> 查看一个元素的布尔值,非真即假

```python
>>> bool(0)
False
>>> bool(1)
True
>>> bool([1])
True
```

### 1.1.7. bytearray()

bytearray([source[,encoding[,errors]]])

> 返回一个byte数组,Bytearray类型是一个可变的序列,并且序列中的元素的取值范围为[0,255]

source参数:

1. 如果source为整数,则返回一个长度为source的初始化数组;
2. 如果source为字符串,则按照指定encoding将字符串转换为字节序列;
3. 如果source为可迭代类型,则元素必须为[0,255]中的整数;
4. 如果source为与buffer接口一致的对象,则此对象也可以被用于初始化bytearray.

```python
>>> bytearray(3)
bytearray(b'\x00\x00\x00')
```

### 1.1.8. bytes()

> bytes([source[,encoding[,errors]]])

```python
>>> bytes("yjj",encoding="utf-8")
b'yjj'
```

### 1.1.9. callable(object)

> 返回一个对象是否可以被执行

```python
>>> def func():
...   return 123
...
>>> callable(func)
True
>>> func = 123
>>> callable(func)
False
```

### 1.1.10. chr(i)

> 返回一个数字在ASCII编码中对应的字符,取值范围256

```python
>>> chr(66)
'B'
>>> chr(5)
'\x05'
>>> chr(65)
'A'
```

### 1.1.11. classmethod(function)

> 返回函数的类方法

### 1.1.12. compile()

compile(source,filename,mode,flags=0,dont_inherit=False,optimize=-1)

> 把字符串编译成python可执行的代码, 代码对象可以使用exec来执行或者eval()进行求值

```python
>>> str = "for i in range(0,10):print(i)"
>>> c = compile(str,'','exec')
>>> exec(c)
0
1
2
3
4
5
6
7
8
9
```

### 1.1.13. complex()

complex([real[,imag]])

> 创建一个值为real+imag*j的复数或者转化一个字符串(或数字)为复数.如果第一个参数为字符串,则不需要指定第二个参数

```python
>>> complex(1,2)
(1+2j)
# 数字
>>> complex(1)
(1+0j)
# 当做字符串处理
>>> complex("1")
(1+0j)
# 注意:这个地方在"+"号两边不能有空格,也就是不能写成"1 + 2j",否则会报错
>>> complex("1+2j")
(1+2j)
```

### 1.1.14. delattr(object,name)

> 删除对象的属性值

```python
>>> class cls:
...   @classmethod
...   def echo(self):
...     print('CLS')
...
>>> cls.echo()
CLS
>>> delattr(cls,'echo')
>>> cls.echo()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: type object 'cls' has no attribute 'echo'
>>>
```

### 1.1.15. dict(**kwarg)

> 创建一个数据类型为字典

```python
>>> dic = dict({"k1":"123","k2":"456"})
>>> dic
{'k1': '123', 'k2': '456'}
```

### 1.1.16. dir([object])

> 返回一个对象中的所有方法

```python
>>> dir(str)
['__add__', '__class__', '__contains__', '__delattr__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__getitem__', '__getnewargs__', '__gt__', '__hash__', '__init__', '__iter__', '__le__', '__len__', '__lt__', '__mod__', '__mul__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__rmod__', '__rmul__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', 'capitalize', 'casefold', 'center', 'count', 'encode', 'endswith', 'expandtabs', 'find', 'format', 'format_map', 'index', 'isalnum', 'isalpha', 'isdecimal', 'isdigit', 'isidentifier', 'islower', 'isnumeric', 'isprintable', 'isspace', 'istitle', 'isupper', 'join', 'ljust', 'lower', 'lstrip', 'maketrans', 'partition', 'replace', 'rfind', 'rindex', 'rjust', 'rpartition', 'rsplit', 'rstrip', 'split', 'splitlines', 'startswith', 'strip', 'swapcase', 'title', 'translate', 'upper', 'zfill']
```

### 1.1.17. divmod(a,b)

> 返回的是a//b(除法取整)以及a对b的余数,返回结果类型为tuple

```python
>>> divmod(10,3)
(3, 1)
```

### 1.1.18. enumerate(iterable,start=0)

> 为元素生成下标

```python
>>> li = ["a","b","c"]
>>> for n,k in enumerate(li):
...   print(n,k)
...
0 a
1 b
2 c
```

### 1.1.19. eval()

eval(expression,globals=None,locals=None)

> 把一个字符串当做一个表达式去执行

```python
>>> string = "1+3"
>>> string
'1+3'
>>> eval(string)
4
```

### 1.1.20. exec()

exec(object[,globals[,locals]])

> 把字符串当做python代码执行

```python
>>> exec("for n in range(5):print(n)")
0
1
2
3
4
```

### 1.1.21. filter(function,iterable)

> 筛选过滤,循环可迭代的对象,把迭代的对象当做函数的参数,如果符合条件就返回`True`,否则就返回`False`

```python
>>> def func(x):
...   if x == 11 or x == 22:
...     return True
...
>>> ret = filter(func,[11,22,33,44])
>>> for n in ret:
...   print(n)
...
11
22
```

```python
>>> list(filter((lambda x : x > 0),range(-5,5)))
[1, 2, 3, 4]
```

### 1.1.22. float([x])

> 将整数和字符串转换成浮点数

```python
>>> float("123")
123.0
>>> float("123.45")
123.45
>>> float("-123.45")
-123.45
```

### 1.1.23. format()

format(value,[format_spec])

> 字符串格式化

[详解](https://blog.ansheng.me/article/python-full-stack-way-string-formatting/)

### 1.1.24. frozenset([iterable])

> frozenset是冻结的集合,它是不可改变的,存在哈希值,好处是它可以作为字典的key,也可以作为其他集合的元素.缺点是一旦创建便不能更改,没有add,remove方法.

### 1.1.25. getattr(object,name[,default])

> 返回对象的命名属性的值,`name`必须是字符串,如果字符串是对象属性之一的名称,则结果是该属性的值.

### 1.1.26. globals

> 获取或修改当前文件内的全局变量

```python
>>> a = "12"
>>> b = "434d"
>>> globals()
{'__builtins__': <module 'builtins' (built-in)>, '__doc__': None, '__loader__': <class '_frozen_importlib.BuiltinImporter'>, 'b': '434d', '__spec__': None, '__name__': '__main__', '__package__': None, 'a': '12'}
```

### 1.1.27. hasattr(object,name)

> 参数是一个对象和一个字符串,如果字符串是对象的某个属性的名称,则结果为True,否则为False

### 1.1.28. hash(object)

> 返回一个对象的hash值

```python
>>> a = "afdafasd"
>>> hash(a)
2216836390023867832
```

### 1.1.29. help([object])

> 查看一个类的所有详细方法,或者查看某个方法的使用详细信息

```python
>>> help(list)

Help on class list in module builtins:

class list(object)
 |  list() -> new empty list
 |  list(iterable) -> new list initialized from iterable's items
 |
 |  Methods defined here:
 |
 |  __add__(self, value, /)
 |      Return self+value.
 |
 |  __contains__(self, key, /)
 |      Return key in self.
 |
 |  __delitem__(self, key, /)
 |      Delete self[key].
 |
 |  __eq__(self, value, /)
 |      Return self==value.
 |
 |  __ge__(self, value, /)
 |      Return self>=value.
 |
 |  __getattribute__(self, name, /)
 |      Return getattr(self, name).
 ......
```

### 1.1.30. hex(x)

> 获取一个数的十六进制

```python
>>> hex(19)
'0x13'
```

### 1.1.31. id(object)

> 返回一个对象的内存地址

```python
>>> a = 123
>>> id(a)
4297558784
```

### 1.1.32. input([prompt])

> 交互式输入

```python
>>> name = input("Please input your name: ")
Please input your name: yang
>>> print(name)
yang
```

### 1.1.33. int(x,base=10)

> 获取一个数的十进制

```python
>>> int("51")
51
```

> 也可以做进制转换

```python
>>> int(10)
10
>>> int('0b11',base=2)
3
>>> int('0xe',base=16)
14
```

### 1.1.34. isinstance(object,classinfo)

> 判断对象是否是这个类创建的

```python
>>> li = [11,22,33]
>>> isinstance(li,list)
True
```

### 1.1.35. issubclass(class,classinfo)

issubclass()

> 查看一个对象是否为子类

### 1.1.36. iter(object[,sentinel])

> 创建一个可迭代的对象

```python
>>> obj = iter([11,22,33,44])
>>> obj
<list_iterator object at 0x101bfe048>
>>> for n in obj:
...   print(n)
...
11
22
33
44
```

### 1.1.37. len(s)

> 查看一个对象的长度

```python
>>> url="yang"
>>> len(url)
4
```

### 1.1.38. list([iterable])

> 创建一个数据类型为列表

```python
>>> li = list([11,22,44])
>>> li
[11, 22, 44]
```

### 1.1.39. locals()

> 返回当前作用域的局部变量,以字典形式输出

```python
>>> def func():
...   name="yang"
...   print(locals())
...
>>> func()
{'name': 'yang'}
```

### 1.1.40. map(function,iterable,...)

> 对一个序列中的每一个元素都传到函数中执行并返回

```python
>>> list(map((lambda x : x + 10),[11,22,33,44]))
[21, 32, 43, 54]
```

### 1.1.41. max()

max(iterable,*[,key,default])

max(arg1,arg2,*args[,key])

> 取一个对象中的最大值

```python
>>> li = [11,22,33,44]
>>> li
[11, 22, 33, 44]
>>> max(li)
44
```

### 1.1.42. memoryview(obj)

> 返回对象obj的内存查看对象

```python
>>> import struct
>>> buf = struct.pack("i"*12,*list(range(12)))
>>> x = memoryview(buf)
>>> y = x.cast('i',shape=[2,2,3])
>>> print(y.tolist())
[[[0, 1, 2], [3, 4, 5]], [[6, 7, 8], [9, 10, 11]]]
>>>
```

### 1.1.43. min()

min(iterable,*[,key,default])

min(arg1,arg2,*args[,key])

> 取一个对象中的最小值

```python
>>> li = list([11,22,33])
>>> min(li)
11
```

### 1.1.44. next()

next(iterable[,default])

> 每次只拿取可迭代对象的一个元素

```python
>>> obj = iter([11,22,33,44])
>>> next(obj)
11
>>> next(obj)
22
>>> next(obj)
33
>>> next(obj)
44
# 如果没有可迭代的元素,就会报错
>>> next(obj)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
StopIteration
```

### 1.1.45. object

> 返回一个新的无特征对象

### 1.1.46. oct(x)

> 获取一个字符串的八进制

```python
>>> oct(15)
'0o17'
```

### 1.1.47. open()

open(file,mode='r',buffering=-1,encoding=None,errors=None,newline=None,closefd=True,opener=None)

> 文件操作的函数,用来做文件操作

```python
>>> f = open("a.txt","r")
```

### 1.1.48. ord(c)

> 把一个字母转换为ASCII对应表中的数字

```python
>>> ord("a")
97
```

### 1.1.49. pow(x,y[,z])

> 返回一个数的N次方

```python
>>> pow(2,10)
1024
>>> pow(2,20)
1048576
```

### 1.1.50. print()

print(*objects,sep=' ',end=' \n',file=sys.stdout,flush=False)

> 打印输出

```python
>>> print("Hello World")
Hello World
```

### 1.1.51. properyt()

properyt(fget=None,fset=None,fdel=None,doc=None)

### 1.1.52. range(start,stop[,step])

> 生成一个序列

```python
>>> range(10)
range(0, 10)
>>> for n in range(5):
...   print(n)
...
0
1
2
3
4
```

### 1.1.53. repr(object)

> 返回一个包含对象的可打印表示的字符串

```python
>>> repr(1110)
'1110'
>>> repr(111.11)
'111.11'
```

### 1.1.54. reversed(seq)

> 对一个对象的元素进行反转

```python
>>> li = [11,22,33,44]
>>> reversed(li)
<list_reverseiterator object at 0x101e96518>
>>> for n in reversed(li):
...   print(n)
...
44
33
22
11
```

### 1.1.55. round(number[,ndigits])

> 四舍五入

```python
>>> round(3.3)
3
>>> round(3.7)
4
```

### 1.1.56. set([iterable])

> 创建一个数据类型为集合

```python
>>> var = set([11,22,33])
>>> type(var)
<class 'set'>
```

### 1.1.57. setattr()

setattr(object,name,value)

> 为某个对象设置一个属性

### 1.1.58. slice()

slice(start,stop[,step])

> 元素的切片操作都是调用的这个方法

### 1.1.59. sorted(iterable[,key][,reverse])

> 为一个对象的元素进行排序

```python
>>> sorted([5, 2, 3, 1, 4])
[1, 2, 3, 4, 5]
```

### 1.1.60. staticmethod(function)

> 返回函数的静态方法

### 1.1.61. str()

str(object=b'',encoding='utf-8',errors=' strict')

> 字符串

```python
>>> a = str(111)
>>> type(a)
<class 'str'>
```

### 1.1.62. sum()

sum(iterable[,start])

> 求和

```python
>>> sum([11,22,33])
66
```

### 1.1.63. super()

super([type[,object-or-type]])

> 执行父类的构造函数

### 1.1.64. tuple([iterable])

> 创建一个对象,数据类型为元组

```python
>>> tup = tuple([11,22,33,44])
>>> type(tup)
<class 'tuple'>
```

### 1.1.65. type(object)

> 查看一个对象的数据类型

```python
>>> tup = tuple([11,22,33,44])
>>> type(tup)
<class 'tuple'>
```

### 1.1.66. vars([object])

> 查看一个对象里面有多少个变量

### 1.1.67. zip(*iterables)

> 将两个元素相同的序列转换为字典

```python
 >>> li1 = ["k1","k2","k3"]
>>> li2 = ["a","b","c"]
>>> d = dict(zip(li1,li2))
>>> d
{'k2': 'b', 'k1': 'a', 'k3': 'c'}
```

### 1.1.68. __import__()

__import__(name,globals=None,locals=None,fromlist=(),level=0)

> 导入模块,把导入的模块作为一个别名

## 1.2. 生成随机验证码例子

> 生成一个六位的随机验证码,且包含数字,数字的位置随机

```python
#!/usr/bin/env python
# _*_ coding:utf-8 _*_

import random
temp = ""
for i in range(6):
    num = random.randrange(0,4)
    if num == 3 or num == 1:
        rad2 = random.randrange(0,10)
        temp += str(rad2)
    else:
        rad1 = random.randrange(65,91)
        c1 = chr(rad1)
        temp += c1
print(temp)
```

```python
➜  python_test python3 012-exercise-2.py
81FZ62
```