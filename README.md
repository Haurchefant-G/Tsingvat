后端网络请求接口:

```json
base_uri:localhost:8089
port可以通过src/resources/application.properties中修改

method:POST
uri: /login
content-type:application/json
body{
    "id": String,
    "password":String
}

method:POST
uri: /register
content-type:application/json
body{
    "email": String,
    "password":String
}
```

