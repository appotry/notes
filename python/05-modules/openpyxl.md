# openpyxl

[https://openpyxl.readthedocs.io/en/default/](https://openpyxl.readthedocs.io/en/default/)

```python
    wb = openpyxl.load_workbook(filename=file_path)

    # 所有工作簿名字
    # wsl = wb.sheetnames

    # 通过名字获取工作簿
    # ws1 = wb.get_sheet_by_name('试用期')

    # 工作簿最大多少行, 最大多少列 max_column, max_row
    # openpyxl 索引从 1 开始,  所以所有行索引为, (1, max_row+1)
    # print(ws1.max_column)

    # 打印某个单元格的值
    # print(ws1.cell(row=1, column=1).value)
```

## 读取cell中的颜色

```python
ws1 = wb.get_sheet_by_name('试用期')
c = ws1.cell(row=1,column=1)
fill = c.fill
front = c.font
print(c.value)
print(fill.start_color.rgb)
print(front.color.rgb)
服务器名称
FF00B050
FFFFFF00
```

## 示例

```python
    def merge_sheet(wb):
        """
        合并所有工作簿为一个 RecordCollection 对象
        :param wb:
        :return:
        """
        records_list = []
        for sheet_name in wb.sheetnames:
            row_gen = single_sheet(wb=wb, sheet_name=sheet_name)
            tmp_res = RecordCollection(row_gen)
            tmp_res.all()
            records_list.append(tmp_res)
        # 合并工作簿为一个 RecordCollection 对象, 需要定义 __add__ 方法
        results = reduce(lambda x, y: x + y, records_list)

        return results

    def single_sheet(wb, sheet_name):
        """
        返回单张工作簿的所有数据
        :param wb: workbook
        :param sheet_name: 工作簿名字
        :return: 返回单张工作簿的所有数据
        """
        headers = {
            '姓名': 'ConsumerName',
            '卡号': 'CardNO',
            '部门': 'GroupName',
            '权限': 'DoorName'
        }
        sheet = wb.get_sheet_by_name(sheet_name)
        # 从 1 开始, 如果不要表头, 从 2 行开始
        sheet_header = []
        for column in range(1, sheet.max_column + 1):
            header = sheet.cell(row=1, column=column).value
            if header in headers:
                sheet_header.append(headers[header])
            else:
                raise ValueError('工作簿 <%s> 表头错误' % sheet)
        # print(sheet_header)

        user_gen = ([sheet.cell(row=row, column=column).value for column in range(1, sheet.max_column + 1)]
             for row in range(2, sheet.max_row + 1))

        return (Record(sheet_header, list(row)) for row in user_gen)
        # return sheet_header,l
```