import 'package:flutter/material.dart';
import 'package:tsingvat/component/errandcard.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/model/errand.dart';
import 'package:tsingvat/util/httpUtil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ErrandPage extends StatefulWidget {
  @override
  _ErrandPageState createState() => _ErrandPageState();
}

class _ErrandPageState extends State<ErrandPage> {
  HttpUtil http;
  List<Errand> errands = [];
  ScrollController _scrollController;
  bool more = false;

  @override
  void initState() {
    super.initState();
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
      data = await http.get("/errand", null);
      Future.sync(await Future.delayed(Duration(milliseconds: 500), () {}));
      //{"time": DateTime.now().millisecondsSinceEpoch});
    } catch (e) {
      print(e);
      return;
    }
    //print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      errands.clear();
      for (var json in data['data']) {
          errands.add(Errand.fromJson(json));
      }
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
      data = await http.get("/errand", null);
      Future.sync(await Future.delayed(Duration(milliseconds: 500), () {}));
      //{"time": DateTime.now().millisecondsSinceEpoch});
    } catch (e) {
      print(e);
      return;
    }
    //print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      for (var json in data['data']) {
          errands.add(Errand.fromJson(json));
      }
    }
    setState(() {
      more = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        //padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white70, //Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: RefreshIndicator(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: errands.length + 1,
                itemBuilder: (context, i) {
                  if (i == errands.length) {
                    return more
                        ? Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: SpinKitWave(
                              color: Colors.lightBlueAccent.withOpacity(0.5),
                              size: 30.0),
                        )
                        : Padding(padding: EdgeInsets.all(20));
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ErrandCard(errands[i]),
                  );
                }),
            onRefresh: _refresh));
  }
}
