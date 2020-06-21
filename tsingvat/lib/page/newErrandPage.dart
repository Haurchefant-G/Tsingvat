import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tsingvat/component/customDiaglog.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/model/errand.dart';
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
    '紫荆宿舍区-桃李园附近',
    '紫荆宿舍区-紫荆园附近'
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
    detailFocus.unfocus();
    var errandForm = errandKey.currentState;
    //验证Form表单
    //if (loginForm.validate()) {
    errandForm.save();
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
              // content:
              //     //Text("登陆失败",textAlign: TextAlign.center,),
              //     Text(
              //   "用户名或密码错误",
              //   textAlign: TextAlign.center,
              // ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: <Widget>[
      //     IconButton(icon: Icon(Icons.home), onPressed: null)
      //   ],
      //   backgroundColor: Theme.of(context).secondaryHeaderColor,
      //   //bottom: TabBar(tabs: [Tab(child: Text("123"))]),
      //   flexibleSpace: FlexibleSpaceBar(title: Text("123")),
      // ),
      backgroundColor: Colors.grey[200],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: createPost,
        child: Icon(Icons.done_outline),
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          //title: Text("title"),
          floating: false,
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(title: Text("发布任务")),
        ),
        // SliverFixedExtentList(
        //   itemExtent: 50.0,
        //   delegate: SliverChildBuilderDelegate(
        //     (context, index) => ListTile(
        //       title: Text("Item $index"),
        //     ),
        //     childCount: 30,
        //   ),
        // ),
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
                          //textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: '任务简述',
                            //prefixText: '￥  ',
                            //prefixIcon: Icon(Icons.attach_money),
                            prefixIcon: Icon(Icons.local_offer),
                            border: InputBorder.none,
                          ),
                          // TODO 除了检查邮箱外还应检查清华邮箱，或者只需填写用户名即可
                          onEditingComplete: () {
                            contentFocus.unfocus();
                            bonusFocus.requestFocus();
                          },
                          keyboardType: TextInputType.text,
                          onSaved: (v) {
                            errand.content = v;
                          },
                          validator: (v) {},
                          onFieldSubmitted: (v) {},
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Theme.of(context).dialogBackgroundColor,
                        ),
                        child: TextFormField(
                          //textAlign: TextAlign.center,
                          focusNode: bonusFocus,
                          decoration: InputDecoration(
                            hintText: '报酬',
                            //prefixText: '￥  ',
                            //prefixIcon: Icon(Icons.attach_money),
                            prefixIcon:
                                ImageIcon(AssetImage("assets/icon/RMB.png")),
                            border: InputBorder.none,
                          ),
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp("[1-9.]"))
                          ],

                          keyboardType: TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                          onEditingComplete: () {
                            bonusFocus.unfocus();
                          },
                          onSaved: (v) {
                            errand.bonus = double.parse(v);
                          },
                          validator: (username) {
                            if (username.length == 0) {
                              print('请输入用户名');
                            }
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
                                    hintText: '取物地点',

                                    //prefixText: '￥  ',

                                    //prefixIcon: Icon(Icons.attach_money),

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
                          //textAlign: TextAlign.center,
                          focusNode: sfromFocus,
                          decoration: InputDecoration(
                            hintText: '具体取物地点',
                            //prefixText: '￥  ',
                            //prefixIcon: Icon(Icons.attach_money),
                            prefixIcon: Icon(Icons.location_on),
                            border: InputBorder.none,
                          ),
                          // inputFormatters: [
                          //   WhitelistingTextInputFormatter(RegExp("[1-9.]"))
                          // ],
                          keyboardType: TextInputType.text,
                          onEditingComplete: () {
                            sfromFocus.unfocus();
                          },
                          onSaved: (v) {
                            errand.sfromAddr = v;
                          },
                          validator: (v) {},
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

                                    //prefixText: '￥  ',

                                    //prefixIcon: Icon(Icons.attach_money),

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
                                                        alwaysUse24HourFormat:
                                                            true),
                                                child: child,
                                              );
                                            },
                                          );
                                          p.then((value) {
                                            setState(() {
                                              endTime =
                                                  "${value.hour}:${value.minute}";
                                              //endTime = value.toString();
                                              // }
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
                          //textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: '具体送达地点',
                            //prefixText: '￥  ',
                            //prefixIcon: Icon(Icons.attach_money),
                            prefixIcon: Icon(Icons.location_on),
                            border: InputBorder.none,
                          ),
                          // inputFormatters: [
                          //   WhitelistingTextInputFormatter(RegExp("[1-9.]"))
                          // ],
                          keyboardType: TextInputType.text,
                          onEditingComplete: () {
                            stoFocus.unfocus();
                            phoneFocus.requestFocus();
                          },
                          onSaved: (v) {
                            errand.stoAddr = v;
                          },
                          validator: (v) {},
                          onFieldSubmitted: (value) {},
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Theme.of(context).dialogBackgroundColor,
                        ),
                        child: TextFormField(
                          //textAlign: TextAlign.center,
                          focusNode: phoneFocus,
                          decoration: InputDecoration(
                            hintText: '联系电话',
                            //prefixText: '￥  ',
                            //prefixIcon: Icon(Icons.attach_money),
                            prefixIcon: Icon(Icons.phone),
                            border: InputBorder.none,
                          ),
                          // inputFormatters: [
                          //   WhitelistingTextInputFormatter(RegExp("[1-9.]"))
                          // ],
                          keyboardType: TextInputType.phone,
                          onEditingComplete: () {
                            phoneFocus.unfocus();
                            detailFocus.requestFocus();
                          },
                          onSaved: (v) {
                            errand.phone = null;
                            //v;
                          },
                          validator: (v) {},
                          onFieldSubmitted: (value) {},
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
                          //textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: '补充信息(如快递单号，快递收件人等)',
                            //prefixText: '￥  ',
                            //prefixIcon: Icon(Icons.attach_money),
                            //prefixIcon: Icon(Icons.info),
                            border: InputBorder.none,
                          ),
                          // inputFormatters: [
                          //   WhitelistingTextInputFormatter(RegExp("[1-9.]"))
                          // ],
                          style: Theme.of(context)
                              .primaryTextTheme
                              .subtitle1
                              .copyWith(height: 1.8),
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          onSaved: (v) {
                            errand.details = v;
                          },
                          validator: (v) {},
                          onFieldSubmitted: (value) {},
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
