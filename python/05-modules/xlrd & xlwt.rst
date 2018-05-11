xlrd & xlwt 处理Excel
=====================

使用第三方库xlrd和xlwt，分别用于excel读和写

安装

::

    pip3 install xlrd
    pip3 install xlwt

写表格示例
----------

.. code:: python

    import xlwt


    def set_style(name,height,bold=False):
        """
        设置单元格样式
        :param name: 字体名字
        :param height: 字体大小
        :param bold: 是否加粗
        :return: 返回样式
        """
        style = xlwt.XFStyle()

        font = xlwt.Font()
        font.name = name
        font.bold = bold
        font.color_index = 4
        font.height = height
        style.font = font
        return style


    def write_excel():
        """
        写表格
        :return:
        """
        f = xlwt.Workbook()  # 创建工作簿

        sheet1 = f.add_sheet('dataaaa',cell_overwrite_ok=True)
        row0 = ['姓名','卡号','部门']

        # 生成第一行
        for i in range(0,len(row0)):
            sheet1.write(0,i,row0[i],set_style('宋体',200,True)) # 200对应的是10号字体,如果设置太小,可能看上去像空Excel,实际上是有内容的

        f.save('test1.xls')


    if __name__ == '__main__':
        write_excel()
