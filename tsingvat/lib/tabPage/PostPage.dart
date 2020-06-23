import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tsingvat/component/postcard.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/model/post.dart';
import 'package:tsingvat/util/httpUtil.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  HttpUtil http;
  List<Post> posts = [];
  List<int> imagenum = [];
  ScrollController _scrollController;
  bool load = false;
  bool current;
  bool nomore = false;

  @override
  void initState() {
    super.initState();
    current = true;
    http = HttpUtil();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _getMore();
        }
      });
    _getMore();
  }

  Future<void> _refresh() async {
    nomore = false;
    var data;
    try {
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.get("/post", null);
      await Future.delayed(Duration(milliseconds: 500));
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

  Future<void> _getMore() async {
    if (!nomore) {
      var data;
      setState(() {
        load = true;
      });
      try {
        print(DateTime.now().millisecondsSinceEpoch);
        data = await http.get("/post", posts.length > 0 ? {"time": posts.last.created} : null);
        await Future.delayed(Duration(milliseconds: 500), () {});
      } catch (e) {
        print(e);
        return;
      }
      var n = posts.length;
      if (data['code'] == ResultCode.SUCCESS) {
        for (var json in data['data']) {
          var p = Post.fromJson(json);
          int num = (await http.get("/images/num/${p.uuid}", null))['data'];
          print(num);
          posts.add(p);
          imagenum.add(num);
        }
      }
      if (posts.length == n) {
        nomore = true;
      }
      if (current == true) {
        setState(() {
          load = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    current = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
          child: StaggeredGridView.countBuilder(
              controller: _scrollController,
              itemCount: posts.length + 1,
              crossAxisCount: 1,
              itemBuilder: (BuildContext context, int i) {
                if (i == posts.length) {
                  return nomore
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "没有更多了",
                            textAlign: TextAlign.center,
                          ),
                        )
                      : (load
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: SpinKitWave(
                                  color:
                                      Colors.lightBlueAccent.withOpacity(0.5),
                                  size: 30.0),
                            )
                          : Padding(padding: EdgeInsets.all(20), child: FlatButton(onPressed: _getMore, child: Text("点击加载更多")),));
                } else {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: PostCard(posts[i], num: imagenum[i]));
                }
              },
              staggeredTileBuilder: (int i) => StaggeredTile.fit(1)),
          onRefresh: _refresh),
    );
  }
}
