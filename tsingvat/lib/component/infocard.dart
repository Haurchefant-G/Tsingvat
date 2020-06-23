import 'dart:io';

import 'package:animations/animations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsingvat/chat/chatglobal.dart';
import 'package:tsingvat/component/takederrandcard.dart';
import 'package:tsingvat/page/MyDealsPage.dart';
import 'package:tsingvat/page/MyPostsPage.dart';
import 'package:tsingvat/page/MyWaitErrandsPage.dart';
import 'package:tsingvat/page/TakedErrandsPage.dart';
import 'package:tsingvat/util/GradientUtil.dart';
import 'package:tsingvat/loginPage.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';
import 'package:tsingvat/util/httpUtil.dart';
import 'package:tsingvat/chat/message_page.dart';

import 'customDiaglog.dart';

class InfoCard extends StatefulWidget {
  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  var userAvatar;
  var userName;
  var titles = ["需完成跑腿", "我的跑腿", "交易", "资讯", "聊天", "设置"];
  var icons = [
    Icons.event_note,
    Icons.list,
    Icons.attach_money,
    Icons.turned_in_not,
    Icons.chat_bubble_outline,
    Icons.settings
  ];

  var titleTextStyle = TextStyle(fontSize: 16.0);
  var rightArrowIcon = Icon(Icons.arrow_forward_ios);

  info() async {
    var avatar = await SharedPreferenceUtil.getString('avatar');
    var name = await SharedPreferenceUtil.getString('username');
    setState(() {
      userAvatar = avatar ??
          "http://121.199.66.17:8800/images/account/${name}/avatar.png"; //avatar;
      userName = name;
    });
    print(userAvatar);
    print(userName);
  }

  changeAvatar() async {
    try {
      Navigator.of(context).pop();
      var picker = ImagePicker();
      final image = await picker.getImage(source: ImageSource.gallery);
      var _image = File(image.path);
      if (_image != null) {
        print("changeAvatar");
        var data = await HttpUtil().post(
            "/images/avatar/${userName}",
            FormData.fromMap(
                {'image': MultipartFile.fromFileSync(_image.path)}));
        setState(() {
          userAvatar =
              "http://121.199.66.17:8800/images/account/${userName}/avatar.png?" +
                  DateTime.now().microsecondsSinceEpoch.toString();
        });
        SharedPreferenceUtil.setString('avatar', userAvatar);
        showModal(
            context: context,
            configuration: FadeScaleTransitionConfiguration(),
            builder: (BuildContext context) {
              return CustomDialog(
                title: Text(
                  "修改成功",
                  textAlign: TextAlign.center,
                ),
                // content:
                //     //Text("登陆失败",textAlign: TextAlign.center,),
                //     Text(
                //   "",
                //   textAlign: TextAlign.center,
                // ),
                actions: <Widget>[],
              );
            });
      }
    } catch (e) {}
  }

  logout() {
    SharedPreferenceUtil.clear();
    ChatGlobal.websocketProvide.closeWebSocket();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('startPage', (route) => false);
  }

  settingsheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            height: 60,
                            child: FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: changeAvatar,
                                child: Text(
                                  "修改头像",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline5,
                                ))))
                  ],
                ),
                Divider(height: 1),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            height: 60,
                            child: FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: logout,
                                child: Text(
                                  "退出登录",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline5
                                      .copyWith(color: Colors.red),
                                ))))
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  initState() {
    info();
  }

  @override
  Widget build(BuildContext context) {
    return new CustomScrollView(reverse: false, shrinkWrap: false, slivers: <
        Widget>[
      SliverAppBar(
        pinned: false,
        //backgroundColor: Colors.blueAccent,
        expandedHeight: 200.0,
        iconTheme: new IconThemeData(color: Colors.transparent),
        flexibleSpace: InkWell(
            onTap: settingsheet,
            child: Container(
              decoration: BoxDecoration(gradient: GradientUtil.cloudyApple()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  userAvatar == null
                      ? new Image.asset(
                          "assets/avatar_logo.png",
                          width: 100,
                          height: 100,
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              image: DecorationImage(
                                  image: NetworkImage(userAvatar),
                                  fit: BoxFit.cover),
                              border:
                                  Border.all(color: Colors.white, width: 2.0)),
                        ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: new Text(
                      userName ?? " ",
                      style: Theme.of(context).primaryTextTheme.headline6,
                    ),
                  )
                ],
              ),
            )),
      ),
      SliverFixedExtentList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            String title = titles[index];
            return Container(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    print("the is the item of $title");
                    if (index == 5) {
                      settingsheet();
                    } else {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        switch (index) {
                          case 0:
                            return TakedErrandsPage(userName);
                          case 1:
                            return MyWaitErrandsPage(userName);
                          case 2:
                            return MyDealsPage(userName);
                          case 3:
                            return MyPostsPage(userName);
                          case 4:
                            return MessagePage();
                          default:
                            return TakedErrandsPage(userName);
                        }
                      }));
                    }

//                    Navigator.of(context)
//                        .push(MaterialPageRoute(builder: (context) {
//                      return TakedErrandsPage(userName);
//                    }));
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                icons[index],
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            Expanded(
                                child: Text(
                              title,
                              style: titleTextStyle.copyWith(
                                  textBaseline: TextBaseline.ideographic),
                            )),
                            rightArrowIcon
                          ],
                        ),
                      ),
                      Divider(
                        height: 1.0,
                      )
                    ],
                  ),
                ));
          }, childCount: titles.length),
          itemExtent: 50.0),
    ]);
  }
}
