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
    return Scaffold(
      body: InfoCard(),
    );
  }
}