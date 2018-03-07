# HTML

## 总结

1. 一套规则,浏览器认识的规则
2. 开发者
    - 学习HTML规则
    - 开发后台程序
        - 写HTML文件(充当模板的作用) *****
        - 数据库获取数据,然后替换到HTML文件的指定位置(web框架)
3. 本地测试
    - 找到文件路径,直接使用浏览器打开
    - PyCharm打开测试
4. 编写HTML文件
    - doctype对应关系
    - html标签,标签内部可以写属性 (整个html文件只有一个html标签)
    - 注释: <!-- 注释的内容 -->
5. 标签分类
    - 自闭合标签( `<meta charset="UTF-8">` ) 自闭合标签可以使用 `<br/>` 或 `<br>` 推荐在`>`前面写`/`
    - 主动闭合标签(  `<title>长廊月</title>`  )
6. head标签中
    - `<meta>` -> 编码,跳转,刷新,关键字,描述,IE兼容
    - `<meta http-equiv="X-UA-Compatible" content="IE=IE9;IE=IE8;"/>`
7. body标签
    - p标签,段落
    - br,换行
    - 所有标签分为两类: **块级标签,行内标签(内联标签)**
    - 块级标签
        - H系列(加大加粗),p标签(段落和段落之间有间距),div(白板)
    - 行内标签
        - span(白板)
    - 标签之间可以嵌套
    - 标签存在的意义,css操作,js操作

- 20个常用标签

```html
<!DOCTYPE html>
<!-- html标签, lang为标签内部的属性 -->
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <a href="http://www.baidu.com">baidu</a>

</body>
</html>
```

## 网页特殊符号

```html
&nbsp; 空格
&gt;
&lt;
```

## 标签

### meta

[参考链接](http://www.w3school.com.cn/tags/tag_meta.asp)

提供有关页面的元信息,例如: 页面编码,刷新,跳转,针对搜索引擎和更新频度的描述和关键词

#### 页面编码

指定编码

    <meta http-equiv="content-type" content="text/html";charset="UTF-8">

#### 刷新和跳转

    <meta http-equiv="Refresh" content="30">

3秒自动跳转(可临时用于将原网站跳转到指定网站)

    <meta http-equiv="Refresh" content="3;Url=http://www.baidu.com">

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Refresh" content="2">
    <!--<meta http-equiv="Refresh" content="3;Url=http://www.baidu.com">-->
    <title>Title</title>
</head>
<body>
    <a href="http://www.baidu.com">baidu</a>
</body>
</html>
```

#### 关键字

    <meta name="keywords" content="小色,xxx">

#### 描述

例如 : 作者

#### X-UA-Compatible

    <meta http-equiv="X-UA-Compatible" content="IE=IE9;IE=IE8;"/>

### Title

网页头部信息

### link

### style

### script

### p

表示段落,默认段落之间是有间隔的

### br

换行 `<br/>`

自闭合标签，后面位置 `>` 可以写上  `/`  推荐写

### a

1. 锚 href="#某个标签的ID" 标签的ID不允许重复
2. target 属性,`_black`表示在新的页面打开
3. 菜单跳转

```html
    <a href="http://www.baidu.com" target="_black">baidu</a>
```

跳转,id不能重复

```html
<body>
    <a href="#i1"> 第一章 </a>
    <a href="#i2"> 第二章 </a>
    <a href="#i3"> 第三章 </a>
    <a href="#i4"> 第四章 </a>

    <div id="i1" style="height: 600px;"> 第一章内容 </div>
    <div id="i2" style="height: 600px;"> 第二章内容 </div>
    <div id="i3" style="height: 600px;"> 第三章内容 </div>
    <div id="i4" style="height: 600px;"> 第四章内容 </div>
</body>
```

### img

- src
- alt
- title

默认有一个1px的边框

#### 图片跳转

```html
<body>
    <!--a标签里面嵌套img标签,实现点击图片跳转-->
    <a href="http://www.baidu.com">
        <!--不设置图片大小,将显示整张图片-->
        <!--<img src="1.jpg">-->
        <!--设置图片大小-->
        <img src="1.jpg" style="height: 200px;width: 200px;">
    </a>

</body>
```

当图片不存在,使用alt属性可以出现下面效果

    <img src="1.jg" style="height: 200px;width: 200px;" alt="风景">

![html-03-a](http://oi480zo5x.bkt.clouddn.com/html-03-a.jpg)

使用title属性,当鼠标悬停图片上的时候,会显示title属性

    <img src="1.jpg" style="height: 200px;width: 200px;" alt="风景" title="大风景">

![html-04-a](http://oi480zo5x.bkt.clouddn.com/html-04-a.jpg)

### H标签

```html
H1
H2
H3
H4
H5
H6
```

### input

- input type="text"         name属性,value="xx",内部默认值
- input type="password"     name属性,value="xx"
- input type="button"       value="登录",按钮
- input type="submit"       value="提交",提交按钮,表单

- input type="radio"        单选框 value, checked="checked",name属性(name相同则互斥)
- input type="checkbox"     复选框 value, checked="checked",name属性(批量获取数据)

- input type="file"         依赖form表单的一个属性 `<form enctype="multipart/form-data">`
    - 此属性会将文件一点点发给服务端
- input type="reset"        重置
- placeholder 属性            输入框添加提示

```html
    <body>
        <input type="text">
        <input type="password">
        <input type="button" value="登录1">
        <input type="submit" value="登录2">
    </body>
```

placeholder示例

```html
<!-- placeholder 输入框里面添加提示 -->
<input type="text" placeholder="用户名">
```

### form

form 表单

action,动作,将内容提交给后台,可以是一个url

使用name属性,将用户输入的内容组成一个字典提交给后台

```html
    <body>
        <!--method 指定GET POST,GET会将输入的内容放在url里面,提交后台-->
        <!--跟POST相比,没有安全不安全的区别-->
        <form action="http://localhost:8888/index" method="POST">
            <input type="text" name="user">
            <input type="text" name="email">
            <input type="password" name="pwd">
            <!-- {'user': '用户名', 'email':  '邮箱','pwd': '密码'} -->
            <input type="button" value="登录1">
            <input type="submit" value="登录2">
        </form>
    </body>
```

![html-01](http://oi480zo5x.bkt.clouddn.com/html-01.jpg)

#### 使用搜狗的搜索框

```html
    <body>
        <form action="https://www.sogou.com/web">
            <input type="text" name="query">
            <input type="submit" value="搜索">
        </form>
    </body>
```

#### 选择框

```html
        <form>
            <div>
                <p>请选择性别: </p>
                男: <input type="radio" name="gender" value="1">
                女: <input type="radio" name="gender" value="2">
            </div>
            <input type="submit" value="提交">
        </form>
```

#### checkbox

```html
<body>
    <form>
        <div>
            <p>请选择性别: </p>
            <!-- name属性相同则互斥,即二选一 -->
            男: <input type="radio" name="gender" value="1">
            女: <input type="radio" name="gender" value="2">
            <p>爱好</p>
            <!-- name 属性,批量获取数据 -->
            篮球: <input type="checkbox" name="favor" value="1">
            <!-- checked="checked" 表示默认选中-->
            台球: <input type="checkbox" name="favor" value="2" checked="checked">
            足球: <input type="checkbox" name="favor" value="3">
            网球: <input type="checkbox" name="favor" value="4">
            <p>技能</p>
            写代码 <input type="checkbox" name="skill" checked="checked">
            xx <input type="checkbox" name="skill">
            <p>上传文件</p>
            <input type="file" name="fname">
        </div>
        <input type="submit" value="提交">
        <!-- 重置所有选择 -->
        <input type="reset" value="重置">
    </form>

</body>
```

#### select 下拉框

name,内部option value,提交到后台,size,multiple

```html
        <div>
            <select name="city">
                <option value="1">北京</option>
                <option value="2">上海</option>
                <option value="3">南京</option>
                <!-- 默认选择 -->
                <option value="4" selected="selected">天津</option>
                <option value="5">成都</option>
            </select>
        </div>
```

```html
        <div>
            <!-- 同时显示多少个,  10个 -->
            <select name="city" multiple="multiple" size="10">
                <option value="1">北京</option>
                <option value="2">上海</option>
                <option value="3">南京</option>
                <option value="4" selected="selected">天津</option>
                <option value="5">成都</option>
            </select>
        </div>
```

```html
        <div>
            <select>
                <optgroup label="北京市">
                    <option>海淀区</option>
                    <option>朝阳区</option>
                </optgroup>
                <optgroup label="湖北省">
                    <option>武汉市</option>
                    <option>咸宁市</option>
                </optgroup>
            </select>
        </div>
```

![html-02](http://oi480zo5x.bkt.clouddn.com/html-02.jpg)

### textarea

    <textarea name="" id="" cols="30" rows="10"></textarea>

多行文本,name属性

### 列表

- ul
    - li
- ol
    - li
- dl
    - dt
    -dd

```html
<body>
    <!--无序列表-->
    <ul>
        <li>dfa</li>
        <li>fda</li>
        <li>fda</li>
        <li>fadf</li>
    </ul>
    <!--有序列表-->
    <ol>
        <li>dafd</li>
        <li>dafd</li>
        <li>dafd</li>
        <li>dafd</li>
    </ol>

</body>
```

![html-05-li](http://oi480zo5x.bkt.clouddn.com/html-05-li.jpg)

```html
    <dl>
        <dt>ttt</dt>
        <dd>ddd</dd>
        <dd>ddd</dd>
        <dd>ddd</dd>
        <dt>ttt</dt>
        <dd>ddd</dd>
        <dd>ddd</dd>
        <dd>ddd</dd>
    </dl>
```

![html-06-li](http://oi480zo5x.bkt.clouddn.com/html-06-li.jpg)

### 表格

- table
    - thead
        - tr
            - th
    - tbody
        - tr
            - td
- colspan = "" 横向合并
- rowspan = "" 纵向合并

```html
<body>
    <!-- border 表格增加边框 -->
    <table border="1">
        <tr>
            <td>第一行,第1列</td>
            <td>第一行,第2列</td>
            <td>第一行,第3列</td>
        </tr>
        <tr>
            <td>第二行,第1列</td>
            <td>第二行,第2列</td>
            <td>第二行,第3列</td>
        </tr>
    </table>

</body>
```

完整的table有 `thead` 和 `tbody`

```html
<body>
    <table border="1">
        <thread>
            <tr>
                <!-- th 表头 会加粗居中-->
                <th>IP</th>
                <th>端口</th>
                <th>操作</th>
            </tr>
        </thread>
        <tbody>
            <tr>
                <td>1.1.1.1</td>
                <td>80</td>
                <td>
                    <a href="1.html">查看详情</a>
                    <a href="#">修改</a>
                </td>
            </tr>
            <tr>
                <td>1.1.1.1</td>
                <td>80</td>
                <td>
                    <a href="1.html">查看详情</a>
                    <a href="#">修改</a>
                </td>
            </tr>
        </tbody>
    </table>
</body>
```

**合并单元格**

```html
<body>
<table border="1">
    <tr>
        <th>表头</th>
        <th>表头</th>
        <th>表头</th>
        <th>表头</th>
    </tr>
    <tr>
        <td colspan="2">1</td>
        <td>1</td>
        <td>1</td>
    </tr>
    <tr>
        <td>1</td>
        <td>1</td>
        <td>1</td>
        <td rowspan="3">1</td>
    </tr>
    <tr>
        <td>1</td>
        <td>1</td>
        <td>1</td>
    </tr>
    <tr>
        <td>1</td>
        <td>1</td>
        <td>1</td>
    </tr>
</table>

</body>
```

![html-07-table](http://oi480zo5x.bkt.clouddn.com/html-07-table.jpg)

### label

用于点击文件,使得关联的标签获取光标

```html
<body>
    <label for="username">用户名: </label>
    <input id="username" type="text" name="user">
</body>
```

![html-08-label](http://oi480zo5x.bkt.clouddn.com/html-08-label.jpg)

### fieldset

不常用,知道就行

- filedset
    - legend

```html
<body>
    <filedset>
        <legend>登录</legend>
        <label for="usernmae">用户名: </label>
        <input id="username" type="text" name="user"/>
        <br/>
        <label for="pwd">密&nbsp;&nbsp;&nbsp;&nbsp;码: </label>
        <input id="pwd" type="password" name="pwd"/>
    </filedset>
</body>
```
