### 后端和数据库文档

#### 数据库

+ 使用远程阿里云服务器Centos上配置的MySql数据库服务。

+ 目前已建立起了较为基础的table，如account，post等。
+ 数据库直接通过Springboot的Mybatis来访问，使得数据库模块只需负责数据库及其表的创建。

接下来数据库对应各表的创建需要经过更加细致的讨论才能确定。

#### 后端

+ 使用Springboot框架，目前实现了基础的account表的相关操作，以及对应的请求获取与返回

以登录操作举例如下：

```java
//AccountController.java中的http请求获取与返回
@RequestMapping(value = "/login", method = { RequestMethod.POST })
public String login(@RequestBody Account account) {
    int login = 0;
    if(account.getUsername() != null && account.getPassword() != null) {
        login = accountMapper.login(account.getUsername(), account.getPassword());
    }
    if(login == 0){
        return wrapperMsg(HttpsCode.LOGIN_FAILED, "Error:id or password is wrong");
    } else if(login == 1){
        return wrapperMsg(HttpsCode.LOGIN_SUCCEED, "Successfully login");
    }
}
// 使用json的方式传递参数，在springboot中会根据json中的变量名自动解析成我们设定的类Account，非常方便。
```

```java
// AccountDao.java中的登录接口
int login(String id, String pwd);
```

```java
//AccountMapper.xml中对应的mybatis接口
<select id="login" resultType="java.lang.Integer">
    select count(*) from Account where username=#{username} and password=#{pwd}
</select>
```

#### 遇到的问题

1. vscode remote ssh在电脑上多次调试均没有用，每次都需开启命令行进行远程服务器的连接，对于服务器的部署以及数据库的编写都极为的不变

2. 对于清华帮帮忙整体的事物逻辑不清晰，数据库的设计存在一定问题，如数据库account表如何储存数组。

3. 后端本质上与第二点提到的逻辑不清晰对应，后续应当将数据库和后端更加地解耦合。