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
  bool more = false;
  bool current;

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
    var data;
    try {
      //print(DateTime.now().toIso8601String());
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.get("/post", null);
      await Future.delayed(Duration(milliseconds: 500));
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

  Future<void> _getMore() async {
    var data;
    setState(() {
      more = true;
    });
    try {
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.get("/post", null);
      Future.sync(await Future.delayed(Duration(milliseconds: 500), () {}));
    } catch (e) {
      print(e);
      return;
    }
    if (data['code'] == ResultCode.SUCCESS) {
      for (var json in data['data']) {
        var p = Post.fromJson(json);
        int num = (await http.get("/images/num/${p.uuid}", null))['data'];
        print(num);
        posts.add(p);
        imagenum.add(num);
      }
    }
    if (current == true) {
      setState(() {
        more = false;
      });
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
                  return more
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: SpinKitWave(
                              color: Colors.lightBlueAccent.withOpacity(0.5),
                              size: 30.0),
                        )
                      : Padding(padding: EdgeInsets.all(20));
                } else {
                  return Padding(
                      padding: const EdgeInsets.all(2),
                      child: PostCard(posts[i], num: imagenum[i]));
                }
              },
              staggeredTileBuilder: (int i) => StaggeredTile.fit(1)),
          onRefresh: _refresh),
    );
  }
}
