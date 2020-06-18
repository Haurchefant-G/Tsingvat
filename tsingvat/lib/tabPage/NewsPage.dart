import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tsingvat/component/newscard.dart';


class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      print("刷新结束");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
          child: StaggeredGridView.countBuilder(
              itemCount: 10,
              crossAxisCount: 1,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.all(2),
                child: NewsCard()
              ),
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1)),
          onRefresh: _refresh),
    );
  }
}