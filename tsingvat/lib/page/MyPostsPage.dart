import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tsingvat/chat/chat_detail_page.dart';
import 'package:tsingvat/component/customDiaglog.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/const/const_url.dart';
import 'package:tsingvat/model/deal.dart';
import 'package:tsingvat/model/errand.dart';
import 'package:tsingvat/model/post.dart';
import 'package:tsingvat/util/httpUtil.dart';

class MyPostsPage extends StatefulWidget {
  MyPostsPage(String username) {
    this.username = username;
  }
  String username;
  @override
  _MyPostsPageState createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPostsPage> {
  List<Post> posts = [];
  HttpUtil http;
  bool current;
  List<int> imagenum = [];

  Future<void> getMyPosts() async {
    var data;
    // await Future.delayed(Duration(seconds: 2), () {
    //   print("刷新结束");
    // });
    try {
      //print(DateTime.now().toIso8601String());
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.get("/post/${widget.username}", null);
      //await Future.delayed(Duration(milliseconds: 500), () {});
      //{"time": DateTime.now().millisecondsSinceEpoch});
    } catch (e) {
      print(e);
      return;
    }
    //print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      posts.clear();
      imagenum.clear();
      for (var json in data['data']) {
        var p = Post.fromJson(json);
        int num = (await http.get("/images/num/${p.uuid}", null))['data'];
        print(num);
        posts.add(p);
        imagenum.add(num);
      }
    }
    if (current == true) {
      setState(() {});
    }
  }

  delete(int i) async {
    var data;
    try {
      //print(DateTime.now().toIso8601String());
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.delete("/post/delete", {"uuid": posts[i].uuid});
      //await Future.delayed(Duration(milliseconds: 500), () {});
      //{"time": DateTime.now().millisecondsSinceEpoch});
    } catch (e) {
      print(e);
      return;
    }
    //print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      Navigator.of(context).pop();
      getMyPosts();
    }
  }

  @override
  void dispose() {
    super.dispose();
    current = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http = HttpUtil();
    current = true;
    getMyPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的资讯"),
      ),
      body: RefreshIndicator(
        onRefresh: getMyPosts,
        child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                padding: EdgeInsets.all(8),
                child: Card(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            //mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // CircleAvatar(
                              //   backgroundColor: Theme.of(context).primaryColorLight,
                              //   radius: 24,
                              // ),
                              ClipOval(
                                  child: Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                child: Image.network(
                                  "${ConstUrl.avatarimageurl}/${posts[i].username}/avatar.png",
                                  fit: BoxFit.cover,
                                ),
                              )),
                              Padding(padding: const EdgeInsets.all(8.0)),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      posts[i].username,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle1,
                                    ),
                                    Padding(padding: const EdgeInsets.all(1.0)),
                                    Text(
                                      DateTime.fromMillisecondsSinceEpoch(
                                              posts[i].created)
                                          .toString(),
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle2
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showModal(
                                    context: context,
                                    configuration:
                                        FadeScaleTransitionConfiguration(),
                                    builder: (BuildContext context) {
                                      return CustomDialog(
                                        title: Text(
                                          "确认删除",
                                          textAlign: TextAlign.center,
                                        ),
                                        content:
                                            //Text("登陆失败",textAlign: TextAlign.center,),
                                            Text(
                                          "请确认是否删除该资讯",
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("取消")),
                                          FlatButton(
                                              onPressed: () {
                                                delete(i);
                                              },
                                              child: Text("确认"))
                                        ],
                                      );
                                    });
                                  })
                            ],
                          ),
                        ),
                        Container(
                          child: imagenum[i] > 0
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 12),
                                  child: CachedNetworkImage(
                                    imageUrl: ConstUrl.postimageurl + '/${posts[i].uuid}/0.png',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SpinKitThreeBounce(
                                        color: Colors.blueAccent,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                  //     Image.asset(
                                  //   'assets/placeholder_image.png',
                                  //   color: Colors.grey,
                                  //   colorBlendMode: BlendMode.color,
                                  //   fit: BoxFit.fitWidth,
                                  // )
                                )
                              : null,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                          child: Text(
                            posts[i].content,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .copyWith(height: 1.8),
                            textScaleFactor: 1,
                          ),
                        )
                      ]),
                ),
              );
            }),
      ),
    );
  }
}
