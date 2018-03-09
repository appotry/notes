# 正则表达式re模块

正则表达式是用于处理字符串的强大工具，拥有自己独特的语法以及一个独立的处理引擎，效率上可能不如str自带的方法，但功能十分强大。得益于这一点，在提供了正则表达式的语言里，正则表达式的语法都是一样的，区别只在于不同的编程语言实现支持的语法数量不同；但不用担心，不被支持的语法通常是不常用的部分。如果已经在其他语言里使用过正则表达式，只需要简单看一看就可以上手了。

## 正则表达式概念

1. 使用单个字符串来描述匹配一系列符合某个句法规则的字符串
2. 是对字符串操作的一种逻辑公式
3. 应用场景: 处理文本和数据
4. 正则表达式是过程: 依次拿出表达式和文本中的字符比较,如果每一个字符都能匹配,则匹配成功;否则匹配失败

## 字符匹配

 字符 | 描述
 ---|---
 `.` | 匹配任意一个字符(除了\n)
 `\d \D` | 数字/非数字
 `\s \S` | 空白/非空白字符
 `\w \W` | 单词字符`[a-zA-Z0-9]`/非单词字符
 `\b \B` | 单词边界,一个`\w`与`\W`之间的范围,顺序可逆/非单词边界

匹配任意一个字符

```python
# 导入模块
>>> import re
# 匹配字符串abc
>>> re.match('a.c','abc').group()
'abc'
```

数字与非数字

```python
# 匹配任意一数字
>>> re.match('\d','1').group()
'1'
# 匹配任意一个非数字
>>> re.match('\D','a').group()
'a'
```

空白与非空白

```python
>>> re.match('\s',' ').group()
' '
>>> re.match('\S','a').group()
'a'
>>> re.match('\S','1').group()
'1'
```

单词字符与非单词字符

> 单词字符即代表[a-zA-Z0-9]

```python
>>> re.match('\w','a').group()
'a'
>>> re.match('\w','1').group()
'1'
# 匹配任意一个非单词字符
>>> re.match('\W',' ').group()
' '
```

## 次数匹配

 字符 | 匹配
 ---|---
 `*` | 匹配前一个字符0次或无限次
 `+` | 匹配前一个字符1次或无限次
 `?` | 匹配前一个字符0次或者1次
 `{m}/{m,n}` | 匹配前一个字符m次或者m到n次
 `*?/+?/??` | 匹配模式变为懒惰模式(尽可能少的匹配字符)

介绍

字符  | 匹配
----|---
`(prev)?`  | 0个或1个prev
`(prev)*`  | 0个或多个prev，尽可能多地匹配
`(prev)*?`  | 0个或多个prev，尽可能少地匹配
`(prev)+`  | 1个或多个prev，尽可能多地匹配
`(prev)+?`  | 1个或多个prev，尽可能少地匹配
`(prev){m}`  | m个连续的prev
`(prev){m,n}`  | m到n个连续的prev，尽可能多地匹配
`(prev){m,n}?`  | m到n个连续的prev，尽可能少地匹配
`[abc]`  | a或b或c
`[^abc]`  | 非(a或b或c)

匹配前一个字符0次或者无限次

```python
>>> re.match('[A-Z][a-z]*','Aaa').group()
'Aaa'
>>> re.match('[A-Z][a-z]*','Aa').group()
'Aa'
>>> re.match('[A-Z][a-z]*','A').group()
'A'
```

匹配前一个字符至少1次或者无限次

```python
>>> re.match('[A-Z][a-z]+','A').group()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: 'NoneType' object has no attribute 'group'
>>> re.match('[A-Z][a-z]+','Aa').group()
'Aa'
>>> re.match('[A-Z][a-z]+','Aaaa').group()
'Aaaa'
```

匹配前一个字符0次或者1次

```python
>>> re.match('[A-Z][a-z]?','A').group()
'A'
>>> re.match('[A-Z][a-z]?','Aaa').group()
'Aa'
```

匹配前一个字符m次或者m-n次

```python
>>> re.match('\w{5}','as432dasdasd').group()
'as432'
>>> re.match('\w{6,10}','as432dasdasd').group()
'as432dasda'
```

懒惰匹配

```python
>>> re.match(r'[0-9][a-z]*','1bc').group()
'1bc'
>>> re.match(r'[0-9][a-z]*?','1bc').group()
'1'
>>> re.match(r'[0-9][a-z]+?','1bc').group()
'1b'
>>> re.match(r'[0-9][a-z]??','1bc').group()
'1'
```

## 边界匹配

 字符 | 匹配
 ---|---
 ^ | 匹配字符串开头
 $ | 匹配字符串结尾
 \A \Z | 指定的字符串必须出现在开头/结尾

匹配字符串开头

```python
# 必须以指定的字符串开头,结尾必须是@163.com
>>> re.match('^[\w]{4,6}@163.com$','fafafd@163.com').group()
'fafafd@163.com'
```

匹配字符串结尾

```python
# 必须以.com结尾
>>> re.match('[\w]{1,20}\.com$','163.com').group()
'163.com'
```

指定字符串必须出现在开头/结尾

```python
>>> re.match(r'\Awww[\w]*\me','wwwanshengme').group()
'wwwanshengme'
```

## 正则表达式分组匹配

| 匹配左右任意一个表达式

```python
>>> re.match('yang|ccc','yang').group()
'yang'
>>> re.match('yang|ccc','ccc').group()
'ccc'
```

(ab)括号中表达式作为一个整体

```python
>>> re.match(r"[\w]{4,6}@(163|126).com","fdafa@126.com").group()
'fdafa@126.com'
>>> re.match(r"[\w]{4,6}@(163|126).com","fdafa@163.com").group()
'fdafa@163.com'
```

(?P)分组起一个别名

```python
>>> re.search("(?P<zimu>abc)(?P<shuzi>123)","abc123").groups()
('abc', '123')'
```

引用别名为name的分组匹配字符串 有问题...待处理

```python
     >>> res.group("shuzi")
    '123'
     >>> res.group("zimu")
    'abc'
```

## re模块常用的方法

### re.match()

语法格式

    match(pattern,string,flags=0)

释义:

Try to apply the pattern at the start of the string,returning a match object,or None if no match was found.

从头开始匹配, 不管是否使用`^`都是从字符串开始进行匹配

```python
# 从头开始匹配,匹配成功则返回匹配的对象
>>> re.match("abc","abc123efa").group()
'abc'
# 从头开始匹配,如果没有匹配到对应的字符串就报错
>>> re.match("\d","abc123efa").group()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: 'NoneType' object has no attribute 'group'
>>>
```

match与search的区别

```python
>>> import re
# 从字符串开始进行匹配
>>> re.match("b.+", "abc123abc")
# search 匹配最先匹配到的内容, 同时, 只匹配最先匹配到的内容
>>> re.search("b.+", "abc123abc")
<_sre.SRE_Match object; span=(1, 9), match='bc123abc'>
```

### re.search()

    search(pattern,string,flags=0)

Scan through string looking for a match to the pattern,returning a match object,or None if no match was found.

匹配最先匹配到的内容, 同时, 只匹配最先匹配到的内容

```python
# 匹配整个字符串,匹配到第一个的时候就返回匹配到的对象
>>> re.search("\d","abc123daf").group()
'1'
```

### re.findall()

    findall(pattern,string,flags=0)

    Return a list of all non-overlapping matches in the string.

将所有能匹配到的内容都匹配出来, 返回一个列表存储匹配到的内容

```python
# 把匹配到的字符串以列表的形式返回
>>> re.findall("\d","fda123fda")
['1', '2', '3']
```

findall没有group方法

```python
>>> re.search("(?P<id>[0-9]+)", "abcd1234daf@34")
<_sre.SRE_Match object; span=(4, 8), match='1234'>
>>> re.search("(?P<id>[0-9]+)", "abcd1234daf@34").group()
'1234'
>>> re.search("(?P<id>[0-9]+)", "abcd1234daf@34").groupdict()
{'id': '1234'}
```

### re.split()

    split(pattern,string,maxsplit=0)

    Split the source string by the occurrences of the pattern,returning a list containing the resulting substrings.

```python
# 指定以数字进行分割,返回的是一个列表对象
>>> re.split("\d+","abc1234=+-*/56")
['abc', '=+-*/', '']
# 以多个字符进行分割
>>> re.split("[\d,]","a,b12")
['a', 'b', '', '']

>>> re.split('[0-9]', 'abc12de3f4g5y')
['abc', '', 'de', 'f', 'g', 'y']
>>> re.split('[0-9]+', 'abc12de3f4g5y')
['abc', 'de', 'f', 'g', 'y']
```

### re.sub()

    sub(pattern,repl,string,count=0)

> Return the string obtained by replacing the leftmost non-overlapping occurrences of the pattern in string by the replacement repl. repl can be either a string or a callable;
> if a string, backslash escapes in it are processed. If it is a callable, it’s passed the match object and must return a replacement string to be used.

```python
# 把abc替换成def
>>> re.sub("abc","def","abc123abc")
'def123def'
# 只替换查找到的第一个字符串
>>> re.sub("abc","def","abc123abc",count=1)
'def123abc'

>>> re.sub('[0-9]+', '|', 'abc12de3f456gf')
'abc|de|f|gf'
>>> re.sub('[0-9]+', '|', 'abc12de3f456gf', count=2)
'abc|de|f456gf'
```

### re.compile()

当我们在Python中使用正则表达式时，re模块内部会干两件事情：

1. 编译正则表达式，如果正则表达式的字符串本身不合法，会报错；
2. 用编译后的正则表达式去匹配字符串。

如果一个正则表达式要重复使用几千次，出于效率的考虑，我们可以预编译该正则表达式，接下来重复使用时就不需要编译这个步骤了，直接匹配：

```python
>>> import re
# 编译:
>>> re_telephone = re.compile(r'^(\d{3})-(\d{3,8})$')
# 使用：
>>> re_telephone.match('010-12345').groups()
('010', '12345')
>>> re_telephone.match('010-8086').groups()
('010', '8086')
```

编译后生成Regular Expression对象，由于该对象自己包含了正则表达式，所以调用对应的方法时不用给出正则字符串。

## 匹配模式

仅需知道如下几个模式

- re.I(re.IGNORECASE): 忽略大小写(括号内是完整写法, 下同)
- M(MULTILINE): 多行模式, 改变 `^`, `$` 的行为
- S(DOTALL): 点任意匹配模式, 改变 `.` 的行为

```python
>>> re.search('[a-z]+', 'abcdA', flags=re.I)
<_sre.SRE_Match object; span=(0, 5), match='abcdA'>

>>> re.search(r'^a', '\nabc\nrrr', flags=re.M)
<_sre.SRE_Match object; span=(1, 2), match='a'>
>>> re.search(r'^a', '\nabc\nrrr')
```

## 实例

string方法包含了一百个可打印的ASCII字符,大小写字母,数字,空格以及标点符号

```python
>>> import string
>>> printable = string.printable
>>> printable
'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c'
```

```python
>>> import re
# 定义的字符串
>>> source = '''I wish I may,I wish I might
... have a dish of fish tonight.'''
# 在字符串中检索wish
>>> re.findall('wish',source)
['wish', 'wish']
# 在字符串中检索任意wish或fish
>>> re.findall('wish|fish',source)
['wish', 'wish', 'fish']
# 从字符串开头开始匹配wish
>>> re.findall('^wish',source)
[]
# 从字符串开头匹配I wish
>>> re.findall('^I wish',source)
['I wish']
# 匹配以fish结尾
>>> re.findall('fish$',source)
[]
>>> re.findall('fish tonight.$',source)
['fish tonight.']
# 匹配wish或者fish
>>> re.findall('[wf]ish',source)
['wish', 'wish', 'fish']
# 匹配 w s h 任意组合
>>> re.findall('[wsh]+',source)
['w', 'sh', 'w', 'sh', 'h', 'h', 'sh', 'sh', 'h']
# 匹配ght并且后面跟着一个非单词字符
>>> re.findall('ght\W',source)
['ght.']
# 匹配后面为 " wish"的I
>>> re.findall('I (?=wish)',source)
['I ', 'I ']
>>> re.findall('(?<=I) (wish|might)',source)
['wish', 'wish', 'might']
```

### 匹配时不区分大小写

```python
>>> re.match('a','Abc',re.I).group()
'A'
```

```python
>>> import re
>>> pa = re.compile(r'yangjin')
>>> pa.match("yangjin")
<_sre.SRE_Match object; span=(0, 7), match='yangjin'>
>>> ma = pa.match("yangjin")
>>> ma
<_sre.SRE_Match object; span=(0, 7), match='yangjin'>
# 匹配到的值村道group内
>>> ma.group()
'yangjin'
# 返回字符串的所有位置
>>> ma.span()
(0, 7)
# 匹配的字符串会被放到string中
>>> ma.string
'yangjin'
# 实例放在re中
>>> ma.re
re.compile('yangjin')
```
