import 'package:flutter/material.dart';
import 'package:tsingvat/signupPage.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  String userName;
  String password;
  bool isShowPassWord = false;

  void login() {
    //读取当前的Form状态
    var loginForm = loginKey.currentState;
    //验证Form表单
    if (loginForm.validate()) {
      loginForm.save();
      print('userName: ' + userName + ' password: ' + password);
    }
    //Navigator.pushNamed(context, "homepage");
    Navigator.pushReplacementNamed(context, "homepage");
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tsingvat',
      home: Scaffold(
        // 使用Column排列，包含两个Container
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 0, bottom: 30),
                // TODO child可以改成icon
                child: Hero(
                  tag: 'tsingvat',
                  child: Text(
                    'TsingVat',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline1
                        .copyWith(fontSize: 80),
                  ),
                )),
            Container(
              // 左右的边距
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: loginKey,
                autovalidate: true,
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.subtitle1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Theme.of(context).dialogBackgroundColor,
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: '用户名',
                            border: InputBorder.none,
                          ),
                          // TODO 除了检查邮箱外还应检查清华邮箱，或者只需填写用户名即可
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            userName = value;
                          },
                          validator: (username) {
                            if (username.length == 0) {
                              // TODO showToast
                              print('请输入用户名');
                            }
                          },
                          onFieldSubmitted: (value) {},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: Theme.of(context).dialogBackgroundColor,
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: '输入密码',
                                border: InputBorder.none,
                              ),
                              obscureText: !isShowPassWord,
                              onSaved: (value) {
                                password = value;
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isShowPassWord
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color.fromARGB(255, 126, 126, 126),
                            ),
                            onPressed: showPassWord,
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: Hero(
                          tag: 'circlebutton',
                          child: Material(
                            color: Colors.white.withAlpha(0),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                      color: Theme.of(context).primaryColorDark),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_forward),
                                    iconSize: 40,
                                    onPressed: login,
                                  )),
                            ),
                                
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          // spaceBetween分散至左右两边
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.push(context, PageRouteBuilder(
                                    pageBuilder: (BuildContext context,
                                        Animation animation,
                                        Animation secondaryAnimation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SignupPage(),
                                  );
                                }));
                              },
                              child: Text(
                                '注册账号',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Color.fromARGB(255, 53, 53, 53)),
                              ),
                            ),
                            Text(
                              '忘记密码？',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: Color.fromARGB(255, 53, 53, 53)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
