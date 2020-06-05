import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class newTaskPage extends StatefulWidget {
  @override
  _newTaskPageState createState() => _newTaskPageState();
}

class _newTaskPageState extends State<newTaskPage> {
  GlobalKey<FormState> taskKey = GlobalKey<FormState>();

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
                            hintText: '须取物品',
                            //prefixText: '￥  ',
                            //prefixIcon: Icon(Icons.attach_money),
                            prefixIcon: Icon(Icons.local_offer),
                            border: InputBorder.none,
                          ),
                          // TODO 除了检查邮箱外还应检查清华邮箱，或者只需填写用户名即可

                          keyboardType: TextInputType.text,
                          onSaved: (v) {},
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
                          onSaved: (v) {
                            pay = double.parse(v);
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
                                    start = v;

                                    print(start);
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
                                          );
                                          p.then((value) => {
                                                setState(() {
                                                  startTime =
                                                      "${value.hour}:${value.minute}";
                                                })
                                              });
                                        },
                                        child: Text(startTime,
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
                          //textAlign: TextAlign.center,
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
                          onSaved: (v) {},
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
                                    start = v;

                                    print(start);
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
                                          );
                                          p.then((value) => {
                                                setState(() {
                                                  // if (value.hour != null) {
                                                  //   print('123');
                                                  //   print(value);
                                                  endTime =
                                                      "${value.hour}:${value.minute}";
                                                  // }
                                                })
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
                          onSaved: (v) {},
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
                            hintText: '补充信息(如快递单号，快递收件人等)',
                            //prefixText: '￥  ',
                            //prefixIcon: Icon(Icons.attach_money),
                            //prefixIcon: Icon(Icons.info),
                            border: InputBorder.none,
                          ),
                          // inputFormatters: [
                          //   WhitelistingTextInputFormatter(RegExp("[1-9.]"))
                          // ],
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          onSaved: (v) {},
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
