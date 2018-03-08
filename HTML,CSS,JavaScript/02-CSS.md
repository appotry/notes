# CSS

## 总结

1. 在标签上设置style属性
    - `background-color: #2459a2;`
    - `height: 48px;`
2. 编写css样式
    - 标签的style属性
    - style标签,写在head标签里面,style标签中写样式
    - 选择器
        - id选择器
            - `#i1 {}`
        - class选择器 (最常用) *****
            - `.c1 {}`
        - 标签选择器 (所有div设置此样式)
            - `div {}`
        - 关联选择器
            - `span div {}`
        - 层级选择器(空格)
            - `.c1 .c2 div {}`
        - 组合选择器(逗号)
            - `#c1,.c2,div {}`
        - 属性选择器
            - `.c1[name="xxx"] { background-color: #ff6fa6; }`
        - 属性优先级: 标签上style优先,编写顺序,就近原则(或者使用!important,绝对生效)
3. css样式也可以写在单独的文件中
    - `<link rel="stylesheet" href="xxx.css"/>`
4. 注释
    - `/*   */`

设置id之后,会使用head里面的style设置的样式

## 选择器

- id选择器
- class选择器
- 标签选择器
- 关联选择器
- 层级选择器
- 组合选择器
- 属性选择器

### id选择器

### class选择器

```html
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        <!-- id 选择器 -->
        #i1{
            background-color: #2459a2;
            height: 48px;
        }
        <!-- class 选择器 -->
        .c1 {
            background-color: #ffff5a;
            height: 20px;
        }
    </style>
</head>
<body>
    <div id="i1">xx</div>
    <span class="c1">23</span>
    <div class="c1">32</div>
</body>
</html>
```

![css-01-选择器](http://oi480zo5x.bkt.clouddn.com/css-01-选择器.jpg)

### 标签选择器

```html
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        <!-- 标签选择器 在所有div上设置此样式-->
        div {
            background-color: deeppink;
            height: 20px;
        }
    </style>
</head>
<body>
    <div>123</div>
    <span>dfd</span>
    <div>1xxx</div>
</body>
```

![css-02-标签选择器](http://oi480zo5x.bkt.clouddn.com/css-02-标签选择器.jpg)

### 关联选择器

```html
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        <!-- span 下的div 标签才会用此样式 -->
        span div {
            background-color: #00a7d0;
            height: 30px;
        }
    </style>
</head>
<body>
    <div>fdsfsd</div>
    <span>
        <div>span div</div>
    </span>

</body>
```

### 层级选择器

最底层的才会应用style

```html
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .c1 .c2 div {
            background-color: #00a7d0;
            height: 30px;
        }
    </style>
</head>
<body>
    <div>fdsfsd</div>
    <span>
        <div class="c1">
            <span class="c2">
                <div>1234</div>
            </span>
        </div>

    </span>

</body>
</html>
```

![css-03-层级选择器](http://oi480zo5x.bkt.clouddn.com/css-03-层级选择器.jpg)

### 组合选择器

```html
    <style>
        .c1,.c2,#i1,div {
            background-color: #00a7d0;
            height: 30px;
        }
    </style>
```

### 属性选择器

对选择到的标签通过属性再进行一次筛选

```html
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .c1[name="xxx"] {
            background-color: #ff6fa6;
        }
    </style>
</head>
<body>
    <div class="c1" name="xxx">name=xxx</div>
    <div class="c1">class=c1</div>
</body>
</html>
```

![css-04-属性选择器](http://oi480zo5x.bkt.clouddn.com/css-04-属性选择器.jpg)

### 属性优先级

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .c2 {
            font-size: 58px;
            color: black;
        }
        .c1 {
            background-color: red;
            color: white;
        }
    </style>
</head>
<body>
    <div class="c1 c2" style="color: darkslateblue;">qwe</div>
</body>
</html>
```

![css-05-属性优先级](http://oi480zo5x.bkt.clouddn.com/css-05-属性优先级.jpg)

### 从文件调用css

本质就是把文件里面的css 样式拿到head里面

```html
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <!-- 加载css文件 如果是上层目录就是../-->
    <link rel="stylesheet" href="css/commons.css">
</head>
<body>
    <div class="c1 c2" style="color: darkslateblue;">qwe</div>
</body>
</html>
```

> css/commons.css文件内容

```css
.c2 {
    font-size: 58px;
    color: black;
}

.c1 {
    background-color: red;
    color: white;
}
```

## sytle

### 边框

- border: 1px solid red; 宽度,样式,颜色
- border-left

- height            高度,百分比,像素
- width             宽度,百分比,像素
- text-align:center 水平方向居中
- line-height       垂直方向根据标签高度
- color             字体颜色
- font-size         字体大小
- font-weight       字体加粗

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <div style="width: 80%;
    height: 48px;
    border: 1px solid red;
    font-size: 16px;
    text-align: center;
    line-height: 48px;
    font-weight: bold;
    ">qwe</div>
</body>
</html>
```

```html
<body>
    <div style="width: 20%; background-color: red; float: left;">1</div>
    <div style="width: 80%; background-color: black; float: right;">2</div>

</body>
```

### 背景

### float

- 让标签浮起来,块级标签也可以堆叠
- 老子管不住
    - `<div style="clear: both;"></div>`

```html
<body>
    <div style="width: 20%; background-color: red; ">1</div>
    <div style="width: 80%; background-color: pink;">2</div>

    <div style="width: 20%; background-color: red; float: left;">1</div>
    <div style="width: 80%; background-color: pink; float: right;">2</div>
</body>
```

![css-06-float](http://oi480zo5x.bkt.clouddn.com/css-06-float.jpg)

#### 父亲没有被撑起来的解决办法

下面的示例,子孙没有将父容器撑起来

```html
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <div style="width: 300px;border: 1px solid red;">
        <div style="width: 96px; height: 30px; border: 1px solid green;float: left;"></div>
        <div style="width: 96px; height: 30px; border: 1px solid green;float: left;"></div>
        <div style="width: 96px; height: 30px; border: 1px solid green;float: left;"></div>
        <div style="width: 96px; height: 30px; border: 1px solid green;float: left;"></div>
        <div style="width: 96px; height: 30px; border: 1px solid green;float: left;"></div>
        <div style="width: 96px; height: 30px; border: 1px solid green;float: left;"></div>
        <div style="width: 96px; height: 30px; border: 1px solid green;float: left;"></div>
        <div style="width: 96px; height: 30px; border: 1px solid green;float: left;"></div>

    </div>
</body>
</html>
```

![css-07-border](http://oi480zo5x.bkt.clouddn.com/css-07-border.jpg)

解决办法 加一个`<div style="clear: both;"></div>`即可

```html
<body>
    <div style="width: 300px;border: 1px solid red;">
        <div style="width: 96px; height: 30px; border: 1px solid green;float: left;"></div>
        ...省略...
        <div style="width: 96px; height: 30px; border: 1px solid green;float: left;"></div>
        <!-- 使用 clear: both; -->
        <div style="clear: both;"></div>
    </div>
</body>
```

### display

- display: inline;
- display: block;
- display: inline-block;
    - 具有inline,默认自己有多少占多少
    - 具有block,可以设置高度,宽度,padding margin
- display: none;
    - 让标签消失,视频网站开灯关灯就是这样实现的

- 行内标签: 无法设置高度,宽度,padding margin
- 块级标签: 设置高度,宽度,padding margin

让块级标签具有行内标签的属性

```html
<body>
    <div style="background-color: red; display: inline;">qwe</div>
    <div style="background-color: red; display: block;">qwe</div>

</body>
```

![css-08-display](http://oi480zo5x.bkt.clouddn.com/css-08-display.jpg)

### padding margin(0,auto)

边距

- margin: 外边距
- padding: 内边距
    - `padding: 0 10px 0 10px;`  上右下左

auto 左右两边居中

margin:0 auto; 顶端跟浏览器没有间隙

```html
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .pg-header {
            height: 38px;
            background-color: purple;
        }
    </style>
</head>
<body style="margin: 0 auto;">
    <div class="pg-header">1</div>
</body>
</html>
```

### position

- fiexd     固定在页面的某个位置,滚轮滚动也会在该位置
- relative + absolute

`relative + absolute`

```html
<div style="position: relative;">
    <div style="position: absolute; left: 0;bottom: 0;"></div>
</div>
```

以父标签为基准布局

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body style="margin: 0 auto;">

    <div style="position: relative; width: 500px; height: 200px; border: 1px solid red; margin: 0 auto;">
        <div style="position: absolute; left: 0;bottom: 0; width: 50px; height: 50px;background-color: black;"></div>
    </div>

    <div style="position: relative;width: 500px;height: 200px;border: 1px solid red;margin: 0 auto;">
        <div style="position: absolute;right: 0;bottom: 0;width: 50px;height: 50px;background-color: lightskyblue;"></div>
    </div>

    <div style="position: relative;width: 500px;height: 200px; border: 1px solid red; margin: 0 auto;">
        <div style="position: absolute;right: 0;top: 0;width: 50px;height: 50px;background-color: black ;"></div>
    </div>

</body>
</html>
```

![css-10-position](http://oi480zo5x.bkt.clouddn.com/css-10-position.jpg)

### opacity

透明 `0~1`

#### 模态框示例

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <!-- z-index 数字越大就越在上层 -->
    <!-- 可以加上 display:none 先隐藏, 后面使用JavaScript实现,点击之后出现 -->
    <!-- margin-left: -250px;margin-top: -250px; 配合实现容器居中 -->
    <div style="z-index: 10;position: fixed;top: 50%;left: 50%;background-color: white;width: 500px;height: 500px;margin-left: -250px;margin-top: -250px;">
        <!-- placeholder 输入框里面添加提示 -->
        <input type="text" placeholder="用户名">
        <input type="password" placeholder="密码">
    </div>
    <!-- 遮罩层 opacity 透明度 -->
    <div style="z-index: 9; position: fixed; background-color: black;
    top: 0;
    bottom: 0;
    right: 0;
    left: 0;
    opacity: 0.5;
    "></div>

    <div style="height: 5000px;background-color: green;">aqweq</div>

</body>
</html>
```

![css-11-opacity](http://oi480zo5x.bkt.clouddn.com/css-11-opacity.jpg)

### z-index

层级顺序,看opacity中的示例

数字越大越在上层

### overflow: hidden,auto

- hidden 内容会被修剪，并且其余内容是不可见的。
- auto 如果内容被修剪，则浏览器会显示滚动条以便查看其余的内容。

```html
<body>
    <!-- 内容被修剪，浏览器会显示滚动条以便查看其余的内容 -->
    <div style="height: 200px;width: 200px; overflow: auto;">
        <img src="1.jpg"/>
    </div>

    <div style="height: 200px;width: 200px;overflow: hidden;">
        <img src="1.jpg"/>
    </div>
</body>
```

### background

### hover

当鼠标移动到标签上是,设置的属性才生效

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .pg-header {
            position: fixed;
            right:0;
            left:0;
            top:0;
            height: 48px;
            background-color: cadetblue;
            line-height: 48px;
        }
        .pg-body {
            margin-top: 50px;
        }
        .w{
            /* 固定宽度,防止窗口拖小之后页面变形 */
            width: 980px;
            margin:0 auto
        }
        .pg-header .menu {
            display: inline-block;
            /* 设置内边距属性 上右下左 */
            padding: 0 10px 0 10px;
            background-color: cadetblue;
            color: black;
        }
        /* hover 当鼠标移动到当前标签上时,以下css属性才生效 */
        .pg-header .menu:hover {
            background-color: lightskyblue;
        }
    </style>
</head>
<body>
    <div class="pg-header">
        <div class="w">
            <a class="logo">LOGO</a>
            <a class="menu">全部</a>
            <a class="menu">xx</a>
            <a class="menu">qq</a>
        </div>
    </div>

    <div class="pg-body">
        <div class="w">a</div>
    </div>
</body>
</html>
```

## 实例

### 导航栏

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .pg-header {
            height: 38px;
            background: lightskyblue;
            position: fixed;
            top: 0;
            right: 0;
            left: 0;
        }
        .c1 {
            line-height: 38px;
            float: left;
            margin-left: 20%;
        }
    </style>
</head>
<body style="margin: 0 auto;">
    <div class="pg-header">
        <div style="width: 980px; margin: 0;">
            <div style="float: left; line-height: 38px;">收藏本站</div>
            <div style="float: right;">
                <a style="line-height: 38px;">登录</a>
                <a style="line-height: 38px;">注册</a>
            </div>
            <div style="clear: both;"></div>
        </div>
    </div>
    <div style="height: 5000px;"></div>

</body>
</html>
```

### 页面右下角添加 返回顶端 按钮

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .pg-header {
            height: 38px;
            background: lightskyblue;
        }

        .c1 {
            line-height: 38px;
            float: left;
            margin-left: 20%;
        }
    </style>
</head>
<body style="margin: 0 auto;">
    <div class="pg-header">
        <div style="width: 980px; margin: 0;">
            <div style="float: left; line-height: 38px;">收藏本站</div>
            <div style="float: right;">
                <a style="line-height: 38px;">登录</a>
                <a style="line-height: 38px;">注册</a>
            </div>
            <div style="clear: both;"></div>
        </div>
    </div>

    <div style="height: 5000px;"></div>

    <div onclick="goTop();" style="width: 70px; height: 48px;
    line-height: 50px;
    background-color: #00a7d0; color: white;
    position: fixed;
    bottom: 20px;
    right: 20px;
    margin: 0 auto;
    ">返回顶端</div>

    <script>
        function goTop() {
            document.body.scrollTop = 0;
        }
    </script>
</body>
</html>
```

![css-09-返回顶端](http://oi480zo5x.bkt.clouddn.com/css-09-返回顶端.jpg)










