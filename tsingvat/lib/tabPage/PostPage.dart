import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    http = HttpUtil();
    _refresh();
  }

  Future<void> _refresh() async {
    var data;
    // await Future.delayed(Duration(seconds: 2), () {
    //   print("刷新结束");
    // });

    try {
      //print(DateTime.now().toIso8601String());
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.get("/post", null);
      //{"time": DateTime.now().millisecondsSinceEpoch});
    } catch (e) {
      print(e);
      return;
    }
    //print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      var datas = data['data'];
      for (var json in data['data']) {
        setState(() {
          posts.add(Post.fromJson(json));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
          child: StaggeredGridView.countBuilder(
              itemCount: posts.length,
              crossAxisCount: 1,
              itemBuilder: (BuildContext context, int index) =>
                  Padding(padding: const EdgeInsets.all(2), child: PostCard(posts[index])),
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1)),
          onRefresh: _refresh),
    );
  }
}
