// import 'dart:js';

//import 'dart:js';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:provide/provide.dart';
import 'package:tsingvat/chat/chatglobal.dart';
import 'package:tsingvat/provide/currentIndex.dart';
import 'package:tsingvat/provide/websocket.dart';
import 'startPage.dart';
import 'HomePage.dart';
import 'loginPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Dio dio = Dio();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ChatGlobal.init();
  print("websocket${ChatGlobal.websocketProvide}");
  ChatGlobal.providers
    ..provide(Provider<CurrentIndexProvide>.value(ChatGlobal.currentIndexProvide))
    ..provide(Provider<WebSocketProvide>.value(ChatGlobal.websocketProvide));
  runApp(ProviderNode(child: MyApp(), providers: ChatGlobal.providers));
  // runApp(MyApp());

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1334, allowFontScaling: true);
    return MaterialApp(
      title: 'Tsingvat',
      theme: ThemeData(
        fontFamily: "Montserrat",
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Color(0xffb2ebf2),
        primaryColorLight: Color(0xffe5ffff),
        primaryColorDark: Color(0xff81b9bf),
      ),
      initialRoute:
          //'homePage',
          'startPage',
      //'messagePage',
      routes: {
        'startPage': (context) => StartPage(),
        'loginPage': (context) => Login(),
        'homePage': (context) => HomePage(title: 'Home Page'),
      },
      //home: Login(),
    );
  }
}
