import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsingvat/util/GradientUtil.dart';
import 'package:tsingvat/loginPage.dart';
import 'package:tsingvat/util/httpUtil.dart';

class InfoCard extends StatelessWidget {
  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  var userAvatar;
  var userName;
  var titles = ["资讯", "跑腿", "交易", "问答"];

  var titleTextStyle = new TextStyle(fontSize: 16.0);
  var rightArrowIcon = new Icon(Icons.arrow_forward_ios);

  @override
  Widget build(BuildContext context) {
    return new CustomScrollView(reverse: false, shrinkWrap: false, slivers: <
        Widget>[
      new SliverAppBar(
        pinned: false,
        backgroundColor: Colors.blue,
        expandedHeight: 200.0,
        iconTheme: new IconThemeData(color: Colors.transparent),
        flexibleSpace: new InkWell(
            onTap: () {
              userAvatar == null ? debugPrint('登录') : debugPrint('用户信息');
            },
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                userAvatar == null
                    ? new Image.asset(
                        "assets/avatar_logo.png",
                        width: 60.0,
                        height: 60.0,
                      )
                    : new Container(
                        width: 60.0,
                        height: 60.0,
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
                    userName == null ? '点击头像登录' : userName,
                    style: new TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                )
              ],
            )),
      ),
      new SliverFixedExtentList(
          delegate:
              new SliverChildBuilderDelegate((BuildContext context, int index) {
            String title = titles[index];
            return new Container(
                alignment: Alignment.centerLeft,
                child: new InkWell(
                  onTap: () {
                    print("the is the item of $title");
                  },
                  child: new Column(
                    children: <Widget>[
                      new Padding(
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

Widget showCustomScrollView() {
  return new CustomScrollView(
    slivers: <Widget>[
      const SliverAppBar(
        pinned: true,
        expandedHeight: 250.0,
        flexibleSpace: const FlexibleSpaceBar(
          title: const Text('Demo'),
        ),
      ),
      new SliverGrid(
        gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
          //横轴的最大长度
          maxCrossAxisExtent: 200.0,
          //主轴间隔
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          //横轴间隔
          childAspectRatio: 1.0,
        ),
        delegate: new SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return new Container(
              alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: new Text('grid item $index'),
            );
          },
          childCount: 20,
        ),
      ),
      new SliverFixedExtentList(
        itemExtent: 50.0,
        delegate:
            new SliverChildBuilderDelegate((BuildContext context, int index) {
          return new Container(
            alignment: Alignment.center,
            color: Colors.lightBlue[100 * (index % 9)],
            child: new Text('list item $index'),
          );
        }, childCount: 10),
      ),
    ],
  );
}
