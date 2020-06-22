import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tsingvat/model/user.dart';
import 'package:tsingvat/signupPage.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';
import 'package:tsingvat/util/httpUtil.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/component/customDiaglog.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  User user;
  String userName;
  String password;
  bool isShowPassWord = false;
  bool validU = false;
  bool validP = false;
  bool valid = false;
  HttpUtil http;

  @override
  void initState() {
    super.initState();
    http = HttpUtil();
  }

  Future<void> login() async {
    //读取当前的Form状态

    var loginForm = loginKey.currentState;
    //验证Form表单
    //if (loginForm.validate()) {
    loginForm.save();
    print('userName: ' + userName + ' password: ' + password);
    var data;
    try {
      Map<String, dynamic> a = {"username": userName, "password": password};
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
              content:
                  //Text("登陆失败",textAlign: TextAlign.center,),
                  Text(
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
      SharedPreferenceUtil.setString('password', password);
      SharedPreferenceUtil.setString('email', user.email);
      SharedPreferenceUtil.setInt('phone', user.phone);
      SharedPreferenceUtil.setString('nickname', user.nickname);
      SharedPreferenceUtil.setString('signature', user.signature);
      SharedPreferenceUtil.setString('avatar', user.avatar??"http://121.199.66.17:8800/images/account/${user.username}/avatar.png" + "?" +
                  DateTime.now().microsecondsSinceEpoch.toString());
      
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
              content:
                  //Text("登陆失败",textAlign: TextAlign.center,),
                  Text(
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
        // 使用Column排列，包含两个Container
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
              // 左右的边距
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: loginKey,
                //autovalidate: true,
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
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: '用户名',
                              // filled: true,
                              // fillColor: Theme.of(context).dialogBackgroundColor,
                              border: InputBorder.none
                              // OutlineInputBorder(
                              //   gapPadding: 100,
                              //   borderRadius: BorderRadius.all(Radius.circular(100)),
                              //   borderSide: BorderSide.none,
                              //   //color: Theme.of(context).dialogBackgroundColor,
                              // ),
                              //InputBorder.none,
                              ),
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            userName = value;
                          },
                          onChanged: (value) {
                            if (value.length == 0) {
                              print('请输入用户名');
                              setState(() {
                                validU = false;
                              });
                            } else {
                              setState(() {
                                validU = true;
                              });
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
                              //autovalidate: true,
                              //toolbarOptions: ToolbarOptions(),
                              enableInteractiveSelection: false,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: '输入密码',
                                border: InputBorder.none,
                                //errorMaxLines: 0
                              ),
                              obscureText: !isShowPassWord,
                              onSaved: (value) {
                                password = value;
                              },

                              onChanged: (value) {
                                if (value.length == 0) {
                                  print('请输入密码');
                                  setState(() {
                                    validP = false;
                                  });
                                } else {
                                  setState(() {
                                    validP = true;
                                  });
                                }
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
