import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tsingvat/chat/chat_detail_page.dart';
import 'package:tsingvat/component/customDiaglog.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/const/const_url.dart';
import 'package:tsingvat/model/errand.dart';
import 'package:tsingvat/util/httpUtil.dart';

class MyWaitErrandsPage extends StatefulWidget {
  MyWaitErrandsPage(String username) {
    this.username = username;
  }
  String username;
  @override
  _MyWaitErrandsPageState createState() => _MyWaitErrandsPageState();
}

class _MyWaitErrandsPageState extends State<MyWaitErrandsPage> {
  List<Errand> errands = [];
  HttpUtil http;
  bool current;

  Future<void> getWait() async {
    var data;
    try {
      //print(DateTime.now().toIso8601String());
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.get("/errand/${widget.username}", null);
    } catch (e) {
      print(e);
      return;
    }
    //print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      errands.clear();
      for (var json in data['data']) {
        var e = Errand.fromJson(json);
        errands.add(e);
      }
    }
    if (current == true) {
      setState(() {});
    }
  }

  delete(int i) async {
    var data;
    try {
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.delete("/errand/delete", {"uuid": errands[i].uuid});
    } catch (e) {
      print(e);
      return;
    }
    if (data['code'] == ResultCode.SUCCESS) {
      Navigator.of(context).pop();
      getWait();
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
    getWait();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的跑腿"),
      ),
      body: RefreshIndicator(
        onRefresh: getWait,
        child: ListView.builder(
            itemCount: errands.length,
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
                              "${ConstUrl.avatarimageurl}/${errands[i].username}/avatar.png",
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
                                  errands[i].username,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle1,
                                ),
                                Padding(padding: const EdgeInsets.all(1.0)),
                                Text(
                                  errands[i].phone ?? "无电话联系方式",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2
                                      .copyWith(color: Colors.grey),
                                )
                              ])),
                          Text(
                            "￥${errands[i].bonus.toString()}",
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
                          Text(
                            "${errands[i].content}\n",
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "起始点",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                              ),
                              Text(
                                "目标点",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "${errands[i].fromAddr}\n ${errands[i].sfromAddr}\n",
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${errands[i].toAddr}\n ${errands[i].stoAddr}\n",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Text(
                            "补充信息",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                          ),
                          Text(
                            errands[i].details ?? " ",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                        child: errands[i].taker == null
                            ? null
                            : Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(children: <Widget>[
                                  ClipOval(
                                      child: Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                    child: Image.network(
                                      "${ConstUrl.avatarimageurl}/${errands[i].taker}/avatar.png",
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                                  Padding(padding: const EdgeInsets.all(8.0)),
                                  Expanded(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                        Text(
                                          errands[i].taker,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle1,
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(1.0)),
                                        Text(
                                          "接取人",
                                        )
                                      ])),
                                  Text(
                                    "",
                                  ),
                                ]))),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.zero,
                          height: 50,
                          child: errands[i].taker == null
                              ? FlatButton(
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
                                              "请确认是否删除该任务",
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
                                  child: Icon(Icons.delete))
                              : FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return ChatDetailPage(errands[i].taker);
                                    }));
                                  },
                                  child: Icon(Icons.chat)),
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
