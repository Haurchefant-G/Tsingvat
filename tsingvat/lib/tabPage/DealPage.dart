import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tsingvat/component/dealcard.dart';
import 'package:animations/animations.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/model/deal.dart';
import 'package:tsingvat/page/dealDetailPage.dart';
import 'package:tsingvat/util/httpUtil.dart';

class DealPage extends StatefulWidget {
  @override
  _DealPageState createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> {
  HttpUtil http;
  List<Deal> deals = [];
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
    // await Future.delayed(Duration(seconds: 2), () {
    //   print("刷新结束");
    // });
    try {
      //print(DateTime.now().toIso8601String());
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.get("/deal", null);
      await Future.delayed(Duration(milliseconds: 500));
      //{"time": DateTime.now().millisecondsSinceEpoch});
    } catch (e) {
      print(e);
      return;
    }
    //print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      deals.clear();
      for (var json in data['data']) {
        deals.add(Deal.fromJson(json));
      }
    }
    if (current == true) {
      setState(() {});
    }
  }

  Future<void> _getMore() async {
    print(1);
    var data;

    setState(() {
      more = true;
    });
    try {
      //print(DateTime.now().toIso8601String());
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.get("/deal", null);
      Future.sync(await Future.delayed(Duration(milliseconds: 500), () {}));
      //{"time": DateTime.now().millisecondsSinceEpoch});
    } catch (e) {
      print(e);
      return;
    }
    //print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      for (var json in data['data']) {
        deals.add(Deal.fromJson(json));
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
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    current = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
          child: StaggeredGridView.countBuilder(
              itemCount: deals.length + 1,
              controller: _scrollController,
              crossAxisCount: 2,
              itemBuilder: (BuildContext context, int i) {
                if (i == deals.length) {
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
                      child:
                          //GoodsCard(),
                          OpenContainer(
                        closedElevation: 0,
                        transitionType: ContainerTransitionType.fade,
                        closedBuilder:
                            (BuildContext _, VoidCallback openContainer) {
                          return DealCard(deals[i]);
                        },
                        openBuilder:
                            (BuildContext _, VoidCallback openContainer) {
                          return DealDetail();
                        },
                      ));
                }
              },
              staggeredTileBuilder: (int index) {
                if (index == deals.length) {
                  return StaggeredTile.fit(2);
                } else {
                  return StaggeredTile.fit(1);
                }
              }),
          onRefresh: _refresh),
    );
  }
}
