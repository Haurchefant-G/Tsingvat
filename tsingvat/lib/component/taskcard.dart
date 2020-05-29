import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _heightFactor;
  Animation<double> _opacity;
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 500), vsync: this);
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
                  IconButton(
                      icon: Icon(Icons.location_on, color: Colors.purple[200])),
                  //Icon(Icons.location_on, color: Colors.purple),
                  Padding(
                    padding: const EdgeInsets.only(bottom:16),
                    child: DefaultTextStyle(
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline6
                            .copyWith(color: Colors.grey[700]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[Text("时间"), Text("地点"), Text("报酬")],
                        )),
                  ),
                  ClipRect(
                      child: Align(
                        heightFactor: _heightFactor.value,
                        child: Opacity(
                          opacity: _opacity.value,
                          child: Column(
                            children: <Widget>[
                              Text("1235566"),
                              ButtonBar(
                                alignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FlatButton.icon(
                                      color: Colors.purple[200], //Color(0xFFBB86FC),
                                      textColor: Colors.white,
                                      onPressed: () {},
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
