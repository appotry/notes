# 1. JavaScript

独立的语言,浏览器带有JavaScript解释器

<!-- TOC -->

- [1. JavaScript](#1-javascript)
    - [1.1. 总结](#11-总结)
    - [1.2. 变量](#12-变量)
    - [1.3. 基本数据类型](#13-基本数据类型)
        - [1.3.1. 数字](#131-数字)
        - [1.3.2. 字符串](#132-字符串)
        - [1.3.3. 布尔类型](#133-布尔类型)
        - [1.3.4. 数组](#134-数组)
    - [1.4. 其他](#14-其他)
        - [1.4.1. 序列化](#141-序列化)
        - [1.4.2. 转义](#142-转义)
        - [1.4.3. eval](#143-eval)
        - [1.4.4. 正则表达式](#144-正则表达式)
            - [1.4.4.1. 定义正则表达式](#1441-定义正则表达式)
            - [1.4.4.2. 匹配](#1442-匹配)
        - [1.4.5. setInterval](#145-setinterval)
        - [1.4.6. 滚动字幕](#146-滚动字幕)
    - [1.5. 循环](#15-循环)
        - [1.5.1. for循环](#151-for循环)
        - [1.5.2. while](#152-while)
    - [1.6. 异常处理](#16-异常处理)
    - [1.7. 条件语句](#17-条件语句)
        - [1.7.1. if](#171-if)
        - [1.7.2. switch](#172-switch)
    - [1.8. 函数](#18-函数)
    - [1.9. 作用域](#19-作用域)

<!-- /TOC -->

## 1.1. 总结

- JavaScript代码存在形式
    - head标签中,body代码块底部(推荐)
        - `<script></script>`
    - 文件中
        - `<script src="JavaScript文件路径"></script>`
    - PS: HTML代码从上往下执行,如果head中的js代码耗时严重,会导致用户长时间无法看到页面,而写在body标签最后(最后加载),不会影响到用户看到页面,只是js实现的一些效果较慢.
- 注释
    - 单行注释 `// 注释内容`
    - 多行注释 `/* 注释内容 */`
- 基本数据类型
    - 数字
    - 字符串
        - charAt(索引位置)
        - substring(起始位置,结束位置) 不包含结束位置
        - lenght    获取当前字符串长度
    - 布尔类型
        - true
        - false
    - 数组
    - 字典(JavaScript实际上没有字典,而是一个对象)
    - null 关键字,特殊值,描述"空值"
    - undefined 特殊值,表示变量未定义
    - 注: 数字,布尔值,null,undefined,字符串是不可变的
- 变量
    - 全局变量  `name="xxx"`
    - 局部变量  `var name="xxx"`
- 条件语句
- 循环
    - for循环(两种)
    - while循环
- 定时器 `setInterval('func()',间隔时间,单位为秒);`

## 1.2. 变量

- 全局变量  `name="xxx"`
- 局部变量  `var name="xxx"`

## 1.3. 基本数据类型

### 1.3.1. 数字

JavaScript中不区分整数值和浮点数值，JavaScript中所有数字均用浮点数值表示。

转换

- parseInt(..)   将某值转换成数字，不成功则NaN
- parseFloat(..) 将某值转换成浮点数，不成功则NaN

特殊值

- NaN，非数字。可使用 isNaN(num) 来判断。
- Infinity，无穷大。可使用 isFinite(num) 来判断。

### 1.3.2. 字符串

字符串是由字符组成的数组，但在JavaScript中字符串是不可变的：可以访问字符串任意位置的文本，但是JavaScript并未提供修改已知字符串内容的方法。

常见功能

| Column                                   | 功能                                       |
| ---------------------------------------- | ---------------------------------------- |
| `obj.length`                             | 长度                                       |
| `obj.trim()` <br> `obj.trimLeft()` <br> `obj.trimRight)` | 移除空白                                     |
| `obj.charAt(n)`                          | 返回字符串中的第n个字符                             |
| `obj.concat(value, ...)`                 | 拼接                                       |
| `obj.indexOf(substring,start)`           | 子序列位置                                    |
| `obj.lastIndexOf(substring,start)`       | 子序列位置                                    |
| `obj.substring(from, to)`                | 根据索引获取子序列                                |
| `obj.slice(start, end)`                  | 切片                                       |
| `obj.toLowerCase()`                      | 大写                                       |
| `obj.toUpperCase()`                      | 小写                                       |
| `obj.split(delimiter, limit)`            | 分割                                       |
| `obj.search(regexp)`                     | 从头开始匹配，返回匹配成功的第一个位置(g无效)                 |
| `obj.match(regexp)`                      | 全局搜索，如果正则中有g表示找到全部，否则只找到第一个。             |
| `obj.replace(regexp, replacement)`       | 替换，正则中有g则替换所有，否则只替换第一个匹配项，<br> $数字：匹配的第n个组内容；<br/> $&：当前匹配的内容；<br> $`：位于匹配子串左侧的文本；<br> $'：位于匹配子串右侧的文本 <br> $$：直接量$符号 |

```javascript
age = 18
18
name = "yangxxx"
"yangxxx"
name.charAt()
"y"
/* 索引位置,从0开始 */
name.charAt(0)
"y"
name.charAt(3)
"g"
/* 起始位置,结束位置(不包含结束位置) */
name.substring(0,3)
"yan"
name.length
7
```

### 1.3.3. 布尔类型

- true
- false

```javascript
== 值相等
!=

=== 值和类型都相等
!==
&&  and
||  or
```

### 1.3.4. 数组

JavaScript中的数组类似于python中的列表

```javascript
obj.length          数组的大小

obj.push(ele)       尾部追加元素
obj.pop()           尾部获取一个元素
obj.unshift(ele)    头部插入元素
obj.shift()         头部移除元素
obj.splice(start, deleteCount, value, ...)  插入、删除或替换数组的元素
                    obj.splice(n,0,val) 指定位置插入元素
                    obj.splice(n,1,val) 指定位置替换元素
                    obj.splice(n,1)     指定位置删除元素
obj.slice( )        切片
obj.reverse( )      反转
obj.join(sep)       将数组元素连接起来以构建一个字符串
obj.concat(val,..)  连接数组
obj.sort( )         对数组元素进行排序
```

## 1.4. 其他

### 1.4.1. 序列化

```javascript
JSON.stringify(obj)   序列化
JSON.parse(str)       反序列化
```

### 1.4.2. 转义

```javascript
decodeURI( )                   URl中未转义的字符
decodeURIComponent( )   URI组件中的未转义字符
encodeURI( )                   URI中的转义字符
encodeURIComponent( )   转义URI组件中的字符
escape( )                         对字符串转义
unescape( )                     给转义字符串解码
URIError                         由URl的编码和解码方法抛出
```

### 1.4.3. eval

JavaScript中的eval是Python中eval和exec的合集，既可以编译代码也可以获取返回值。

- eval()
- EvalError   执行字符串中的JavaScript代码

### 1.4.4. 正则表达式

#### 1.4.4.1. 定义正则表达式

- /.../  用于定义正则表达式
- /.../g 表示全局匹配
- /.../i 表示不区分大小写
- /.../m 表示多行匹配

JS正则匹配时本身就是支持多行，此处多行匹配只是影响正则表达式^和$，m模式也会使用^$来匹配换行的内容)

```javascript
var pattern = /^Java\w*/gm;
var text = "JavaScript is more fun than \nJavaEE or JavaBeans!";
result = pattern.exec(text)
result = pattern.exec(text)
result = pattern.exec(text)
注：定义正则表达式也可以  reg= new RegExp()
```

#### 1.4.4.2. 匹配

JavaScript中支持正则表达式，其主要提供了两个功能：

test(string)     检查字符串中是否和正则匹配

```javascript
n = 'uui99sdf'
reg = /\d+/
reg.test(n)  ---> true
# 只要正则在字符串中存在就匹配，如果想要开头和结尾匹配的话，就需要在正则前后加 ^和$

```

exec(string)    获取正则表达式匹配的内容，如果未匹配，值为null，否则，获取匹配成功的数组。

```javascript
获取正则表达式匹配的内容，如果未匹配，值为null，否则，获取匹配成功的数组。

非全局模式
    获取匹配结果数组，注意：第一个元素是第一个匹配的结果，后面元素是正则子匹配（正则内容分组匹配）
    var pattern = /\bJava\w*\b/;
    var text = "JavaScript is more fun than Java or JavaBeans!";
    result = pattern.exec(text)

    var pattern = /\b(Java)\w*\b/;
    var text = "JavaScript is more fun than Java or JavaBeans!";
    result = pattern.exec(text)

全局模式
    需要反复调用exec方法，来一个一个获取结果，直到匹配获取结果为null表示获取完毕
    var pattern = /\bJava\w*\b/g;
    var text = "JavaScript is more fun than Java or JavaBeans!";
    result = pattern.exec(text)

    var pattern = /\b(Java)\w*\b/g;
    var text = "JavaScript is more fun than Java or JavaBeans!";
    result = pattern.exec(text)
```

3、字符串中相关方法

```javascript
obj.search(regexp)                   获取索引位置，搜索整个字符串，返回匹配成功的第一个位置(g模式无效)
obj.match(regexp)                    获取匹配内容，搜索整个字符串，获取找到第一个匹配内容，如果正则是g模式找到全部
obj.replace(regexp, replacement)     替换匹配替换，正则中有g则替换所有，否则只替换第一个匹配项，
                                        $数字：匹配的第n个组内容；
                                          $&：当前匹配的内容；
                                          $`：位于匹配子串左侧的文本；
                                          $'：位于匹配子串右侧的文本
                                          $$：直接量$符号
```

### 1.4.5. setInterval

定时执行某个函数

```html
    <script>
        // 每3秒触发一次弹窗
        setInterval("alert(123);",3000)
    </script>
```

### 1.4.6. 滚动字幕

```html
<body>
    <ul>
        <li id="l1">欢迎xxx莅临指导</li>
    </ul>
</body>
```

![js-01-滚动字幕](http://oi480zo5x.bkt.clouddn.com/js-01-滚动字幕.jpg)

```html
<body>
    <ul>
        <li id="l1">欢迎xxx莅临指导</li>
    </ul>
    <script>
        function func(){
            var tag = document.getElementById('l1');
            var content = tag.innerText;
            var f = content.charAt(0);
            var s = content.substring(1,content.length);
            var new_content = s + f;
            tag.innerText = new_content;

        }
        setInterval('func()',300);
    </script>
</body>
```

## 1.5. 循环

### 1.5.1. for循环

```js
a = [11,22,33,44]
for (var item in a){
    console.log(item);
}

a = {"k1":"v1","k2":"v2"}

for (var item in a){
    console.log(a[item]);
}
```

for循环第二种

```js
for (var i=0;i<10;i++){
    console.log(i)
}
```

![js-02-for](http://oi480zo5x.bkt.clouddn.com/js-02-for.jpg)

### 1.5.2. while

```js
while(条件){
    // break;
    // continue;
}
```

## 1.6. 异常处理

```javascript
try {
    //这段代码从上往下运行，其中任何一个语句抛出异常该代码块就结束运行
}
catch (e) {
    // 如果try代码块中抛出了异常，catch代码块中的代码就会被执行。
    //e是一个局部变量，用来指向Error对象或者其他抛出的对象
}
finally {
     //无论try中代码是否有异常抛出（甚至是try代码块中有return语句），finally代码块中始终会被执行。
}
注：主动跑出异常 throw Error('xxxx')
```

## 1.7. 条件语句

### 1.7.1. if

```js
if(条件){

}else if(条件){

}else{}
```

### 1.7.2. switch

```js
   switch(name){
        case '1':
            age = 123;
            break;
        case '2':
            age = 456;
            break;
        default :
            age = 777;
    }
```

## 1.8. 函数

函数基本分为下面三类

```js
// 普通函数
    function func(arg){
        return true;
    }

// 匿名函数
    var func = function(arg){
        return "tony";
    }

// 自执行函数
    (function(arg){
        console.log(arg);
    })('123')
```

注意：对于JavaScript中函数参数，实际参数的个数可能小于形式参数的个数，函数内的特殊值arguments中封装了所有实际参数。

## 1.9. 作用域

JavaScript中每个函数都有自己的作用域，当出现函数嵌套时，就出现了作用域链。当内层函数使用变量时，会根据作用域链从内到外一层层的循环，如果不存在，则异常。

切记：所有的作用域在创建函数且未执行时候就已经存在。

```javascript
function f2(){
    var arg= 111;
    function f3(){
        console.log(arg);
    }

    return f3;
}

ret = f2();
ret();

        function f2(){
            var arg= [11,22];
            function f3(){
                console.log(arg);
            }
            arg = [44,55];
            return f3;
        }

        ret = f2();
        ret();
注：声明提前，在JavaScript引擎“预编译”时进行。
```

更多：http://www.cnblogs.com/wupeiqi/p/5649402.html