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
    if (!nomore) {
      setState(() {
        load = true;
      });
      try {
        //print(DateTime.now().toIso8601String());
        print(DateTime.now().millisecondsSinceEpoch);
        data = await http.get(
            "/deal", deals.length > 0 ? {"time": deals.last.created} : null);
        await Future.delayed(Duration(milliseconds: 500), () {});
        //{"time": DateTime.now().millisecondsSinceEpoch});
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
          itemCount: deals.length + 2,
          controller: _scrollController,
          crossAxisCount: 2,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          itemBuilder: (BuildContext context, int i) {
            if (i == 0) {
              return Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow()],
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Theme.of(context).dialogBackgroundColor,
                ),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              );
            } else if (i == deals.length + 1) {
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
                              color: Colors.lightBlueAccent.withOpacity(0.5),
                              size: 30.0),
                        )
                      : Padding(
                          padding: EdgeInsets.all(20),
                          child: FlatButton(
                              onPressed: _getMore, child: Text("点击加载更多")),
                        ));
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
                        child: DealCard(deals[i - 1]),
                      );
                    },
                    openBuilder: (BuildContext _, VoidCallback openContainer) {
                      return DealDetail(deals[i - 1]);
                    },
                  ));
            }
          },
          staggeredTileBuilder: (int index) {
            if (index == deals.length + 1 || index == 0) {
              return StaggeredTile.fit(2);
            } else {
              return StaggeredTile.fit(1);
            }
          }),
      onRefresh: _refresh,
    );
    // return RefreshIndicator(
    //       child: StaggeredGridView.countBuilder(
    //         physics: AlwaysScrollableScrollPhysics(),
    //           itemCount: deals.length + 1,
    //           controller: _scrollController,
    //           crossAxisCount: 2,
    //           addAutomaticKeepAlives: false,
    //           addRepaintBoundaries: false,
    //           itemBuilder: (BuildContext context, int i) {
    //             if (i == deals.length) {
    //               return load
    //                   ? Padding(
    //                       padding: const EdgeInsets.only(bottom: 20),
    //                       child: SpinKitWave(
    //                           color: Colors.lightBlueAccent.withOpacity(0.5),
    //                           size: 30.0),
    //                     )
    //                   : Padding(padding: EdgeInsets.all(20));
    //             } else {
    //               return Padding(
    //                   padding: const EdgeInsets.all(5),
    //                   child:
    //                       //GoodsCard(),
    //                       OpenContainer(
    //                     closedElevation: 0,
    //                     transitionType: ContainerTransitionType.fade,
    //                     closedBuilder:
    //                         (BuildContext _, VoidCallback openContainer) {
    //                       return Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: DealCard(deals[i]),
    //                       );
    //                     },
    //                     openBuilder:
    //                         (BuildContext _, VoidCallback openContainer) {
    //                       return DealDetail(deals[i]);
    //                     },
    //                   ));
    //             }
    //           },
    //           staggeredTileBuilder: (int index) {
    //             if (index == deals.length) {
    //               return StaggeredTile.fit(2);
    //             } else {
    //               return StaggeredTile.fit(1);
    //             }
    //           }),
    //       onRefresh: _refresh,
    // );
  }
}
