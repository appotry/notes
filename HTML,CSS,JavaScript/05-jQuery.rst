jQuery
======

JavaScript库

`jQuery <https://jquery.com/>`__

`jQuery API 速查表 <http://jquery.cuishifeng.cn/>`__

总结
----

-  调用(两种方式)

   -  ``jQuery.``
   -  ``$().``

-  转换

   -  jQuery对象[0] –> DOM对象
   -  DOM对象 –> $(DOM对象)

查找元素
--------

.. code:: html

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

id
~~

.. code:: javascript

    jQuery('#i10')

    $('#i10')
    [div#i10.c1, context: document, selector: "#i10"]

    DOM对象
    $('#i10')[0]

class
~~~~~

.. code:: javascript

    $('.c1')

标签
~~~~

.. code:: javascript

    $('a')

组合
~~~~

.. code:: javascript

    $('a,.c2')
    $('a,.c2,#i10')

层级
~~~~

.. code:: javascript

    // 子子孙孙
    $('#i10 a')
    // 儿子
    $('#i10>a')

基本筛选器
~~~~~~~~~~

-  ``:first`` // 获取匹配的第一个元素
-  ``:last``// 获取匹配的最后一个元素
-  ``:eq(index)`` // 匹配一个给定索引值得元素

.. code:: javascript

    $('#i10>a:first')
    $('#i10>a:first')[0]
    $('#i10>a:eq(1)') // 索引值从0开始计算

示例

.. code:: html

    <ul>
        <li>list item 1</li>
        <li>list item 2</li>
        <li>list item 3</li>
        <li>list item 4</li>
        <li>list item 5</li>
    </ul>

.. code:: javascript

    jQuery 代码:
    $('li:first');

属性
~~~~

.. code:: javascript

    $('[name]') // 具有name属性的所有标签
    $('[name="123"]') // name属性等于123的标签

.. code:: html

    <body>
        <input type="text">
        <input type="text">
        <input type="file">
        <input type="password">

        <script src="jquery.js"></script>
    </body>

.. code:: javascript

    $('[type="text"]')
    $('input[type="text"]')

    // 针对表单,有如下方法
    $(':text')
    $(':password')

筛选
----

next
~~~~

下一个

::

    $(this).next()

prev
~~~~

上一个

::

    $(this).prev()

children
~~~~~~~~

::

    $('#i1').children()

parent
~~~~~~

父

::

    $(this).parent()

siblings
~~~~~~~~

兄弟

::

    $(this).siblings()

find
~~~~

子子孙孙中查找

::

    $(this).find()

操作元素
--------

样式操作
~~~~~~~~

addClass
^^^^^^^^

removeClass
^^^^^^^^^^^

toggleClass
^^^^^^^^^^^

属性操作
~~~~~~~~

attr
^^^^

-  传一个参数,获取属性

-  传两个参数,设置属性

.. code:: javascript

    $(..).attr('n')
    $(..).attr('n','v')

removeAttr
^^^^^^^^^^

.. code:: javascript

    $(..).removeAttr('n')

prop
^^^^

**专门用于CheckBox,radio**

.. code:: javascript

    $(':checkbox').prop('checked');       // 获取值
    $(':checkbox').prop('checked',false); // 设置值

文档处理
--------

append
~~~~~~

prepend
~~~~~~~

after
~~~~~

before
~~~~~~

remove
~~~~~~

empty
~~~~~

clone
~~~~~

技巧
----

jQuery内置循环
~~~~~~~~~~~~~~

.. code:: javascript

    $(':checkbox').each(function (k) {
                   // k 当前索引
                    if(this.checked){
                        this.checked = false; // this,DOM当前循环的元素
                    }else{
                        this.checked = true;
                    }
                })

三目运算
~~~~~~~~

.. code:: javascript

    var v = 条件 ? 真值 : 假值

实例
----

复选框(全选,反选,取消)
~~~~~~~~~~~~~~~~~~~~~~

.. code:: html

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

使用DOM 跟 使用jQuery绑定时间的方式不一样

.. code:: javascript

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

xx
~~

.. code:: javascript

    $(this).next().removeClass('hide');
    // 链式编程
    $(this).parent().siblings().find('.content').addClass('hide')
