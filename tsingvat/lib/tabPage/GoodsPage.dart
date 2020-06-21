import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tsingvat/component/dealcard.dart';
import 'package:animations/animations.dart';
import 'package:tsingvat/page/dealDetailPage.dart';

class GoodsPage extends StatefulWidget {
  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> {
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
              crossAxisCount: 2,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.all(2),
                child: 
                //GoodsCard(),
                OpenContainer(
                  closedElevation: 0,
                  transitionType: ContainerTransitionType.fade,
                      closedBuilder:
                          (BuildContext _, VoidCallback openContainer) {
                        return DealCard();
                      },
                      openBuilder: (BuildContext _, VoidCallback openContainer) {
                        return DealDetail();
                      },
                    ),
              ),
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1)),
          onRefresh: _refresh),
    );
  }
}
