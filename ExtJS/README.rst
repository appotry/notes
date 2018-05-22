Ext JS
======

-  `官网 <https://www.sencha.com/products/extjs/#overview>`__
-  `中文站 <http://extjs.org.cn/>`__
-  http://www.cnblogs.com/mlzs/p/5802376.html

项目管理 创建项目：指定SDK，指定仅生成Classic项目 sencha -sdk
~/ext-6.2.0/ generate app classic BeApp ./BeApp

项目结构

.. code:: shell

    bootstrap.* 仅开发环境使用，微加载文件
    ext/        仅开发环境使用，库文件夹
    build/      仅开发环境使用，构建文件夹

以上文件不需要进行代码版本管理，可以通过install + build命令重建。

sencha app install –framework=~/ext-6.2.0/ sencha app build

项目编辑 添加模块： sencha generate model User id:int,name,email

添加视图： sencha generate view foo.Thing

添加视图：指定基类 sencha generate view -base Ext.tab.Panel foo.Thing

添加控制器： sencha generate controller Central

预览项目 sencha app watch

预览地址：\ http://localhost:1841/

构建项目： sencha app build production

.. code:: javascript

    // 查询数据
        onClickSearch: function () {
            console.log('查询数据');

            var grid = this.lookupReference('gridDictionaryForMain');
            var gridStore = grid.getStore();

            gridStore.getProxy().setExtraParam('sex', '1');
            gridStore.reload(
                {
                    callback: function (record, option, success) {
                        if (!success) {
                            Ext.Msg.alert('提示信息', '操作失败');
                        }
                    }
                });
        },
