// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'startPage.dart';
import 'HomePage.dart';
import 'loginPage.dart';

Dio dio = Dio();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tsingvat',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Color(0xffb2ebf2),
        primaryColorLight: Color(0xffe5ffff),
        primaryColorDark: Color(0xff81b9bf),
        // secondaryColor: Color(0xba68c8),
        // secondaryLightColor: Color(0xee98fb),
        // secondaryDarkColor: Color(0x883997),
        // primaryTextColor: Color(0x121a60),
        // secondaryTextColor: Color(0xffffff),

        // accentIconTheme:
        //     Theme.of(context).accentIconTheme.copyWith(color: Colors.white),
        // iconTheme:
        //     Theme.of(context).accentIconTheme.copyWith(color: Colors.white),
        // primaryIconTheme:
        //     Theme.of(context).accentIconTheme.copyWith(color: Colors.white)
      ),
      initialRoute: 'startPage',
      routes: {
        'startPage': (context) => startPage(),
        'loginPage': (context) => Login(),
        'homepage': (context) => HomePage(title: 'Flutter Demo Home Page')
      },
      //home: Login(),
    );
  }
}
