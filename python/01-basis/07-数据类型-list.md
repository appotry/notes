# 列表

列表(list)同字符串一样都是有序的,因为他们都可以通过切片和索引进行数据访问,且列表是可变的

## 创建列表的几种方法

第一种

```python
>>> name_list = ['python','php','java']
>>> name_list
['python', 'php', 'java']
```

第二种

```python
>>> name_list = list(['python','php','java'])
>>> name_list
['python', 'php', 'java']
```

创建一个空列表

```python
>>> li = list()
>>> type(li)
<class 'list'>
```

把一个字符串转换成一个列表

```python
>>> var = "abc"
>>> li = list(var)
>>> li
['a', 'b', 'c']
```

list在把字符串转换成列表的时候,会把字符串用for循环迭代一下,然后把每个值当做list的一个元素

把一个元组转换成列表

```python
>>> tup = ("a","b","c")
>>> li = list(tup)
>>> type(li)
<class 'list'>
>>> li
['a', 'b', 'c']
```

把字典转换成列表

```python
>>> dic={"k1":"a","k2":"b","k3":"c"}
>>> li=list(dic)
>>> type(li)
<class 'list'>
>>> li
['k1', 'k3', 'k2']
```

字典默认循环的时候就是key,所以会把key当做列表的元素

```python
>>> dic={"k1":"a","k2":"b","k3":"c"}
>>> li=list(dic.values())
>>> li
['a', 'c', 'b']
```

## 列表所提供的方法

tab键

```python
>>> li.
li.clear() # 清除列表内所有元素
li.copy()
...

1. append(self,p_object)  在列表末尾添加新的对象
2. count(self,value)      统计某个元素在列表中出现的次数
3. extend(self,iterable)  用于在列表末尾一次性追加另一个序列
4. index(self,value,start=None,stop=None)  从列表中找出某个值第一个匹配项的索引位置
5. insert(self,index,p_object)             将制定对象插入列表
6. pop(self,index=None)                    移除列表中的一个元素,并返回该元素的值
7. remove(self,value)                      移除列表中某个值得第一个匹配项(删除元素还可以使用del,或者用切片赋值进行元素删除L[1:2]=[])
8. reverse(self)                           反向输出列表中的元素
9. sort(self,cmp=None,key=None,reverse=False) 对原有列表进行排序,如果指定参数,则使用比较函数指定的比较函数
```

清除列表内所有元素

```python
>>> li
['a', 'c', 'b']
>>> li.clear()
>>> li
[]
```

同字符串一样,列表也支持解析,称为列表解析

```python
>>> li = [x for x in range(1,20)]
>>> li
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
```

## 列表操作

### 切片

```python
>>> names = ["yang","liu","zhao","qian","sun","wu"]
>>> names[1:4]  # 取下标1至4之间的数字,包括1,不包括4 顾头不顾尾
['liu', 'zhao', 'qian']
>>> names[1:-1] # 取下标1至-1,不包括-1
['liu', 'zhao', 'qian', 'sun']
>>> names[0:3]
['yang', 'liu', 'zhao']
>>> names[:3] # 从头开始取,可以省略0,效果同上
['yang', 'liu', 'zhao']
>>> names[3:] # 如果想取最后一个,只能这么写
['qian', 'sun', 'wu']
>>> names[3:-1] # 这样 -1 不被包含
['qian', 'sun']
>>> names[0::2] # 后面的2代表步长
['yang', 'zhao', 'sun']
>>> names[::2] # 效果同上
['yang', 'zhao', 'sun']
```

### 追加

```python
>>> names
['yang', 'liu', 'zhao', 'qian', 'sun', 'wu']
>>> names.append("haha")
>>> names
['yang', 'liu', 'zhao', 'qian', 'sun', 'wu', 'haha']
```

### 插入

```python
>>> names
['yang', 'liu', 'zhao', 'qian', 'sun', 'wu', 'haha']
>>> names.insert(2,"插入到zhao前面")
>>> names
['yang', 'liu', '插入到zhao前面', 'zhao', 'qian', 'sun', 'wu', 'haha']
```

### 修改

```python
>>> names
['yang', 'liu', '插入到zhao前面', 'zhao', 'qian', 'sun', 'wu', 'haha']
>>> names[2] = "换人"
>>> names
['yang', 'liu', '换人', 'zhao', 'qian', 'sun', 'wu', 'haha']
```

### 删除

```python
>>> names
['yang', 'liu', '换人', 'zhao', 'qian', 'sun', 'wu', 'haha']
>>> del names[2]
>>> names
['yang', 'liu', 'zhao', 'qian', 'sun', 'wu', 'haha']
>>> names.remove("zhao") # 删除指定元素
>>> names
['yang', 'liu', 'qian', 'sun', 'wu', 'haha']
>>> names.pop() # 删除列表最后一个值
'haha'
>>> names
['yang', 'liu', 'qian', 'sun', 'wu']
```

### 扩展

```python
>>> names
['yang', 'liu', 'qian', 'sun', 'wu']
>>> b = [1,2,3]
>>> names.extend(b)
>>> names
['yang', 'liu', 'qian', 'sun', 'wu', 1, 2, 3]
```

### 拷贝(不是这么简单)

```python
>>> names
['yang', 'liu', 'qian', 'sun', 'wu', 1, 2, 3]
>>> name_copy = names.copy()
>>> name_copy
['yang', 'liu', 'qian', 'sun', 'wu', 1, 2, 3]
```

### 统计

```python
>>> names
['yang', 'liu', 'qian', 'sun', 'wu', 1, 2, 3]
>>> names.insert(2,"wu")
>>> names.count("wu")
2
```

### 排序&翻转

```python
>>> names
['yang', 'liu', 'wu', 'qian', 'sun', 'wu', 1, 2, 3]
>>> names.sort()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unorderable types: int() < str() # 3.x 不同数据类型不能放在一起排序
>>> names[-3] = '1'
>>> names[-2] = '2'
>>> names[-1] = '3'
>>> names
['liu', 'qian', 'sun', 'wu', 'wu', 'yang', '1', '2', '3']
>>> names.sort()
>>> names
['1', '2', '3', 'liu', 'qian', 'sun', 'wu', 'wu', 'yang']
>>>
>>> names.reverse() # 翻转
>>> names
['yang', 'wu', 'wu', 'sun', 'qian', 'liu', '3', '2', '1']
```

### 获取下标

```python
>>> names
['yang', 'wu', 'wu', 'sun', 'qian', 'liu', '3', '2', '1']
>>> names.index("wu")
1 # 返回找到的第一个下标
```
