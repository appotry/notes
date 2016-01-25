# awk

判断`1-100`,如果数字为3的倍数, 输出`Three`, 数字为5的倍数, 输出`Five`,同时为3,5的倍数, 输出`three and five`

```shell
seq 100|awk '{if($0 % 3 == 0) print $0,"Three" ; \
if($0 % 5 == 0 )print $0,"Five"; \
if($0 % 3 == 0 && $0 % 5 == 0) print $0,"three and five"; \
if($0 % 3 != 0 && $0 % 5 != 0) print $0,"0";}'
```