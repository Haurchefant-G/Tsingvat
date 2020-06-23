import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tsingvat/component/customDiaglog.dart';
import 'package:tsingvat/component/errandcard.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/model/errand.dart';
import 'package:tsingvat/util/GradientUtil.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';
import 'package:tsingvat/util/httpUtil.dart';

class searchErrandPage extends StatefulWidget {
  @override
  _searchErrandPageState createState() => _searchErrandPageState();
}

class _searchErrandPageState extends State<searchErrandPage> {
  GlobalKey<FormState> searchKey = GlobalKey<FormState>();
  FocusNode strlikeFocus = FocusNode();
  FocusNode minBonusFocus = FocusNode();
  FocusNode maxBonusFocus = FocusNode();

  HttpUtil http;
  List<Errand> results = [];
  bool load = false;
  bool current;

  String strlike;
  String fromAddr;
  String toAddr;
  String minBonus;
  String maxBonus;

  List<DropdownMenuItem<String>> locationItems = [
    '第六教学楼',
    '第三教学楼',
    '第二教学楼',
    '第四教学楼',
    '桃李园周边',
    '紫荆园周边',
    '清芬园周边',
    '李兆基大楼',
    '东操周边',
    '主楼周边',
    '西操周边',
    '北馆',
    '快递点',
    '北门',
    '东南门',
    '西门',
    '其他',
    "空"
  ].map<DropdownMenuItem<String>>((String v) {
    return DropdownMenuItem<String>(
      value: v,
      child: Text(v),
    );
  }).toList();

  @override
  void initState() {
    super.initState();
    http = HttpUtil();
    current = true;
  }

  Future<void> _Search() async {
    var data;
    searchKey.currentState.save();
    strlikeFocus.unfocus();
    minBonusFocus.unfocus();
    maxBonusFocus.unfocus();
    setState(() {
      results.clear();
      load = true;
    });
    try {
      data = await http.get('/query/errand', {
        "strLike": strlike,
        "fromAddr": fromAddr,
        "toAddr": toAddr,
        "minBonus": minBonus,
        "maxBonus": maxBonus
      });
      await Future.delayed(Duration(milliseconds: 500), () {});
    } catch (e) {
      print(e);
    }
    print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      for (var json in data['data']) {
        var e = Errand.fromJson(json);
        //errands.add(e);
        if (e.taker == null) {
          results.add(e);
        }
      }
    }
    if (current == true) {
      setState(() {
        load = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    current = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("搜索跑腿任务"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Form(
                key: searchKey,
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.subtitle1,
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Theme.of(context).dialogBackgroundColor,
                        ),
                        child: TextFormField(
                          focusNode: strlikeFocus,
                          decoration: InputDecoration(
                            hintText: '任务关键字',
                            prefixIcon: Icon(Icons.local_offer),
                            border: InputBorder.none,
                          ),
                          onEditingComplete: () {
                            strlikeFocus.unfocus();
                          },
                          keyboardType: TextInputType.text,
                          onSaved: (v) {
                            strlike = v;
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                color: Theme.of(context).dialogBackgroundColor,
                              ),
                              child: TextFormField(
                                focusNode: minBonusFocus,
                                decoration: InputDecoration(
                                  hintText: '最低报酬',
                                  prefixIcon: ImageIcon(
                                      AssetImage("assets/icon/RMB.png")),
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9]"))
                                ],
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: false, decimal: true),
                                onEditingComplete: () {
                                  minBonusFocus.unfocus();
                                },
                                onSaved: (v) {
                                  minBonus = v;
                                  // try {
                                  //   minBonus = v;
                                  // } catch (e) {
                                  //   errand.bonus = -1;
                                  // }
                                },
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                color: Theme.of(context).dialogBackgroundColor,
                              ),
                              child: TextFormField(
                                focusNode: maxBonusFocus,
                                decoration: InputDecoration(
                                  hintText: '最高报酬',
                                  prefixIcon: ImageIcon(
                                      AssetImage("assets/icon/RMB.png")),
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9]"))
                                ],
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: false, decimal: true),
                                onEditingComplete: () {
                                  maxBonusFocus.unfocus();
                                },
                                onSaved: (v) {
                                  maxBonus = v;
                                  // try {
                                  //   errand.bonus = double.parse(v);
                                  // } catch (e) {
                                  //   errand.bonus = -1;
                                  // }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 45,
                              padding: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                color: Theme.of(context).dialogBackgroundColor,
                              ),
                              child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    hintText: '取物地点',
                                    prefixIcon: Icon(Icons.location_city),
                                    border: InputBorder.none,
                                  ),
                                  icon: Icon(Icons.arrow_downward),
                                  value: fromAddr,
                                  items: locationItems,
                                  onChanged: (String v) {
                                    fromAddr = v;
                                    if (v == "空") {
                                      fromAddr = null;
                                    }
                                  }),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 45,
                              padding: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                color: Theme.of(context).dialogBackgroundColor,
                              ),
                              child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    hintText: '送达地点',
                                    prefixIcon: Icon(Icons.location_city),
                                    border: InputBorder.none,
                                  ),
                                  icon: Icon(Icons.arrow_downward),
                                  value: toAddr,
                                  items: locationItems,
                                  onChanged: (String v) {
                                    toAddr = v;
                                    if (v == "空") {
                                      fromAddr = null;
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(20)),
                    ],
                  ),
                )),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: _Search,
        child: Icon(Icons.search),
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(padding: EdgeInsets.all(10)),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, i) {
            if (i == results.length) {
              return load
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SpinKitWave(
                          color: Colors.lightBlueAccent.withOpacity(0.5),
                          size: 30.0),
                    )
                  : Padding(padding: EdgeInsets.all(20));
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ErrandCard(results[i], _Search),
            );
          }, childCount: results.length + 1),
        ),
      ]),
    );
  }
}
