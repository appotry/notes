<!-- TOC -->

- [json](#json)
    - [json.dumps()](#jsondumps)
    - [json.loads()](#jsonloads)
    - [json进阶,序列化类](#json进阶序列化类)
    - [实例](#实例)
        - [将字符串序列化成字典](#将字符串序列化成字典)
        - [将一个列表类型的变量序列化成字符串类型](#将一个列表类型的变量序列化成字符串类型)
    - [小结](#小结)
- [pickle](#pickle)
    - [pickle.dump()](#pickledump)
    - [pickle.load()](#pickleload)

<!-- /TOC -->

**json 和 pickle**

用于序列化的两个模块

* json, 用于字符串和python数据类型间进行转换
* pickle, 用于python特有的类型 和 python的数据类型间进行转换

json模块提供了四个功能: dumps,dump,loads,load

pickle模块提供了四个功能: dumps,dump,loads,load

dumps是将dict转化成str格式，loads是将str转化成dict格式。

dump和load也是类似的功能，只是与文件操作结合起来了。

两个模块用法相同,区别在于pickle只可用于Python,可序列化Python特有数据类型

# json

JSON类型 | Python类型
-------|---------
{} | dict
[] | list
"string" | str
1234.56 | int或float
true/false | True/False
null | None

## json.dumps()

返回一个`str`,内容就是标准的JSON.类似的`dump()`方法可以直接把JSON写入一个`file-like Object`

```python
>>> import json
>>> d = dict(name='Bob',age=20,score=80)
>>> json.dumps(d)
'{"name": "Bob", "age": 20, "score": 80}'

>>> data = {'k1':123,'k2':'hello'}
# json.dumps 将数据通过特殊的形式转换为所有程序语言都认识的字符串
j_str = json.dumps(data)
print(j_str)

# json.dump 将数据通过特殊的形式转换为所有程序语言都认识的字符串,并写入文件
with open('/User/xxx/result.json','w') as fp:
    json.dump(data,fp)
```

## json.loads()

要把JSON反序列化为Python对象,用`loads()`或者对应的`load()`方法,前者把JSON的字符串反序列化,后者从`file-like Object`中读取字符串并反序列化

```python
>>> json_str = '{"name": "Bob", "age": 20, "score": 80}'
>>> json.loads(json_str)
{'name': 'Bob', 'age': 20, 'score': 80}
```

由于JSON标准规定JSON编码是UTF-8，所以我们总是能正确地在Python的`str`与JSON的字符串之间转换。

## json进阶,序列化类

Python的`dict`对象可以直接序列化为JSON的`{}`,不过,很多时候,我们更喜欢用`class`表示对象,比如定义`Student`类,然后序列化

```python
import json

class Student:
    def __init__(self,name,age,score):
        self.name = name
        self.age = age
        self.score = score

s = Student('Bob',20,80)
print(json.dumps(s))
```

上述代码直接运行,会报如下错误

    TypeError: <__main__.Student object at 0x1021ded30> is not JSON serializable

原因是`Student`对象不是一个可序列化为JSON的对象

`dumps()`方法参考

[https://docs.python.org/3/library/json.html#json.dumps](https://docs.python.org/3/library/json.html#json.dumps)

前面的代码不能将`Student`类实例化为JSON,是因为默认情况下,`dumps()`方法不知道如何将`Student`实例变为一个JSON的`{}`对象

可选参数default就是把任意一个对象变成一个可序列为JSON的对象，我们只需要为Student专门写一个转换函数，再把函数传进去即可：

```python
import json

class Student:
    def __init__(self,name,age,score):
        self.name = name
        self.age = age
        self.score = score

def student2dict(std):
    return {
        'name': std.name,
        'age': std.age,
        'score': std.score
    }

s = Student('Bob',20,80)
print(json.dumps(s,default=student2dict))
```

这样,`Student`实例首先被`student2dict()`转为`dict`,然后被序列化

不过,如果下次遇到其他类的实例,同样无法实例化为JSON,此时可以这样做,把任意class的实例变为`dict`

    print(json.dumps(s,default=lambda obj:obj.__dict__))

因为通常class的实例都有一个`__dict__`属性，它就是一个dict，用来存储实例变量。也有少数例外，比如定义了`__slots__`的class。

同样的道理，如果我们要把JSON反序列化为一个Student对象实例，loads()方法首先转换出一个dict对象，然后，我们传入的object_hook函数负责把dict转换为Student实例：

```python
def dict2student(d):
    return Student(d['name'], d['age'], d['score'])
```

```python
>>> json_str = '{"age": 20, "score": 88, "name": "Bob"}'
>>> print(json.loads(json_str, object_hook=dict2student))
<__main__.Student object at 0x10cd3c190>
```

打印出的是反序列化的`Student`实例对象。

## 实例

### 将字符串序列化成字典

创建一个字符串变量  `dict_str`

```Python
>>> dict_str = '{"k1":"v1","k2":"v2"}'
>>> type(dict_str)
<class 'str'>
```

将字符串变量 `dict_str` 序列化成字典格式

```Python
>>> import json

>>> dict_json = json.loads(dict_str)
>>> type(dict_json)
<class 'dict'>
>>> dict_json
{'k2': 'v2', 'k1': 'v1'}
```

### 将一个列表类型的变量序列化成字符串类型

## 小结

json模块的`dumps()`和`loads()`函数是定义得非常好的接口的典范。当我们使用时，只需要传入一个必须的参数。但是，当默认的序列化或反序列机制不满足我们的要求时，我们又可以传入更多的参数来定制序列化或反序列化的规则，既做到了接口简单易用，又做到了充分的扩展性和灵活性。

# pickle

## pickle.dump()

```python
>>> import pickle
>>> data = {'k1':123,'k2':'hello'}
# pickle.dumps 将数据通过特殊的形式转换为只有python语言认识的字符串
>>> p_str = pickle.dumps(data)
>>> p_str
b'\x80\x03}q\x00(X\x02\x00\x00\x00k1q\x01K{X\x02\x00\x00\x00k2q\x02X\x05\x00\x00\x00helloq\x03u.'

# pickle.dump 将数据通过特殊的形式转换为只有python语言认识的字符串,并写入文件
with open('/User/xxxx/result.pk','w') as fp:
    pickle.dump(data,fp)
```

## pickle.load()

```python
if os.path.exists(os.path.split(__file__)[0] + '/user.db'):
    pk_file = open('user.db','rb')
    students = pickle.load(pk_file)
    pk_file.close()
```