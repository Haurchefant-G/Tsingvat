import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsingvat/component/takederrandcard.dart';
import 'package:tsingvat/util/GradientUtil.dart';
import 'package:tsingvat/component/infocard.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            InfoCard(),
            Container(
              margin: EdgeInsets.fromLTRB(300.w, 20, 0, 20),
              padding: EdgeInsets.fromLTRB(20.w, 20, 20.w, 20),
              //alignment: Alignment.centerRight,
              width: 750.w,
              decoration: BoxDecoration(
                //color: Colors.grey,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(20.w)),
                gradient: GradientUtil.warmFlame(angle: 180, opacity: 0.4),
              ),
              child: 
              // Row(
              //   children: <Widget>[
              //     Icon(Icons.calendar_today, color: Colors.blueGrey, size: Theme.of(context).primaryTextTheme.headline5.fontSize,),
                  Text("待完成任务", style: Theme.of(context).primaryTextTheme.headline5.copyWith(letterSpacing: 10, color: Colors.blueGrey, textBaseline: TextBaseline.ideographic), 
                  ),
              //   ],
              // ),
              ),
              TakedErrandCard(),
              TakedErrandCard(),
          ],
        ),
      ),
    );
  }
}