# 快速开始

[TeamCity Documentation](https://confluence.jetbrains.com/display/TCD10/TeamCity+Documentation)

[https://confluence.jetbrains.com/display/TCD10/Configure+and+Run+Your+First+Build](https://confluence.jetbrains.com/display/TCD10/Configure+and+Run+Your+First+Build)

## TeamCity Web

访问 `8111` 端口(TeamCity默认端口),如果访问不了,可能因为防火墙阻隔

修改端口,配置文件: `/usr/local/TeamCity/conf/server.xml`

    <Connector port="8111" ...

![teamcity-01-setup](http://oi480zo5x.bkt.clouddn.com/teamcity-01-setup.png)

TeamCity将构建历史,用户信息,构建结果等存放在数据库中,初次使用,我们选择默认配置就行`Internal(HSQLDB)`.

创建的过程会需要一些时间

接下来: `接受协议` -> `创建管理账号` -> `进入个人界面,OK`

个人界面,具体信息可填可不填

## 创建项目

创建项目的时候,可以根据需求,选择手动配置,还是指向仓库地址等等

`Administration` -> `Projects` -> `Create project` -> `Manually`

![teamcity-06-project-01](http://oi480zo5x.bkt.clouddn.com/teamcity-06-project-01.png)

一个项目包含如下内容

![teamcity-07-project-02](http://oi480zo5x.bkt.clouddn.com/teamcity-07-project-02.png)

* 通用设置
    * `构建配置`,构建配置定义项目如何获取和构建源代码。一个项目可以有多个`构建配置`,`构建配置`下又有多项配置
        * 通用设置,包含该构建配置的名称,ID,描述,文件路径等等
        * 版本控制设置
        * 构建步骤
        * 触发器
        * 参数
        * 等等
* VCS
* Parameters
* 等等

# 帮助中心

[帮助中心](https://teamcity-support.jetbrains.com/hc/en-us/search?utf8=%E2%9C%93&query=&gsearch=true)