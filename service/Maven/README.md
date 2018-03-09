# Manve

[https://maven.apache.org/index.html](https://maven.apache.org/index.html)

Apache Maven是一个软件项目管理综合工具, 基于项目对象模型(POM)的概念, Maven管理项目的构建，报告和文档

## 安装

先决条件: 已安装JDK, 并配置好环境变量

直接使用二进制包安装

1. 解压到想要安装的路径
2. 配置环境变量

验证:

新开shell窗口执行, `mvn -v`

```shell
Apache Maven 3.5.2 (138edd61fd100ec658bfa2d307c43b76940a5d7d; 2017-10-18T15:58:13+08:00)
Maven home: /usr/local/Cellar/maven/3.5.2/libexec
Java version: 1.8.0_91, vendor: Oracle Corporation
Java home: /Library/Java/JavaVirtualMachines/jdk1.8.0_91.jdk/Contents/Home/jre
Default locale: en_US, platform encoding: UTF-8
OS name: "mac os x", version: "10.12.6", arch: "x86_64", family: "mac"
```

> MacOS 也可以直接使用`brew install maven`安装

## 运行

语法

    mvn [options] [<goal(s)>] [<phase(s)>]

可用选项, 及帮助

    mvn -h

使用maven生命周周期构建Maven项目(在`pom.xml`文件所在的项目目录)

    mvn package

内置生命周期顺序如下:

- clean - pre-clean, clean, post-clean
- default - validate, initialize, generate-sources, process-sources, generate-resources, process-resources, compile, process-classes, generate-test-sources, process-test-sources, generate-test-resources, process-test-resources, test-compile, process-test-classes, test, prepare-package, package, pre-integration-test, integration-test, post-integration-test, verify, install, deploy
- site - pre-site, site, post-site, site-deploy

重新构建项目, 生成所有打包输出, 文档站点并部署到仓库

    mvn clean deploy site-deploy

仅仅创建包及安装在本地仓库便于其他项目重用可以使用如下命令:

    mvn clean install

综上是常见的Maven构建命令

When not working with a project, and in some other use cases, you might want to invoke a specific task implemented by a part of Maven - this is called a goal of a plugin. E.g.:

    mvn archetype:generate

or

    mvn checkstyle:check

There are many different plugins avaiable and they all implement different goals.

Further resources:

[Building a Project with Maven](https://maven.apache.org/run-maven/index.html)

## pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <!--
    groupId: 组织的唯一标识
    artifactId: 项目的唯一标识
    version: 项目版本
    -->
    <groupId>com.example</groupId>
    <artifactId>demo</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>jar</packaging>

    <name>demo</name>
    <description>Demo project for Spring Boot</description>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>1.5.9.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>

    <!-- 在该标签中 定义变量 -->
    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <java.version>1.8</java.version>
        <spring-cloud.version>Edgware.RELEASE</spring-cloud.version>
    </properties>

    <!-- 项目依赖 -->
    <dependencies>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-eureka</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-eureka-server</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-thymeleaf</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>${spring-cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <!-- 编译插件 -->
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>


</project>
```

## 安装第三方jar包

```shell
mvn install:install-file -Dfile=<path-to-file> -DgroupId=<group-id> \
    -DartifactId=<artifact-id> -Dversion=<version> -Dpackaging=<packaging>
```

如果有pom文件, 可以使用如下命令

```shell
mvn install:install-file -Dfile=<path-to-file> -DpomFile=<path-to-pomfile>
```
