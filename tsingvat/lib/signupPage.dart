import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter/services.dart';
import 'package:tsingvat/loginPage.dart';
import 'package:tsingvat/util/httpUtil.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/component/customDiaglog.dart';

class SignupPage extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<SignupPage> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  String userName;
  String email;
  String password;
  String repeatPassword;
  bool isShowPassWord = false;
  HttpUtil http;
  RegExp emailexp = RegExp(r'^.+@mails.tsinghua.edu.cn$');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http = HttpUtil();
  }

  void signup() async {
    //读取当前的Form状态
    String error = null;
    var signupForm = signupKey.currentState;
    //验证Form表单
    // if (signupForm.validate()) {
    //   signupForm.save();
    //   print('userName: ' + userName + ' password: ' + password);
    //   return;
    // }
    signupForm.save();
    if (userName.length < 4 || userName.length > 16) {
      error = "请输入规范的用户名";
    } else if (!emailexp.hasMatch(email)) {
      error = "请使用后缀为@mails.tsinghua.edu.cn的邮箱注册";
    } else if (password.length < 6 || password.length > 16) {
      error = "密码不符合要求";
    } else if (password != repeatPassword) {
      error = "两次输入密码不一致";
    }

    if (error != null) {
      showModal(
          context: context,
          configuration: FadeScaleTransitionConfiguration(),
          builder: (BuildContext context) {
            return CustomDialog(
              title: Text(
                error,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          });
      return;
    }

    var data;
    try {
      data = await http.post('/account/register',
          {"username": userName, "password": password, "email": email});
    } catch (e) {
      print(e);
      showModal(
          context: context,
          configuration: FadeScaleTransitionConfiguration(),
          builder: (BuildContext context) {
            return CustomDialog(
              title: Text(
                "注册失败",
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
      showModal(
          context: context,
          configuration: FadeScaleTransitionConfiguration(),
          builder: (BuildContext context) {
            return CustomDialog(
              title: Text(
                "注册成功",
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text("返回登录界面")),
              ],
            );
          });
    } else if (data['code'] == ResultCode.ACCOUNT_ALREADY_EXISTS) {
      showModal(
          context: context,
          configuration: FadeScaleTransitionConfiguration(),
          builder: (BuildContext context) {
            return CustomDialog(
              title: Text(
                "注册失败",
                textAlign: TextAlign.center,
              ),
              content: Text(
                "该用户名已被注册",
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[],
            );
          });
    } else {
      showModal(
          context: context,
          configuration: FadeScaleTransitionConfiguration(),
          builder: (BuildContext context) {
            return CustomDialog(
              title: Text(
                "注册失败",
                textAlign: TextAlign.center,
              ),
              content: Text(
                "未能完成注册",
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[],
            );
          });
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
              ),
            ),
            Container(
              // 左右的边距
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: signupKey,
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
                            hintText: '用户名(4-16位字母或数字)',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            userName = value;
                          },
                          inputFormatters: [
                            WhitelistingTextInputFormatter(
                                RegExp("[a-zA-Z0-9]"))
                          ],
                          onFieldSubmitted: (value) {},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Theme.of(context).dialogBackgroundColor,
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: '清华邮箱',
                            border: InputBorder.none,
                            //suffixText: "@mails.tinghua.edu.cn",
                            //suffixStyle: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.black54)
                          ),
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            email = value;
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
                                hintText: '输入密码(6-16位字母或数字)',
                                border: InputBorder.none,
                              ),
                              inputFormatters: [
                                WhitelistingTextInputFormatter(
                                    RegExp("[a-zA-Z0-9]"))
                              ],
                              obscureText: !isShowPassWord,
                              onSaved: (v) {
                                password = v;
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
                                hintText: '再次输入密码',
                                border: InputBorder.none,
                              ),
                              obscureText: !isShowPassWord,
                              onSaved: (v) {
                                repeatPassword = v;
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
                                  padding: const EdgeInsets.all(20.0),
                                  child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                      child: IconButton(
                                        icon: Icon(Icons.done),
                                        iconSize: 40,
                                        onPressed: signup,
                                      )),
                                ))),
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
                                Navigator.pop(context);
                              },
                              child: Text(
                                '返回登陆',
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

class signup extends StatelessWidget {
  const signup({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: IconButton(
        icon: Icon(Icons.arrow_forward),
        iconSize: 40,
        onPressed: () {},
      ),
    );
  }
}
