import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tsingvat/component/customDiaglog.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/const/const_url.dart';
import 'package:tsingvat/model/errand.dart';
import 'package:tsingvat/util/httpUtil.dart';

class TakedErrandsPage extends StatefulWidget {
  TakedErrandsPage(String username) {
    this.username = username;
  }
  String username;
  @override
  _TakedErrandsPageState createState() => _TakedErrandsPageState();
}

class _TakedErrandsPageState extends State<TakedErrandsPage> {
  List<Errand> errands = [];
  HttpUtil http;
  bool current;

  Future<void> getTaked() async {
    var data;
    // await Future.delayed(Duration(seconds: 2), () {
    //   print("刷新结束");
    // });
    try {
      //print(DateTime.now().toIso8601String());
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.get("/errand/${widget.username}/take", null);
      //await Future.delayed(Duration(milliseconds: 500), () {});
      //{"time": DateTime.now().millisecondsSinceEpoch});
    } catch (e) {
      print(e);
      return;
    }
    //print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      errands.clear();
      for (var json in data['data']) {
        var e = Errand.fromJson(json);
        if (e.finishTime == null) {
          errands.add(e);
        }
      }
    }
    if (current == true) {
      setState(() {});
    }
  }

  finish(int i) async {
    var data;
    try {
      //print(DateTime.now().toIso8601String());
      print(DateTime.now().millisecondsSinceEpoch);
      data = await http.put("/errand/finish", errands[i].toJson());
      //await Future.delayed(Duration(milliseconds: 500), () {});
      //{"time": DateTime.now().millisecondsSinceEpoch});
    } catch (e) {
      print(e);
      return;
    }
    //print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      Navigator.of(context).pop();
      getTaked();
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
    getTaked();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("待完成任务"),
      ),
      body: RefreshIndicator(
        onRefresh: getTaked,
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
                          Text("${errands[i].content}"),
                          Text(
                              "起始点 : ${errands[i].fromAddr} ${errands[i].sfromAddr}"),
                          Text(
                              "目标点 : ${errands[i].toAddr} ${errands[i].stoAddr}"),
                          Text(
                            "补充信息:\n ${errands[i].details}",
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
                              onPressed: () {}, child: Icon(Icons.phone)),
                        )),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.zero,
                          height: 50,
                          child: FlatButton(
                              onPressed: () {}, child: Icon(Icons.chat)),
                        )),
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
                                          "确认接取",
                                          textAlign: TextAlign.center,
                                        ),
                                        content:
                                            //Text("登陆失败",textAlign: TextAlign.center,),
                                            Text(
                                          "请确认",
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
                                                finish(i);
                                              },
                                              child: Text("确认"))
                                        ],
                                      );
                                    });
                              },
                              child: Icon(Icons.done)),
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
