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
    _getMore().then((value) => _getMore());
  }

  Future<void> _refresh() async {
    nomore = false;
    var data;
    try {
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.get("/deal", null);
      await Future.delayed(Duration(milliseconds: 500));
    } catch (e) {
      print(e);
      return;
    }
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
    if (!nomore) {
      setState(() {
        load = true;
      });
      try {
        print(DateTime.now().millisecondsSinceEpoch);
        data = await http.get(
            "/deal", deals.length > 0 ? {"time": deals.last.created} : null);
        await Future.delayed(Duration(milliseconds: 500), () {});
      } catch (e) {
        print(e);
        return;
      }
      //print(data);
      var n = deals.length;
      if (data['code'] == ResultCode.SUCCESS) {
        for (var json in data['data']) {
          deals.add(Deal.fromJson(json));
        }
      }
      if (deals.length == n) {
        nomore = true;
      }
      if (current == true) {
        setState(() {
          load = false;
        });
      }
    }
    print(deals.length);
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
    return RefreshIndicator(
          child: StaggeredGridView.countBuilder(
            physics: AlwaysScrollableScrollPhysics(),
              itemCount: deals.length + 1,
              controller: _scrollController,
              crossAxisCount: 2,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              itemBuilder: (BuildContext context, int i) {
                if (i == deals.length) {
                  return load
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: SpinKitWave(
                              color: Colors.lightBlueAccent.withOpacity(0.5),
                              size: 30.0),
                        )
                      : Padding(padding: EdgeInsets.all(20));
                } else {
                  return Padding(
                      padding: const EdgeInsets.all(5),
                      child:
                          //GoodsCard(),
                          OpenContainer(
                        closedElevation: 0,
                        transitionType: ContainerTransitionType.fade,
                        closedBuilder:
                            (BuildContext _, VoidCallback openContainer) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DealCard(deals[i]),
                          );
                        },
                        openBuilder:
                            (BuildContext _, VoidCallback openContainer) {
                          return DealDetail(deals[i]);
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
          onRefresh: _refresh,
    );
  }
}
