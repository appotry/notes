# 1. jQuery

JavaScript库

[jQuery](https://jquery.com/)

[jQuery API 速查表](http://jquery.cuishifeng.cn/)

<!-- TOC -->

- [1. jQuery](#1-jquery)
    - [1.1. 总结](#11-总结)
    - [1.2. 查找元素](#12-查找元素)
        - [1.2.1. id](#121-id)
        - [1.2.2. class](#122-class)
        - [1.2.3. 标签](#123-标签)
        - [1.2.4. 组合](#124-组合)
        - [1.2.5. 层级](#125-层级)
        - [1.2.6. 基本筛选器](#126-基本筛选器)
        - [1.2.7. 属性](#127-属性)
    - [1.3. 筛选](#13-筛选)
        - [1.3.1. next](#131-next)
        - [1.3.2. prev](#132-prev)
        - [1.3.3. children](#133-children)
        - [1.3.4. parent](#134-parent)
        - [1.3.5. siblings](#135-siblings)
        - [1.3.6. find](#136-find)
    - [1.4. 操作元素](#14-操作元素)
        - [1.4.1. 样式操作](#141-样式操作)
            - [1.4.1.1. addClass](#1411-addclass)
            - [1.4.1.2. removeClass](#1412-removeclass)
            - [1.4.1.3. toggleClass](#1413-toggleclass)
        - [1.4.2. 属性操作](#142-属性操作)
            - [1.4.2.1. attr](#1421-attr)
            - [1.4.2.2. removeAttr](#1422-removeattr)
            - [1.4.2.3. prop](#1423-prop)
    - [1.5. 文档处理](#15-文档处理)
        - [1.5.1. append](#151-append)
        - [1.5.2. prepend](#152-prepend)
        - [1.5.3. after](#153-after)
        - [1.5.4. before](#154-before)
        - [1.5.5. remove](#155-remove)
        - [1.5.6. empty](#156-empty)
        - [1.5.7. clone](#157-clone)
    - [1.6. 技巧](#16-技巧)
        - [1.6.1. jQuery内置循环](#161-jquery内置循环)
        - [1.6.2. 三目运算](#162-三目运算)
    - [1.7. 实例](#17-实例)
        - [1.7.1. 复选框(全选,反选,取消)](#171-复选框全选反选取消)
        - [1.7.2. xx](#172-xx)

<!-- /TOC -->

## 1.1. 总结

- 调用(两种方式)
    - `jQuery.`
    - `$().`
- 转换
    - jQuery对象[0]   --> DOM对象
    - DOM对象         --> $(DOM对象)

## 1.2. 查找元素

```html
<body>
    <div id="i10" class="c1">
        <a>f</a>
        <a>f</a>
    </div>
    <div class="c2">
        <div class="c3"></div>
    </div>
    <script src="jquery.js"></script>
</body>
```

### 1.2.1. id

```javascript
jQuery('#i10')

$('#i10')
[div#i10.c1, context: document, selector: "#i10"]

DOM对象
$('#i10')[0]
```

### 1.2.2. class

```javascript
$('.c1')
```

### 1.2.3. 标签

```javascript
$('a')
```

### 1.2.4. 组合

```javascript
$('a,.c2')
$('a,.c2,#i10')
```

### 1.2.5. 层级

```javascript
// 子子孙孙
$('#i10 a')
// 儿子
$('#i10>a')
```

### 1.2.6. 基本筛选器

- `:first` // 获取匹配的第一个元素
- `:last`// 获取匹配的最后一个元素
- `:eq(index)` // 匹配一个给定索引值得元素

```javascript
$('#i10>a:first')
$('#i10>a:first')[0]
$('#i10>a:eq(1)') // 索引值从0开始计算
```

示例

```html
<ul>
    <li>list item 1</li>
    <li>list item 2</li>
    <li>list item 3</li>
    <li>list item 4</li>
    <li>list item 5</li>
</ul>
```

```javascript
jQuery 代码:
$('li:first');
```

### 1.2.7. 属性

```javascript
$('[name]') // 具有name属性的所有标签
$('[name="123"]') // name属性等于123的标签
```

```html
<body>
    <input type="text">
    <input type="text">
    <input type="file">
    <input type="password">

    <script src="jquery.js"></script>
</body>
```

```javascript
$('[type="text"]')
$('input[type="text"]')

// 针对表单,有如下方法
$(':text')
$(':password')
```

## 1.3. 筛选

### 1.3.1. next

下一个

    $(this).next()

### 1.3.2. prev

上一个

    $(this).prev()

### 1.3.3. children

    $('#i1').children()

### 1.3.4. parent

父

    $(this).parent()

### 1.3.5. siblings

兄弟

    $(this).siblings()

### 1.3.6. find

子子孙孙中查找

    $(this).find()

## 1.4. 操作元素

### 1.4.1. 样式操作

#### 1.4.1.1. addClass

#### 1.4.1.2. removeClass

#### 1.4.1.3. toggleClass

### 1.4.2. 属性操作

#### 1.4.2.1. attr

- 传一个参数,获取属性

- 传两个参数,设置属性

```javascript
$(..).attr('n')
$(..).attr('n','v')
```

#### 1.4.2.2. removeAttr

```javascript
$(..).removeAttr('n')
```

#### 1.4.2.3. prop

**专门用于CheckBox,radio**

```javascript
$(':checkbox').prop('checked');       // 获取值
$(':checkbox').prop('checked',false); // 设置值
```

## 1.5. 文档处理

### 1.5.1. append

### 1.5.2. prepend

### 1.5.3. after

### 1.5.4. before

### 1.5.5. remove

### 1.5.6. empty

### 1.5.7. clone

## 1.6. 技巧

### 1.6.1. jQuery内置循环

```javascript
$(':checkbox').each(function (k) {
  			   // k 当前索引
                if(this.checked){
                    this.checked = false; // this,DOM当前循环的元素
                }else{
                    this.checked = true;
                }
            })
```

### 1.6.2. 三目运算

```javascript
var v = 条件 ? 真值 : 假值
```

## 1.7. 实例

### 1.7.1. 复选框(全选,反选,取消)

```html
    <div id="i1">
        <input type="checkbox" value="1">daf
        <input type="checkbox">ew
        <input type="checkbox">daf
        <input type="checkbox">ewqe
        <input type="checkbox">ewq
        <input type="checkbox">ewq
        <input id="b1" type="button" value="全选">
        <input id="b2" type="button" value="取消">
        <input id="b3" type="button" value="反选">

    </div>
```

使用DOM 跟 使用jQuery绑定时间的方式不一样

```javascript
<script src="jquery.js"></script>
    <script>
        /* $('#i1>input[type="button"]')[0].onclick = function () {
            alert('123');} */

        // 全选
        $('#b1').click(function () {
            $(':checkbox').prop('checked',true)
        });

        // 取消
        $('#b2').click(function () {
            $(':checkbox').prop('checked',false);

        });

        // 反选
        $('#b3').click(function () {
            $(':checkbox').each(function (k) {
                // k表示当前索引
                // this,DOM,当前循环的元素 $(this)
                if(this.checked){
                    this.checked = false;
                }else{
                    this.checked = true;
                }
            })
        })
        // 反选
        /* 三元运算
        $('#b3').click(function () {
            $(':checkbox').each(function (k) {
                $(this).prop('checked', $(this).prop('checked') ? false : true);

            })}
        )*/
```



### 1.7.2. xx

```javascript
$(this).next().removeClass('hide');
// 链式编程
$(this).parent().siblings().find('.content').addClass('hide')
```

