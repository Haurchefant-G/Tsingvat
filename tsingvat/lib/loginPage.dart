import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tsingvat/model/user.dart';
import 'package:tsingvat/signupPage.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';
import 'package:tsingvat/util/httpUtil.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/component/customDiaglog.dart';

import 'chat/chatglobal.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  User user;
  String userName;
  String password;
  bool isShowPassWord = false;
  bool validU = false;
  bool validP = false;
  bool valid = false;
  HttpUtil http;
  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    http = HttpUtil();
  }

  Future<void> login() async {
    var loginForm = loginKey.currentState;
    loginForm.save();
    print('userName: ' + userName + ' password: ' + password);
    var data;
    try {
      data = await http
          .post('/account/login', {"username": userName, "password": password});
    } catch (e) {
      print(e);
      showModal(
          context: context,
          configuration: FadeScaleTransitionConfiguration(),
          builder: (BuildContext context) {
            return CustomDialog(
              title: Text(
                "登陆失败",
                textAlign: TextAlign.center,
              ),
              content: Text(
                "连接错误",
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[],
            );
          });
      return;
    }
    print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      User user = User.fromJson(data['data']);
      print(user);
      SharedPreferenceUtil.setString('username', user.username);
      SharedPreferenceUtil.setString('email', user.email);
      SharedPreferenceUtil.setInt('phone', user.phone);
      SharedPreferenceUtil.setString('nickname', user.nickname);
      SharedPreferenceUtil.setString('signature', user.signature);
      SharedPreferenceUtil.setString(
          'avatar',
          "http://121.199.66.17:8800/images/account/${user.username}/avatar.png" +
              "?" +
              DateTime.now().microsecondsSinceEpoch.toString());
      SharedPreferenceUtil.setString('password', password);
      ChatGlobal.initWhenlogin();

      Navigator.pushReplacementNamed(context, "homePage");
    } else {
      showModal(
          context: context,
          configuration: FadeScaleTransitionConfiguration(),
          builder: (BuildContext context) {
            return CustomDialog(
              title: Text(
                "登陆失败",
                textAlign: TextAlign.center,
              ),
              content: Text(
                "用户名或密码错误",
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[],
            );
          });
      //}
    }
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
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 0, bottom: 30),
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
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: loginKey,
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
                          //autovalidate: true,
                          focusNode: usernameFocus,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: '用户名', border: InputBorder.none),
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            userName = value;
                          },
                          onChanged: (value) {
                            if (value.length == 0) {
                              setState(() {
                                validU = false;
                              });
                            } else {
                              setState(() {
                                validU = true;
                              });
                            }
                          },
                          onEditingComplete: () {
                            usernameFocus.unfocus();
                            passwordFocus.requestFocus();
                          },
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
                              focusNode: passwordFocus,
                              enableInteractiveSelection: false,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: '密码',
                                border: InputBorder.none,
                              ),
                              obscureText: !isShowPassWord,
                              onSaved: (value) {
                                password = value;
                              },
                              onChanged: (value) {
                                if (value.length == 0) {
                                  setState(() {
                                    validP = false;
                                  });
                                } else {
                                  setState(() {
                                    validP = true;
                                  });
                                }
                              },
                              onEditingComplete: () {
                                passwordFocus.unfocus();
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
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_forward),
                                    iconSize: 40,
                                    onPressed: validP && validU ? login : null,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                usernameFocus.unfocus();
                                passwordFocus.unfocus();
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
                            Container(),
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
