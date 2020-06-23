import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tsingvat/component/customDiaglog.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/model/errand.dart';
import 'package:tsingvat/util/GradientUtil.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';
import 'package:tsingvat/util/httpUtil.dart';

class newErrandPage extends StatefulWidget {
  @override
  _newErrandPageState createState() => _newErrandPageState();
}

class _newErrandPageState extends State<newErrandPage> {
  GlobalKey<FormState> errandKey = GlobalKey<FormState>();
  FocusNode contentFocus = FocusNode();
  FocusNode bonusFocus = FocusNode();
  FocusNode sfromFocus = FocusNode();
  FocusNode stoFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode detailFocus = FocusNode();

  HttpUtil http;
  Errand errand;

  double pay;
  String start;
  String startDetail;
  String startTime = '起始时间';
  String end;
  String endDetail;
  String endTime = '送达时间';
  String phone = '';

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
    '其他'
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
    errand = Errand();
  }

  Future<void> createPost() async {
    contentFocus.unfocus();
    bonusFocus.unfocus();
    sfromFocus.unfocus();
    stoFocus.unfocus();
    phoneFocus.unfocus();
    detailFocus.unfocus();
    var errandForm = errandKey.currentState;
    errandForm.save();
    if (errand.content.length > 0 &&
        errand.bonus >= 0 &&
        errand.fromAddr.length > 0 &&
        errand.sfromAddr.length > 0 &&
        errand.toAddr.length > 0 &&
        errand.stoAddr.length > 0 &&
        errand.ddlTime > 0) {
      var data;
      try {
        errand.username = await SharedPreferenceUtil.getString('username');
        data = await http.post('/errand/create', errand.toJson());
        errand = Errand.fromJson(data['data']);
      } catch (e) {
        print(e);
        showModal(
            context: context,
            configuration: FadeScaleTransitionConfiguration(),
            builder: (BuildContext context) {
              return CustomDialog(
                title: Text(
                  "发布失败",
                  textAlign: TextAlign.center,
                ),
                // content:
                //     //Text("登陆失败",textAlign: TextAlign.center,),
                //     Text(
                //   "",
                //   textAlign: TextAlign.center,
                // ),
                actions: <Widget>[],
              );
            });
        return;
      }
      print(data);
      if (data['code'] == ResultCode.SUCCESS) {
        showModal(
            context: context,
            configuration: FadeScaleTransitionConfiguration(),
            builder: (BuildContext context) {
              Future.delayed(Duration(milliseconds: 500), () {
                Navigator.of(context).popUntil(ModalRoute.withName('homePage'));
              });
              return CustomDialog(
                title: Text(
                  "发布成功",
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[],
              );
            });
        //}
      } else {
        showModal(
            context: context,
            configuration: FadeScaleTransitionConfiguration(),
            builder: (BuildContext context) {
              return CustomDialog(
                title: Text(
                  "发布失败",
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[],
              );
            });
        //}
      }
    } else {
      showModal(
          context: context,
          configuration: FadeScaleTransitionConfiguration(),
          builder: (BuildContext context) {
            return CustomDialog(
              title: Text(
                "请完善任务信息",
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: createPost,
        child: Icon(Icons.done_outline),
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          floating: false,
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("发布跑腿"),
            background: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: GradientUtil.freshOasis(angle: 45))),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: errandKey,
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.subtitle1,
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Theme.of(context).dialogBackgroundColor,
                        ),
                        child: TextFormField(
                          focusNode: contentFocus,
                          decoration: InputDecoration(
                            hintText: '任务简述',
                            prefixIcon: Icon(Icons.local_offer),
                            border: InputBorder.none,
                          ),
                          onEditingComplete: () {
                            contentFocus.unfocus();
                            bonusFocus.requestFocus();
                          },
                          keyboardType: TextInputType.text,
                          onSaved: (v) {
                            errand.content = v;
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Theme.of(context).dialogBackgroundColor,
                        ),
                        child: TextFormField(
                          focusNode: bonusFocus,
                          decoration: InputDecoration(
                            hintText: '报酬',
                            prefixIcon:
                                ImageIcon(AssetImage("assets/icon/RMB.png")),
                            border: InputBorder.none,
                          ),
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp("[0-9]"))
                          ],
                          keyboardType: TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                          onEditingComplete: () {
                            bonusFocus.unfocus();
                          },
                          onSaved: (v) {
                            try {
                              errand.bonus = double.parse(v);
                            } catch (e) {
                              errand.bonus = -1;
                            }
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
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
                                  value: start,
                                  items: locationItems,
                                  onChanged: (String v) {
                                    errand.fromAddr = v;
                                  }),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          Expanded(
                            flex: 1,
                            child: Container(
                                // padding: EdgeInsets.only(right: 8),
                                // decoration: BoxDecoration(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(100)),
                                //   color: Theme.of(context).dialogBackgroundColor,
                                // ),
                                // child: FormField(
                                //     builder: (FormFieldState<String> field) {
                                //   return FlatButton(
                                //       highlightColor: Colors.transparent,
                                //       splashColor: Colors.transparent,
                                //       onPressed: () {
                                //         Future<TimeOfDay> p = showTimePicker(
                                //           context: context,
                                //           initialTime: TimeOfDay.now(),
                                //         );
                                //         p.then((value) => {
                                //               setState(() {
                                //                 startTime =
                                //                     "${value.hour}:${value.minute}";
                                //               })
                                //             });
                                //       },
                                //       child: Text(startTime,
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .subtitle1));
                                // }),
                                ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Theme.of(context).dialogBackgroundColor,
                        ),
                        child: TextFormField(
                          focusNode: sfromFocus,
                          decoration: InputDecoration(
                            hintText: '具体取物地点',
                            prefixIcon: Icon(Icons.location_on),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                          onEditingComplete: () {
                            sfromFocus.unfocus();
                          },
                          onSaved: (v) {
                            errand.sfromAddr = v;
                          },
                          onFieldSubmitted: (value) {},
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
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
                                  value: end,
                                  items: locationItems,
                                  onChanged: (String v) {
                                    errand.toAddr = v;
                                  }),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  padding: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    color:
                                        Theme.of(context).dialogBackgroundColor,
                                  ),
                                  child: FormField(
                                      builder: (FormFieldState<String> field) {
                                    return FlatButton(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onPressed: () {
                                          Future<TimeOfDay> p = showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            builder: (BuildContext context,
                                                Widget child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        // alwaysUse24HourFormat:
                                                        //     true
                                                        ),
                                                child: child,
                                              );
                                            },
                                          );
                                          p.then((value) {
                                            setState(() {
                                              endTime =
                                                  "${value.hour}:${value.minute}";
                                            });
                                            errand.ddlTime = DateTime(
                                                    DateTime.now().year,
                                                    DateTime.now().month,
                                                    DateTime.now().day,
                                                    value.hour,
                                                    value.minute)
                                                .millisecondsSinceEpoch;
                                          });
                                        },
                                        child: Text(endTime,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1));
                                  }))),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Theme.of(context).dialogBackgroundColor,
                        ),
                        child: TextFormField(
                          focusNode: stoFocus,
                          decoration: InputDecoration(
                            hintText: '具体送达地点',
                            prefixIcon: Icon(Icons.location_on),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                          onEditingComplete: () {
                            stoFocus.unfocus();
                            phoneFocus.requestFocus();
                          },
                          onSaved: (v) {
                            errand.stoAddr = v;
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Theme.of(context).dialogBackgroundColor,
                        ),
                        child: TextFormField(
                          focusNode: phoneFocus,
                          decoration: InputDecoration(
                            hintText: '联系电话,可省略',
                            prefixIcon: Icon(Icons.phone),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.phone,
                          onEditingComplete: () {
                            phoneFocus.unfocus();
                            detailFocus.requestFocus();
                          },
                          onSaved: (v) {
                            errand.phone = null;
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Theme.of(context).dialogBackgroundColor,
                        ),
                        child: TextFormField(
                          focusNode: detailFocus,
                          decoration: InputDecoration(
                            hintText: '补充信息，可省略(只有接单人可看到，对于部分关键信息如取件码，收件人名登请填写在此)',
                            border: InputBorder.none,
                          ),
                          style: Theme.of(context)
                              .primaryTextTheme
                              .subtitle1
                              .copyWith(height: 1.8),
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          onSaved: (v) {
                            errand.details = v;
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 300)),
                    ],
                  ),
                )),
          ),
        )
      ]),
    );
  }
}
