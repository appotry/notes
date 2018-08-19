overlayfs
===================

https://www.jianshu.com/p/959e8e3da4b2

概念
------------

一种联合文件系统，设计简单，速度更快。overlayfs在linux主机上只有两层，一个目录在下层，用来保存镜像(docker)，另外一个目录在上层，用来存储容器信息。

在overlayfs中，底层的目录叫做lowerdir，顶层的目录称之为upperdir，对外提供统一的文件系统为merged。

当需要修改一个文件时，使用CoW将文件从只读的Lower复制到可写的Upper进行修改，结果也保存在Upper层。在Docker中，底下的只读层就是image，可写层就是Container。

优劣
---------

1. OverlayFS支持页缓存共享，多个容器访问同一个文件能共享一个页缓存，以此提高内存使用
2. OverlayFS消耗inode，随着镜像和容器增加，inode会遇到瓶颈。Overlay2能解决这个问题。在Overlay下，为了解决inode问题，可以考虑将/var/lib/docker挂在单独的文件系统上，或者增加系统inode设置。

