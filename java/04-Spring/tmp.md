# tmp

## 定制Banner

### 修改默认Banner

Spring Boot启动的时候有一个默认的启团

```java
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v1.5.9.RELEASE)
```

`src/main/resources` 下新建 `banner.txt`

通过如下网站生成字符

[http://patorjk.com/software/taag](http://patorjk.com/software/taag)

复制写入 `banner.txt` 文件, 启动之后, 图案就会变成设定的图案.

### 关闭Banner

