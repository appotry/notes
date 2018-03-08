# III Building the LFS System

## 安装基本系统软件

### Linux-4.12.7 API Headers

The Linux API Headers (in linux-4.12.7.tar.xz) expose the kernel's API for use by Glibc.

进入到 `sources`目录 解压 `linux-4.12.7.tar.xz`, 进入到解压后的目录

#### Installation of Linux API Headers

The Linux kernel needs to expose an Application Programming Interface (API) for the system's C library (Glibc in LFS) to use. This is done by way of sanitizing various C header files that are shipped in the Linux kernel source tarball.

Make sure there are no stale files and dependencies lying around from previous activity:

    make mrproper

Now extract the user-visible kernel headers from the source. They are placed in an intermediate local directory and copied to the needed location because the extraction process removes any existing files in the target directory. There are also some hidden files used by the kernel developers and not needed by LFS that are removed from the intermediate directory.

```shell
make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv dest/include/* /usr/include
```

#### Contents of Linux API Headers

Installed headers:

```shell
/usr/include/asm/*.h, /usr/include/asm-generic/*.h, /usr/include/drm/*.h, /usr/include/linux/*.h, /usr/include/misc/*.h, /usr/include/mtd/*.h, /usr/include/rdma/*.h, /usr/include/scsi/*.h, /usr/include/sound/*.h, /usr/include/video/*.h, and /usr/include/xen/*.h
```

Installed directories:

```shell
/usr/include/asm, /usr/include/asm-generic, /usr/include/drm, /usr/include/linux, /usr/include/misc, /usr/include/mtd, /usr/include/rdma, /usr/include/scsi, /usr/include/sound, /usr/include/video, and /usr/include/xen
```

Short Descriptions

```shell
/usr/include/asm/*.h The Linux API ASM Headers
/usr/include/asm-generic/*.h The Linux API ASM Generic Headers
/usr/include/drm/*.h The Linux API DRM Headers
/usr/include/linux/*.h The Linux API Linux Headers
/usr/include/mtd/*.h The Linux API MTD Headers
/usr/include/rdma/*.h The Linux API RDMA Headers
/usr/include/scsi/*.h The Linux API SCSI Headers
/usr/include/sound/*.h The Linux API Sound Headers
/usr/include/video/*.h The Linux API Video Headers
/usr/include/xen/*.h The Linux API Xen Headers
```

### Man-pages-4.12

The Man-pages package contains over 2,200 man pages.

Approximate build time:
less than 0.1 SBU
Required disk space:
27 MB

#### Installation of Man-pages

Install Man-pages by running:

    make install

#### Contents of Man-pages

Installed files: various man pages

Short Descriptions

man pages Describe C programming language functions, important device files, and significant configuration files
