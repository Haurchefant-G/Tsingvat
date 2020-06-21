import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsingvat/component/takederrandcard.dart';
import 'package:tsingvat/page/TakedErrandsPage.dart';
import 'package:tsingvat/util/GradientUtil.dart';
import 'package:tsingvat/loginPage.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';
import 'package:tsingvat/util/httpUtil.dart';
import 'package:tsingvat/chat/message_page.dart';

class InfoCard extends StatefulWidget {
  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  var userAvatar;
  var userName;
  var titles = ["资讯", "跑腿", "交易", "问答","聊天"];



  var titleTextStyle = new TextStyle(fontSize: 16.0);
  var rightArrowIcon = new Icon(Icons.arrow_forward_ios);

  info() async {
    var avatar = await SharedPreferenceUtil.getString('avatar');
    var name = await SharedPreferenceUtil.getString('username');
    setState(() {
      userAvatar =
          "http://121.199.66.17:8800/images/account/${name}/avatar.png"; //avatar;
      userName = name;
    });
    print(userAvatar);
    print(userName);
  }

  logout() {
    SharedPreferenceUtil.clear();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('startPage', (route) => false);
  }

  @override
  initState() {
    info();
  }

  @override
  Widget build(BuildContext context) {
    return new CustomScrollView(reverse: false, shrinkWrap: false, slivers: <
        Widget>[
      new SliverAppBar(
        pinned: false,
        backgroundColor: Colors.blueAccent,
        expandedHeight: 200.0,
        iconTheme: new IconThemeData(color: Colors.transparent),
        flexibleSpace: new InkWell(
            onTap: () {
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
                                          onPressed: () {},
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
                                                .headline5,
                                          ))))
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                userAvatar == null
                    ? new Image.asset(
                        "assets/avatar_logo.png",
                        width: 100,
                        height: 100,
                      )
                    : new Container(
                        width: 100,
                        height: 100,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: new DecorationImage(
                                image: new NetworkImage(userAvatar),
                                fit: BoxFit.cover),
                            border: new Border.all(
                                color: Colors.white, width: 2.0)),
                      ),
                new Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: new Text(
                    userName ?? " ",
                    style: new TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                )
              ],
            )),
      ),
      SliverFixedExtentList(
          delegate:
              new SliverChildBuilderDelegate((BuildContext context, int index) {
            String title = titles[index];
            return Container(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    print("the is the item of $title");

                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context){
                        return MessagePage();
                      })
                    );

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
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                                child: new Text(
                              title,
                              style: titleTextStyle,
                            )),
                            rightArrowIcon
                          ],
                        ),
                      ),
                      new Divider(
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
