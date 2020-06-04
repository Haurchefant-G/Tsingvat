## 后端网络请求接口:

```json
base_uri:localhost:8089
##port可以通过src/resources/application.properties中修改
```

```java
// src/main/../backend/controllers/Httpscode.java
// 以下所有的code，都为如下定义：
public static int LOGIN_SUCCEED = 201;
public static int LOGIN_FAILED = 202;
public static int REGISTER_SUCCEED = 203;
public static int REGISTER_FAILED = 204;
...
```

#### 登录

username和email的关系是`email=username@(mail(s)?.)?tsinghua.edu.cn`，比如email是zhang-xj17@mails.tsinghua.edu.cn，那么username是`zhang-xj17`

```json
method:POST
uri: /login
content-type:application/json
body{
    "username":String,
    "password":String
}
or
{
  	"email":String,
    "password":String
}
```
```json
response{
	code:int,
    "msg":String
}
```

#### 注册

```json
method:POST
uri: /register
content-type:application/json
body{
    "email": String,
    "password":String
}
```
```json
response{
    "code":int,
    "msg":String
}
```

