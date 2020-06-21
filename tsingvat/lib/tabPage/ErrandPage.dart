import 'package:flutter/material.dart';
import 'package:tsingvat/component/errandcard.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/model/errand.dart';
import 'package:tsingvat/util/httpUtil.dart';

class ErrandPage extends StatefulWidget {
  @override
  _ErrandPageState createState() => _ErrandPageState();
}

class _ErrandPageState extends State<ErrandPage> {
  HttpUtil http;
  List<Errand> errands = [];

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
      data = await http.get("/errand", null);
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
          errands.add(Errand.fromJson(json));
        });
      }
    }
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
            child: ListView.builder(itemCount: errands.length, itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ErrandCard(errands[i]),
              );
            }),
            onRefresh: _refresh));
  }
}
