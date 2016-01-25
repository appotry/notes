# Python练习

## 生成激活码

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 26/04/2017 10:34 AM
# @Author  : yang

import uuid

def generate_code(count):
    code_list = []
    for i in range(count):
        code = str(uuid.uuid4()).replace('-','').upper()
        if code not in code_list:
            code_list.append(code)

    return code_list

if __name__ == '__main__':
    code_list = generate_code(200)
    for code in code_list:
        print(code)
```