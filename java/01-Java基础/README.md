# Java基础

## 介绍

## Java环境安装与配置

[Oracle官网](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

### MacOS安装JDK

1. [Oracle官网](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
2. 下载适用于macOS的JDK,(dmg)
3. 安装dmg
4. 安装完成会将系统默认的Java版本更新为对应的安装版本
5. 终端验证`java -version`

### Linux

#### 使用tar.gz包安装

1. [Oracle官网](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
2. 下载适用于Linux的二进制包
3. 解压到想要安装的位置
4. 配置环境变量
5. 终端验证`java -version`

#### Ubuntu使用apt-get安装

在Ubuntu默认的软件仓库中不包含Oracle官方提供的JDK, 我们可以添加第三方仓库来安装, 执行：

```shell
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
```

使用apt-get安装Oracle的JDK

```shell
# 安装需要安装的版本即可
sudo apt-get install oracle-java8-installer
```

安装完成会将系统默认的Java版本更新为对应的安装版本。

### Windows

1. 下载, 安装
2. 配置环境变量
3. `cmd`执行命令`java -version`, `javac -version`

## JDK, JRE, JVM

* JDK : Java Development ToolKit
* JRE:Java Runtime Environment
* JVM：Java Virtual Machine

JDK在包含JRE之外, 提供了开发Java应用的各种工具, 比如编译器和调试器。

JRE包括JVM和JAVA核心类库和支持文件, 是Java的运行平台, 所有的Java程序都要在JRE下才能运行。

JVM是JRE的一部分, Java虚拟机的主要工作是将Java字节码（通过Java程序编译得到）映射到本地的 CPU 的指令集或 OS 的系统调用。JVM回根据不同的操作系统使用不同的JVM映射规则, 从而使得Java平台与操作系统无关, 实现了跨平台的特性性。

在实际开发过程中, 我们首先编写Java代码, 然后通过JDK中的编译程序（javac）将Java文件编译成Java字节码, JRE加载和验证Java字节码, JVM解释字节码, 映射到CPU指令集或O的系统调用, 完成最终的程序功能。

## 开发工具

* [IntelliJ IDEA](http://www.jetbrains.com/idea/)
* Eclipse

## 笔记参考

[菜鸟教程-Java教程](http://www.runoob.com/java/java-tutorial.html)