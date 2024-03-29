import 'dart:io';
import 'package:animations/animations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsingvat/component/customDiaglog.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/model/deal.dart';
import 'package:tsingvat/util/GradientUtil.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';
import 'package:tsingvat/util/httpUtil.dart';

class newDealPage extends StatefulWidget {
  @override
  _newDealPageState createState() => _newDealPageState();
}

class _newDealPageState extends State<newDealPage> {
  GlobalKey<FormState> dealKey = GlobalKey<FormState>();
  FocusNode contentFocus = FocusNode();
  FocusNode priceFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode detailFocus = FocusNode();

  HttpUtil http;
  Deal deal;

  double pay;
  String start;
  String startDetail;
  String startTime = '起始时间';
  String end;
  String endDetail;
  String endTime = '送达时间';
  String phone = '';
  final picker = ImagePicker();
  File _image;

  @override
  void initState() {
    super.initState();
    http = HttpUtil();
    deal = Deal();
  }

  Future pickImage() async {
    try {
      final image = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        _image = File(image.path);
        print(_image);
      });
    } catch (e) {}
  }

  Future<void> createDeal() async {
    contentFocus.unfocus();
    priceFocus.unfocus();
    phoneFocus.unfocus();
    detailFocus.unfocus();
    var DealForm = dealKey.currentState;
    DealForm.save();
    if (_image == null) {
      showModal(
          context: context,
          configuration: FadeScaleTransitionConfiguration(),
          builder: (BuildContext context) {
            return CustomDialog(
              title: Text(
                "请选择物品图片",
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[],
            );
          });
      return;
    } else if (deal.content.length > 0 && deal.price >=0 && deal.phone.length > 0 && deal.details.length > 0) { 
    var data;
    var data2;
    try {
      deal.username = await SharedPreferenceUtil.getString('username');
      data = await http.post('/deal/create', deal.toJson());
      deal = Deal.fromJson(data['data']);
      if (_image != null) {
        data2 = await http.post(
            '/images/${deal.uuid}',
            FormData.fromMap(
                {'images': MultipartFile.fromFileSync(_image.path)}));
        print("data2-----------");
        print(data2);
      }
    } catch (e) {
      print(e);
      showModal(
          context: context,
          configuration: FadeScaleTransitionConfiguration(),
          builder: (BuildContext context) {
            return CustomDialog(
              title: Text(
                "上传失败",
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[],
            );
          });
      return;
    }
    print("data:---------");
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
                "上传成功",
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
                "上传失败",
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
        onPressed: createDeal,
        child: Icon(Icons.done_outline),
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          //title: Text("title"),
          floating: false,
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("发布交易"),
            background: DecoratedBox(
                decoration:
                    BoxDecoration(gradient: GradientUtil.lightBlue(angle: 45))),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: dealKey,
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
                          //textAlign: TextAlign.center,
                          focusNode: contentFocus,
                          decoration: InputDecoration(
                            hintText: '出售物品',
                            prefixIcon: Icon(Icons.local_offer),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                          onEditingComplete: () {
                            contentFocus.unfocus();
                            priceFocus.requestFocus();
                          },
                          onSaved: (v) {
                            deal.content = v;
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            color: Theme.of(context).dialogBackgroundColor,
                          ),
                          child: TextFormField(
                            //textAlign: TextAlign.center,
                            focusNode: priceFocus,
                            decoration: InputDecoration(
                              hintText: '价格',
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
                              priceFocus.unfocus();
                              phoneFocus.requestFocus();
                            },
                            onSaved: (v) {
                              try {
                                deal.price = double.parse(v);
                              } catch (e) {
                                deal.price = -1;
                              }
                            },
                            validator: (v) {
                              if (v.length == 0) {
                                print('请输入价格');
                              }
                            },
                            onFieldSubmitted: (value) {},
                          )),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Theme.of(context).dialogBackgroundColor,
                        ),
                        child: TextFormField(
                          focusNode: phoneFocus,
                          decoration: InputDecoration(
                            hintText: '联系电话',
                            prefixIcon: Icon(Icons.phone),
                            border: InputBorder.none,
                          ),
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp("[0-9]"))
                          ],
                          keyboardType: TextInputType.phone,
                          onEditingComplete: () {
                            phoneFocus.unfocus();
                            detailFocus.requestFocus();
                          },
                          onSaved: (v) {
                            deal.phone = v;
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
                          //textAlign: TextAlign.center,
                          focusNode: detailFocus,
                          decoration: InputDecoration(
                            hintText: '补充信息(出售物品具体描述)',
                            border: InputBorder.none,
                          ),
                          style: Theme.of(context)
                              .primaryTextTheme
                              .subtitle1
                              .copyWith(height: 1.8),
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          onEditingComplete: () {
                            detailFocus.unfocus();
                          },
                          onSaved: (v) {
                            deal.details = v;
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Row(
                        children: <Widget>[
                          Container(
                              width: 220.w,
                              height: 220.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: _image != null
                                  ? FlatButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: pickImage,
                                      child: Container(
                                          width: 220.w,
                                          height: 220.w,
                                          child: Image.file(
                                            _image,
                                            fit: BoxFit.cover,
                                          )))
                                  : FlatButton(
                                      onPressed: pickImage,
                                      child: Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                      ),
                                    )),
                        ],
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
