import 'package:flutter/material.dart';
import 'package:tsingvat/component/taskcard.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      print("刷新结束");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        //padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white70, //Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: RefreshIndicator(
            child: ListView.builder(itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TaskCard(),
              );
            }),
            onRefresh: _refresh));
  }
}
