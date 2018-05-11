python实用脚本
==============

连接oralce, 取出数据（数据和字段), 写入excel
--------------------------------------------

.. code:: python

    #!/usr/bin/python
    # -*- coding: UTF-8 -*-

    import cx_Oracle as db
    import os
    import xlwt
    import sys
    import datetime

    os.environ['NLS_LANG'] = 'SIMPLIFIED CHINESE_CHINA.UTF8'

    def queryOracle(sql):
        username = "USxxx"
        passwd = "xxx"
        host = "192.166.xx.xx"
        port = "1521"
        sid = "xx"
        dsn = db.makedsn(host, port, sid)
        con = db.connect(username, passwd, dsn)
        cur = con.cursor()
        cur.execute(sql)
        columnsname = [tuple[0] for tuple in cur.description]  #取出SQL的字段名称:做一个列表解析，之后返回
        results  = cur.fetchall()
        cur.close()
        con.close()
        return (columnsname,results)

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

    def write_excel(sql,name):
        """
        写表格
        :return:
        """
        now_time = datetime.datetime.now()
        yes_time = now_time + datetime.timedelta(days=-1)
        yes_time=(yes_time.strftime('%Y%m%d'))+"new"
        y_name=yes_time+name
        #print(name)
        f = xlwt.Workbook()  # 创建工作簿
        sheet1 = f.add_sheet(y_name,cell_overwrite_ok=True) ##第二参数用于确认同一个cell单元是否可以重设值。

        #results=queryOracle(sql)
        columnsname,results=queryOracle(sql)
        # 生成第一行(字段名)
        for i in range(len(columnsname)):
            sheet1.write(0,i,columnsname[i],set_style('宋体',200,True)) # 200对应的是10号字体,如果设置太小,可能看上去像空Excel,实际上是有内容的

        #写入数据
        #if len(results)>0:print(results)
        for count,row in  enumerate(results):
            for i in range(len(row)):
                sheet1.write(count+1,i,row[i],set_style('宋体',200,True))

        #f.save('test1.xls')
        if os.path.exists(yes_time) is not True:
            os.makedirs(yes_time)
        path=os.path.join(os.getcwd(),yes_time,name)
        #path=os.path.join('/usr/local/Scripts',yes_time,name)
        f.save('%s.xls'%path)
        #sys.exit()

    if __name__=="__main__":
        #sql = "select sysdate from dual"
        #sql = "SELECT * from IF_ADVICE"

        sql_1='''select gr.group_name as "groupName(路段)", count(1) as "orderNum(总数量)" from if_parking_order po  inner JOIN if_order o on o.order_id=PO.order_id inner JOIN if_berth b on o.berth_id=b.berth_id inner JOIN IF_BERTH_GROUP gr ON b.GROUP_ID = gr.GROUP_ID where 1=1 and o.status in ('waitPay','yetPay','refund') and O.OUT_TIME >= (SELECT TRUNC (SYSDATE - 1) + 0 / 24 FROM dual ) AND O.OUT_TIME < (SELECT TRUNC (SYSDATE) + 0 / 24 FROM dual ) AND TO_CHAR(OUT_TIME, 'hh24:mi:ss') BETWEEN '07:00:00' AND  '19:00:00'  GROUP BY gr.group_id,gr.group_name ORDER BY gr.group_name'''

    #    write_excel(sql_1,'总订单')

    #日间路段
    sql_dic = {
        sql_1:'日间路段-总订单',

    }

    for sql in sql_dic:
        write_excel(sql,sql_dic[sql])
