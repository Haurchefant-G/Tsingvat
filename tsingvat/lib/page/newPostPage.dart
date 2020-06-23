import 'dart:io';

import 'package:animations/animations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsingvat/component/customDiaglog.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/model/post.dart';
import 'package:tsingvat/util/GradientUtil.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';
import 'package:tsingvat/util/httpUtil.dart';

class newPostPage extends StatefulWidget {
  @override
  _newPostPageState createState() => _newPostPageState();
}

class _newPostPageState extends State<newPostPage> {
  GlobalKey<FormState> postKey = GlobalKey<FormState>();
  FocusNode contentFocus = FocusNode();

  HttpUtil http;
  Post post;
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
    post = Post();
  }

  Future pickImage() async {
    try {
      final image = await picker.getImage(source: ImageSource.gallery);
      //print(image);
      setState(() {
        _image = File(image.path);
        print(_image);
      });
    } catch (e) {}
  }

  Future<void> createPost() async {
    contentFocus.unfocus();
    var dealForm = postKey.currentState;
    //验证Form表单
    //if (loginForm.validate()) {
    dealForm.save();
    if (post.content.length > 0) {
      var data;
      var data2;
      try {
        post.username = await SharedPreferenceUtil.getString('username');
        data = await http.post('/post/create', post.toJson());
        post = Post.fromJson(data['data']);
        if (_image != null) {
          data2 = await http.post(
              '/images/${post.uuid}',
              FormData.fromMap(
                  {'images': MultipartFile.fromFileSync(_image.path)}));
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
                  "发布失败",
                  textAlign: TextAlign.center,
                ),
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
                "当前内容为空",
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
        onPressed: () {
          createPost();
        },
        child: Icon(Icons.done_outline),
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          floating: false,
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("发布资讯"),
            background: DecoratedBox(
                decoration:
                    BoxDecoration(gradient: GradientUtil.warmFlame(angle: 45))),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: postKey,
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.subtitle1,
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Theme.of(context).dialogBackgroundColor,
                        ),
                        child: TextFormField(
                          focusNode: contentFocus,
                          maxLength: 200,
                          //textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: '内容',
                            border: InputBorder.none,
                          ),
                          style: Theme.of(context)
                              .primaryTextTheme
                              .subtitle1
                              .copyWith(height: 1.8),
                          maxLines: 10,
                          keyboardType: TextInputType.multiline,
                          onSaved: (v) {
                            post.content = v;
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
