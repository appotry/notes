tips
===========

golang开发环境mac下编译linux环境文件
--------------------------------------------

::

    CGO_ENABLED=0 GOOS=linux GOARCH=amd64
    go build ...
