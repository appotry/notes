csv
===

使用Python标准库,csv模块

`官方使用参考 <https://docs.python.org/3.5/library/csv.html>`__

使用Python生成csv表格,用Excel打开的时候,中文乱码
------------------------------------------------

解决办法: 在文件开头加BOM

`参考链接 <https://segmentfault.com/a/1190000004321605>`__

.. code:: python

    # 需要 import codecs
    with open('user_info.csv', 'wb') as csvfile:
            csvfile.write(codecs.BOM_UTF8)

示例

.. code:: python

    def write_csv(user_info):
        """
        写csv
        :param user_info:  所有用户信息,整个为一个字典,所有value分别是一个包含一个用户信息的字典
        :return:
        """

        # 防止乱码
        with open('user_info.csv', 'wb') as csvfile:
            csvfile.write(codecs.BOM_UTF8)

        with open('user_info.csv', 'a+', encoding="utf-8") as csvfile:
            fieldnames = ['Name','DoorName','CardNO','GroopName']
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

            writer.writeheader()
            rows = []
            # writer.writerows([{'DoorName': '二门', 'CardNO': 30000, 'GroopName': '内部运营\\行政', 'Name': '王麻子'},{'DoorName': '二门', 'CardNO': 40000, 'GroopName': '内部运营\\行政', 'Name': '张三'}])
            for user in user_info.values():
                rows.append(user)
            writer.writerows(rows)
