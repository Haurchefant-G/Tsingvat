import 'package:flutter/material.dart';
import 'package:tsingvat/component/errandcard.dart';

class ErrandPage extends StatefulWidget {
  @override
  _ErrandPageState createState() => _ErrandPageState();
}

class _ErrandPageState extends State<ErrandPage> {
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
                child: ErrandCard(),
              );
            }),
            onRefresh: _refresh));
  }
}
