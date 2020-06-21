import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tsingvat/component/customDiaglog.dart';
import 'package:tsingvat/model/errand.dart';

class ErrandCard extends StatefulWidget {
  String fromAddr;
  String toAddr;
  String sfromAddr;
  String stoAddr;
  String ddlTime;
  double bonus;
  String uuid;
  String content;

  ErrandCard(Errand e) {
    var time = DateTime.fromMillisecondsSinceEpoch(e.ddlTime ?? 1592316306000);
    ddlTime = "${time.hour}:${time.minute}";
    fromAddr = e.fromAddr;
    sfromAddr = e.sfromAddr;
    toAddr = e.toAddr;
    stoAddr = e.stoAddr;
    bonus = e.bonus;
    uuid = e.uuid;
    content = e.content;
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
  String fromAddr;
  String toAddr;
  String sfromAddr;
  String stoAddr;
  String ddlTime;
  double bonus;

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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget child) {
        return Card(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(widget.ddlTime ?? "时间"),
                            Text(widget.fromAddr ?? "起始点"),
                            Text(widget.bonus == null ? "￥${widget.bonus?.toString()}" : "报酬")
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
                                                  onPressed: () {},
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
