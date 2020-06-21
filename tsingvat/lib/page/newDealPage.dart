import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class newDealPage extends StatefulWidget {
  @override
  _newDealPageState createState() => _newDealPageState();
}

class _newDealPageState extends State<newDealPage> {
  GlobalKey<FormState> taskKey = GlobalKey<FormState>();

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

  Future pickImage() async {
    try {
      final image = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        _image = File(image.path);
        print(_image);
      });
    } catch (e) {}
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
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.done_outline),
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          //title: Text("title"),
          floating: false,
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(title: Text("发布交易")),
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
                key: taskKey,
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
                          decoration: InputDecoration(
                            hintText: '出售物品',
                            //prefixText: '￥  ',
                            //prefixIcon: Icon(Icons.attach_money),
                            prefixIcon: Icon(Icons.local_offer),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                          onSaved: (v) {},
                          validator: (v) {},
                          onFieldSubmitted: (v) {},
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
                            decoration: InputDecoration(
                              hintText: '价格',
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
                            onSaved: (v) {
                              pay = double.parse(v);
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
                          //textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: '联系电话',
                            //prefixText: '￥  ',
                            //prefixIcon: Icon(Icons.attach_money),
                            prefixIcon: Icon(Icons.phone),
                            border: InputBorder.none,
                          ),
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp("[0-9]"))
                          ],
                          keyboardType: TextInputType.phone,
                          onSaved: (v) {},
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
                          //textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: '补充信息(出售物品具体描述)',
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
                          onSaved: (v) {},
                          validator: (v) {},
                          onFieldSubmitted: (value) {},
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