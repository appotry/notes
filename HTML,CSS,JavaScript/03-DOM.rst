DOM
===

文档对象模型（Document Object
Model，DOM）是一种用于HTML和XML文档的编程接口。它给文档提供了一种结构化的表示方法，可以改变文档的内容和呈现方式。我们最为关心的是，DOM把网页和脚本以及其他的编程语言联系了起来。DOM属于浏览器，而不是JavaScript语言规范里的规定的核心内容。

总结
----

-  查找标签

   -  直接查找

      -  ``document.getElementById('i1')`` 根据ID获取一个标签
      -  ``document.getElementsByName`` 根据name属性获取标签集合
      -  ``document.getElementsByClassName(c1)``
         根据class属性获取标签集合 (返回列表)
      -  ``document.getElementsByTagName('div')`` 根据标签名获取标签集合

   -  间接查找

      -  ``tag = document.getElementById('i2')``
      -  parentElement // 父节点标签元素
      -  children // 所有子标签
      -  firstElementChild // 第一个子标签元素
      -  lastElementChild // 最后一个子标签元素
      -  nextElementtSibling // 下一个兄弟标签元素
      -  previousElementSibling // 上一个兄弟标签元素

-  操作标签

   -  innerText

      -  获取标签中的文本内容 ``标签.innerText``
      -  设置标签中的文本内容 ``标签.innerText = "xxx"``

   -  className

      -  tag.className 直接整体做操作
      -  tag.classList.add(‘样式名’) 添加指定样式
      -  tag.classList.remove(‘样式名’) 删除指定样式

   -  checkbox

      -  获取值 checkbox对象.checked
      -  设置值 checkbox对象.checked = true (或false)

查找元素
--------

直接查找
~~~~~~~~

-  ``document.getElementById`` 根据ID获取一个标签
-  ``document.getElementsByName`` 根据name属性获取标签集合
-  ``document.getElementsByClassName`` 根据class属性获取标签集合
-  ``document.getElementsByTagName`` 根据标签名获取标签集合

间接查找
~~~~~~~~

-  parentNode // 父节点
-  childNodes // 所有子节点
-  firstChild // 第一个子节点
-  lastChild // 最后一个子节点
-  nextSibling // 下一个兄弟节点
-  previousSibling // 上一个兄弟节点

-  parentElement // 父节点标签元素
-  children // 所有子标签
-  firstElementChild // 第一个子标签元素
-  lastElementChild // 最后一个子标签元素
-  nextElementtSibling // 下一个兄弟标签元素
-  previousElementSibling // 上一个兄弟标签元素

.. code:: html

    <body>
        <div>
            <div>
                1
            </div>
            <div></div>
        </div>

        <div>
            <div id="i2">2</div>
            <div></div>
        </div>
        <div>
            <div>3</div>
            <div></div>
        </div>
    </body>

.. code:: javascript

    tag = document.getElementById('i2')
    <div id=​"i2">​2​</div>​
    tag.parentElement
    tag.parentElement.children
    tag.parentElement.firstElementChild
    tag.parentElement.lastElementChild
    tag.parentElement.lastElementChild.nextElementSibling
    tag.parentElement.nextElementSibling
    tag.parentElement.lastElementChild
    tag.parentElement.lastElementChild.previousElementSibling
    tag.previousElementSibling
    tag.nextElementSibling

操作
----

内容
~~~~

-  innerText 文本
-  inneHTML HTML内容
-  value 值
-  outerText

.. code:: html

    <body>
        <div id="i1">我是i1</div>
        <a>qwe</a>
        <a>q32</a>
        <a>qwe312</a>
    </body>

.. figure:: http://oi480zo5x.bkt.clouddn.com/js-03-get.jpg
   :alt: js-03-get

   js-03-get

.. figure:: http://oi480zo5x.bkt.clouddn.com/js-04-get.jpg
   :alt: js-04-get

   js-04-get

属性
~~~~

-  attributes 获取所有标签属性
-  setAttribute(key,value) 设置标签属性
-  getAttribute(key) 获取指定标签属性

实例
----

模态框
~~~~~~

.. code:: html

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
        <style>
            .hide {
                display: none;
            }

            .c1 {
                position: fixed;
                left: 0;
                right: 0;
                top: 0;
                bottom: 0;
                background-color: black;
                opacity: 0.5;
                z-index: 9;
            }

            .c2 {
                width: 500px;
                height: 500px;
                background-color: white;
                position: fixed;
                left: 50%;
                top: 50%;
                margin-left: -250px;
                margin-top: -250px;
                z-index: 10;

            }
        </style>
    </head>
    <body>
    <div>
        <input type="button" value="添加" onclick="showModel()"/>
        <input type="button" value="全选" onclick="chooseAll()"/>
        <input type="button" value="反选" onclick="reverseAll()"/>
        <input type="button" value="取消" onclick="cancleAll()"/>
        <table>
            <thead>
            <tr>
                <th>选择</th>
                <th>IP</th>
                <th>端口</th>
            </tr>
            </thead>
            <tbody id="tb">
            <tr>
                <td>
                    <input type="checkbox"/>
                </td>
                <td>192.168.1.2</td>
                <td>8080</td>
            </tr>
            <tr>
                <td><input type="checkbox"/></td>
                <td>192.168.2.1</td>
                <td>80</td>
            </tr>
            </tbody>

        </table>
    </div>

    <!-- 遮罩层开始 -->
    <div id="i1" class="c1 hide"></div>
    <!-- 遮罩层结束 -->

    <!-- 弹出框 -->
    <div id="i2" class="c2 hide">
        <p>
            <input id="d1" type="text" name="ip" value="" placeholder="IP"/>
            <input id="d2" type="text" name="port" value="" placeholder="端口"/>
        </p>
        <p>
            <input type="button" value="取消" onclick="hideModel()">
            <input type="button" value="确定" onclick="addServer()">
        </p>
    </div>

    <script>
        // 显示弹出框
        function showModel() {
            document.getElementById('i1').classList.remove('hide');
            document.getElementById('i2').classList.remove('hide');
        }
        // 全选
        function chooseAll(){
            var tbody = document.getElementById('tb');
            var tr_list = tbody.children;
            for(var i=0;i<tr_list.length;i++){
                var current_tr = tr_list[i];
                var checkbox = current_tr.children[0].children[0];
                checkbox.checked = true;
            }
        }
        // 反选
        function reverseAll(){
            var tbody = document.getElementById('tb');
            var tr_list = tbody.children;
            for(var i=0;i<tr_list.length;i++){
                var current_tr = tr_list[i];
                var checkbox = current_tr.children[0].children[0];
                if(checkbox.checked){
                    checkbox.checked = false;
                }else{
                    checkbox.checked = true;
                }

            }
        }
        // 取消所有
        function cancleAll() {
        var tbody = document.getElementById('tb');
        var tr_list = tbody.children;
        for(var i=0;i<tr_list.length;i++){
            var current_tr = tr_list[i];
            var checkbox = current_tr.children[0].children[0];
            checkbox.checked = false;
            }
        }
        // 隐藏弹出框
        function hideModel() {
            document.getElementById('i1').classList.add('hide');
            document.getElementById('i2').classList.add('hide');

        }
        // 往表格添加内容
        function addServer(){
            var tag = document.getElementById('tb');
            // 创建标签
            var new_tag = document.createElement('tr');
            // 获取用户输入内容
            var ip = document.getElementById("d1").value;
            var port = document.getElementById("d2").value;
            // 设置标签内容
            new_tag.innerHTML = '<td><input type="checkbox"/></td><td>' + ip + '</td><td>' + port +'</td>';
            // 添加到表格
            tag.appendChild(new_tag);
            hideModel()

        }
    </script>
    </body>
    </html>

左侧菜单栏
~~~~~~~~~~

.. code:: html

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
        <style>
            .hide {
                display: none;
            }
            .item .header {
                background-color: cadetblue;
                height: 35px;
                color: white;
                line-height: 35px;

            }
        </style>
    </head>
    <body>
        <div style="height: 48px;"></div>

        <div style="width: 300px;">
            <div class="item">
                <div id="i1" class="header" onclick="changeMenu('i1');">菜单一</div>
                <div class="content">
                    <div>内容1</div>
                    <div>内容2</div>
                    <div>内容3</div>
                </div>
            </div>
            <div class="item">
                <div id="i2" class="header" onclick="changeMenu('i2');">菜单二</div>
                <div class="content hide">
                    <div>内容1</div>
                    <div>内容2</div>
                    <div>内容3</div>
                </div>
            </div>
            <div class="item">
                <div id="i3" class="header" onclick="changeMenu('i3');">菜单三</div>
                <div class="content hide">
                    <div>内容1</div>
                    <div>内容2</div>
                    <div>内容3</div>
                </div>
            </div>
            <div class="item">
                <div id="i4" class="header" onclick="changeMenu('i4');">菜单四</div>
                <div class="content hide">
                    <div>内容1</div>
                    <div>内容2</div>
                    <div>内容3</div>
                </div>
            </div>
        </div>

        <script>
            function changeMenu(nid) {
                var tag = document.getElementById(nid);
                var item_list = tag.parentElement.parentElement.children;
                // 隐藏所有
                for(var i=0;i<item_list.length;i++){
                    var current_item = item_list[i];
                    current_item.children[1].classList.add('hide');
                }
                // 打开当前标签
                tag.nextElementSibling.classList.remove('hide')
            }
        </script>
    </body>
    </html>
