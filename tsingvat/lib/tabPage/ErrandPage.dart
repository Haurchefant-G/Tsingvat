import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tsingvat/component/errandcard.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/model/errand.dart';
import 'package:tsingvat/page/searchErrandPage.dart';
import 'package:tsingvat/util/httpUtil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ErrandPage extends StatefulWidget {
  ErrandPage({Key key, bool fresh = false}) : super(key: key) {
    print(fresh);
  }
  @override
  _ErrandPageState createState() => _ErrandPageState();
}

class _ErrandPageState extends State<ErrandPage> {
  HttpUtil http;
  List<Errand> errands = [];
  ScrollController _scrollController;
  bool load = false;
  bool current;
  bool nomore = false;

  @override
  void initState() {
    print('init');
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
    _getMore(); //.then((value) => _getMore());
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
      data = await http.get("/errand", null);
      await Future.delayed(Duration(milliseconds: 500), () {});
    } catch (e) {
      print(e);
      return;
    }
    //print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      errands.clear();
      print(data['data'].length);
      for (var json in data['data']) {
        var e = Errand.fromJson(json);
        if (e.taker == null) {
          errands.add(e);
        }
      }
    }
    // if (errands.length < 8) {
    //   await _getMore();
    // }
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
        data = await http.get("/errand",
            errands.length > 0 ? {"time": errands.last.created} : null);
        await Future.delayed(Duration(milliseconds: 500), () {});
      } catch (e) {
        print(e);
        return;
      }
      //print(data);
      var n = errands.length;
      if (data['code'] == ResultCode.SUCCESS) {
        for (var json in data['data']) {
          var e = Errand.fromJson(json);
          //errands.add(e);
          if (e.taker == null) {
            errands.add(e);
          }
        }
      }
      if (data['data'].length == 0) {
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
    print("build");
    return RefreshIndicator(
      child: Container(
        //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        //padding: EdgeInsets.all(16),
        // decoration: BoxDecoration(
        //     color: Theme.of(context).backgroundColor,
        //     borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: errands.length + 2,
            itemBuilder: (context, i) {
              if (i == 0) {
                return OpenContainer(
                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                    return Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        Container(
                          height: 50,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow()],
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            color: Theme.of(context).dialogBackgroundColor,
                          ),
                          child: null,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 126, 126, 126),
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    );
                  },
                  closedElevation: 0,
                  transitionType: ContainerTransitionType.fade,
                  openBuilder: (BuildContext _, VoidCallback openContainer) {
                    return searchErrandPage();
                  },
                );
              } else if (i == errands.length + 1) {
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
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ErrandCard(errands[i - 1], _refresh),
              );
            }),
      ),
      onRefresh: _refresh,
    );

//Sliver版本
    // return CustomScrollView(
    //   controller: _scrollController,
    //   slivers: <Widget>[
    //     SliverOverlapInjector(
    //       This is the flip side of the SliverOverlapAbsorber above.
    //       handle: NestedScrollView.sliverOverlapAbsorberHandleFor(this.context),
    //     ),
    //     SliverList(
    //       delegate: SliverChildBuilderDelegate((context, i) {
    //         if (i == errands.length) {
    //           return more
    //               ? Padding(
    //                   padding: const EdgeInsets.only(bottom: 20),
    //                   child: SpinKitWave(
    //                       color: Colors.lightBlueAccent.withOpacity(0.5),
    //                       size: 30.0),
    //                 )
    //               : Padding(padding: EdgeInsets.all(20));
    //         }
    //         return Padding(
    //           padding: const EdgeInsets.only(bottom: 10),
    //           child: ErrandCard(errands[i], _refresh),
    //         );
    //       }, childCount: errands.length + 1),
    //     ),
  }
}
