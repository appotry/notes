# 访问mysql

- [参考地址](https://spring.io/guides/gs/accessing-data-mysql/)
- [GitHub 项目地址](https://github.com/spring-guides/gs-accessing-data-mysql)

## 前提

- `JDK 1.8`或更高
- `Gradle 2.3+` or `Maven 3.0+`
- IDE

将项目下`initial`导入到IntelliJ IDEA

```shell
git clone https://github.com/spring-guides/gs-accessing-data-mysql.git
cd into gs-accessing-data-mysql/initial
```

## 创建数据库

```sql
mysql> create database db_example;
-- 创建用户
mysql> create user 'springuser'@'localhost' identified by '111111';
-- 授权, 后期根据需求授权
mysql> grant all on db_example.* to 'springuser'@'%';
```

## 创建application.properties文件

Spring Boot默认使用`H2`数据库, 所以我们需要更改为mysql, 并定义数据库相关设置.

创建文件

`src/main/resources/application.properties`

```java
spring.jpa.hibernate.ddl-auto=create
spring.datasource.url=jdbc:mysql://localhost:3306/db_example?verifyServerCertificate=false&useSSL=false&requireSSL=false
spring.datasource.username=springuser
spring.datasource.password=111111
```

> `spring.jpa.hibernate.ddl-auto`选项

`spring.jpa.hibernate.ddl-auto`可以设置为`none`, `update`, `create`, `create-drop`, 具体说明查阅`Hibernate`文档

`none` 使用 MySQL 数据库时, 默认值为 `none`, 不更改数据库结构.
`update` Hibernate会根据给予的实体结构更改数据库.
`create` 每次都创建数据库, 关闭的时候不会删除数据库.
`create-drop` 创建并且在 `SessionFactory` 关闭的时候删除数据库.

这里使用`create`, 因为我们还没有创建表结构, 运行一次之后, 需要根据程序把`spring.jpa.hibernate.ddl-auto`设置为`update`或`none`, 当你想修改表结构的时候, 使用`update`.

Spring为 `H2`或者其他嵌入的数据库使用的是 `create-drop`, 其他的为`none`, 比如 MySQL

生产中, 推荐把该参数设置为`none`, 并且回收用户权限, 给与`SELECT, UPDATE, INSERT, DELETE`权限即可.

## 创建 @Entity 模型

`src/main/java/hello/User.java`

```java
package hello;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    private String name;

    private String email;

        public Integer getId(){
            return id;
        }

        public void setId(Integer id){
            this.id = id;
        }
        public String getName(){
            return name;
        }
        public void setName(String name){
            this.name = name;
        }
        public String getEmail(){
            return email;
        }
        public void setEmail(String email){
            this.email = email;
        }

}
```

实例类,  `Hibernate`将自动转换成表结构.

## 创建repository

`src/main/java/hello/UserRepository.java`

```java
package hello;

import org.springframework.data.repository.CrudRepository;
import hello.User;

// CRUD refers Create, Read, Update, Delete

public interface UserRepository extends CrudRepository<User, Long> {

}
```

repository接口, this will be automatically implemented by Spring in a bean with the same name with changing case The bean name will be userRepository

## 创建controller

`src/main/java/hello/MainController.java`

```java
package hello;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import hello.User;
import hello.UserRepository;

@Controller // 表明该类为 Controller
@RequestMapping(path="/demo") // url为 /demo
public class MainController {
    @Autowired
    private UserRepository userRepository;

    @GetMapping(path="/add")
    public @ResponseBody String addNewUser(@RequestParam String name
            , @RequestParam String email){
        User n = new User();
        n.setName(name);
        n.setEmail(email);
        userRepository.save(n);
        return "Saved";

    }

    @GetMapping(path = "/all")
    public @ResponseBody Iterable<User> getAllUsers(){
        return userRepository.findAll();
    }
}
```

上述示例没有明确指定 `GET`,`PUT`,`POST`等等, 因为 `@GetMapping` 是一个快捷方式 `@RequestMapping(method=GET)`. `@RequestMapping`方法默认映射所有HTTP方法. 使用`@RequestMapping(method=GET)` 或其他方法缩小映射.

## 打包

Although it is possible to package this service as a traditional WAR file for deployment to an external application server, the simpler approach demonstrated below creates a standalone application. You package everything in a single, executable JAR file, driven by a good old Java main() method. Along the way, you use Spring’s support for embedding the Tomcat servlet container as the HTTP runtime, instead of deploying to an external instance.

`src/main/java/hello/Application.java`

```java
package hello;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {
    public static void main(String [] args){
        SpringApplication.run(Application.class, args);
    }
}
```

打成`JAR`包

你可以在命令行使用 `Gradle` 或 `Maven`. 或者你可以构建成一个包含所有依赖, 类, 资源文件的`JAR`包, 然后运行. 这会便于传输, 版本显示, 以及将服务部署成一个应用, 贯穿整个开发周期, 部署在不同的环境等等.

如果你在使用`Gradle`, 你可以通过运行`./gradlew bootRun` 来运行. 或者你可以使用 `./gradlew build` 构建`JAR`包 . 然后使用如下命令运行jar包:

    java -jar build/libs/gs-accessing-data-mysql-0.1.0.jar

如果你使用`Maven`, 你可以使用 `./mvnw spring-boot:run` 运行应用. 或者使用 `./mvnw clean package` 打包, 运行:

    java -jar target/gs-accessing-data-mysql-0.1.0.jar

> 上面的步骤可以创建一个可执行的`JAR`包. 你也可以构建传统的 `WAR` 包.

运行过程中国会打印日志, 服务会在几秒钟后启动.

## 测试应用

使用 `curl` 或者浏览器测试. 现在有2个 `REST Web Services`

[localhost:8080/demo/all](localhost:8080/demo/all) This gets all data [localhost:8080/demo/add](localhost:8080/demo/add) This adds one user to the data

    curl 'localhost:8080/demo/add?name=First&email=someemail@someemailprovider.com'

会得到如下回应

    Saved

`curl 'localhost:8080/demo/all'`

会得到如下回应

    [{"id":1,"name":"First","email":"someemail@someemailprovider.com"}]
