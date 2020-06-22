import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tsingvat/chat/chat_detail_page.dart';
import 'package:tsingvat/component/customDiaglog.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/const/const_url.dart';
import 'package:tsingvat/model/deal.dart';
import 'package:tsingvat/model/errand.dart';
import 'package:tsingvat/util/httpUtil.dart';

class MyDealsPage extends StatefulWidget {
  MyDealsPage(String username) {
    this.username = username;
  }
  String username;
  @override
  _MyDealsPageState createState() => _MyDealsPageState();
}

class _MyDealsPageState extends State<MyDealsPage> {
  List<Deal> deals = [];
  HttpUtil http;
  bool current;

  Future<void> getMyDeals() async {
    var data;
    // await Future.delayed(Duration(seconds: 2), () {
    //   print("刷新结束");
    // });
    try {
      //print(DateTime.now().toIso8601String());
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.get("/deal/${widget.username}", null);
      //await Future.delayed(Duration(milliseconds: 500), () {});
      //{"time": DateTime.now().millisecondsSinceEpoch});
    } catch (e) {
      print(e);
      return;
    }
    //print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      deals.clear();
      for (var json in data['data']) {
        var e = Deal.fromJson(json);
          deals.add(e);
      }
    }
    if (current == true) {
      setState(() {});
    }
  }

  delete(int i) async {
    var data;
    try {
      //print(DateTime.now().toIso8601String());
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.delete("/deal/delete", {"uuid" : deals[i].uuid});
      //await Future.delayed(Duration(milliseconds: 500), () {});
      //{"time": DateTime.now().millisecondsSinceEpoch});
    } catch (e) {
      print(e);
      return;
    }
    //print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      Navigator.of(context).pop();
      getMyDeals();
    }
  }

  @override
  void dispose() {
    super.dispose();
    current = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http = HttpUtil();
    current = true;
    getMyDeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的交易"),
      ),
      body: RefreshIndicator(
        onRefresh: getMyDeals,
        child: ListView.builder(
            itemCount: deals.length,
            itemBuilder: (BuildContext context, int i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                      child: Column(children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(children: <Widget>[
                          ClipOval(
                              child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                            ),
                            child: Image.network(
                              "${ConstUrl.avatarimageurl}/${deals[i].username}/avatar.png",
                              fit: BoxFit.cover,
                            ),
                          )),
                          Padding(padding: const EdgeInsets.all(8.0)),
                          Expanded(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                Text(
                                  deals[i].username,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle1,
                                ),
                                Padding(padding: const EdgeInsets.all(1.0)),
                                Text(
                                  deals[i].phone??"无电话联系方式",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2
                                      .copyWith(color: Colors.grey),
                                )
                              ])),
                          Text(
                            "￥${deals[i].price.toString()}",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                .copyWith(color: Colors.red[400]),
                          ),
                        ])),
                    Divider(),
                    DefaultTextStyle(
                      style: Theme.of(context).primaryTextTheme.headline6,
                      child: Column(
                        children: <Widget>[
                          Text("${deals[i].content}\n", textAlign: TextAlign.center,),
                          Text(
                            "补充信息:\n ${deals[i].details}",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.zero,
                          height: 50,
                          child: FlatButton(
                              onPressed: () {
                                showModal(
                                    context: context,
                                    configuration:
                                        FadeScaleTransitionConfiguration(),
                                    builder: (BuildContext context) {
                                      return CustomDialog(
                                        title: Text(
                                          "确认删除",
                                          textAlign: TextAlign.center,
                                        ),
                                        content:
                                            //Text("登陆失败",textAlign: TextAlign.center,),
                                            Text(
                                          "请确认是否删除该交易信息",
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("取消")),
                                          FlatButton(
                                              onPressed: () {
                                                delete(i);
                                              },
                                              child: Text("确认"))
                                        ],
                                      );
                                    });
                              },
                              child: Icon(Icons.delete)),
                        )),
                      ],
                    )
                  ])),
                ),
              );
            }),
      ),
    );
  }
}
