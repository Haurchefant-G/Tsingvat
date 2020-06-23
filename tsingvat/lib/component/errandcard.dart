import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tsingvat/component/customDiaglog.dart';
import 'package:tsingvat/const/code.dart';
import 'package:tsingvat/model/errand.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';
import 'package:tsingvat/util/httpUtil.dart';

class ErrandCard extends StatefulWidget {
  String fromAddr;
  String toAddr;
  String sfromAddr;
  String stoAddr;
  String ddlTime;
  double bonus;
  String uuid;
  String content;
  bool take = false;
  Future<void> Function() refresh;

  ErrandCard(Errand e, Future<void> Function() refresh) {
    var time = DateTime.fromMillisecondsSinceEpoch(e.ddlTime ?? 1592316306000);
    ddlTime = "${time.hour}:${time.minute}";

    fromAddr = e.fromAddr;
    sfromAddr = e.sfromAddr;
    toAddr = e.toAddr;
    stoAddr = e.stoAddr;
    bonus = e.bonus;
    uuid = e.uuid;
    content = e.content;
    this.refresh = refresh;
  }
  @override
  _ErrandCardState createState() => _ErrandCardState();
}

class _ErrandCardState extends State<ErrandCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _heightFactor;
  Animation<double> _opacity;
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeInOut));
    _opacity = _controller.drive(CurveTween(curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void handleTap() {
    setState(() {
      expanded = !expanded;
      if (expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Future<void> _take() async {
    var data;
    String taker;
    try {
      //print(DateTime.now().toIso8601String());
      print(DateTime.now().millisecondsSinceEpoch);
      taker = await SharedPreferenceUtil.getString('username');
      data = await HttpUtil()
          .put("/errand/take", {"uuid": widget.uuid, "taker": taker});
      await Future.delayed(Duration(milliseconds: 500));
      //{"time": DateTime.now().millisecondsSinceEpoch});
    } catch (e) {
      print(e);
      return;
    }
    //print(data);
    if (data['code'] == ResultCode.SUCCESS) {
      Navigator.of(context).pop();
      handleTap();
      widget.refresh();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget child) {
        return Card(
          elevation: 4,
            //color: Color(0xffB2EBF2),
            child: InkWell(
          //splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            handleTap();
            print("tapped");
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //ExpansionPanel
                  // IconButton(
                  //     icon: Icon(Icons.location_on, color: Colors.purple[200])),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.location_on, color: Colors.purple[200]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: DefaultTextStyle(
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline6
                            .copyWith(color: Colors.grey[700]),
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(child: Text(widget.ddlTime ?? "时间")),
                            Expanded(
                                child: Center(
                                    child: Text(
                              widget.fromAddr ?? "起始点",
                              textAlign: TextAlign.center,
                            ))),
                            Expanded(
                                child: Text(
                              widget.bonus != null
                                  ? "￥${widget.bonus?.toString()}"
                                  : "报酬",
                              textDirection: TextDirection.rtl,
                            ))
                          ],
                        )),
                  ),
                  ClipRect(
                      child: Align(
                    heightFactor: _heightFactor.value,
                    child: Opacity(
                      opacity: _opacity.value,
                      child: Column(
                        children: <Widget>[
                          DefaultTextStyle(
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                .copyWith(color: Colors.grey[700]),
                            child: Column(children: <Widget>[
                              Text(widget.content),
                              Text(
                                  "任务点 : ${widget.fromAddr} ${widget.sfromAddr}"),
                              Text("完成点 : ${widget.toAddr} ${widget.stoAddr}")
                            ]),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton.icon(
                                  color:
                                      Colors.purple[200], //Color(0xFFBB86FC),
                                  textColor: Colors.white,
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
                                                  onPressed: _take,
                                                  child: Text("确认"))
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(Icons.done),
                                  label: Text("接取"))
                            ],
                          )
                        ],
                      ),
                    ),
                  ))
                ]),
          ),
        ));
      },
    );
  }
}
