import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provide/provide.dart';
import 'package:tsingvat/const/const_url.dart';
import 'package:tsingvat/model/conversation.dart';
import 'package:tsingvat/model/me.dart';
import 'package:tsingvat/provide/currentIndex.dart';
import 'package:tsingvat/provide/websocket.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';

class ChatGlobal {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static List chatusers;
  static Profile me = Profile();
  static Providers providers;
  static CurrentIndexProvide currentIndexProvide;
  static WebSocketProvide websocketProvide;
  static BuildContext context;

  static Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    print('onDidReceiveLocalNotification');
  }

  static Future init() async {

    providers = Providers();
    currentIndexProvide = CurrentIndexProvide();
    websocketProvide = WebSocketProvide();
     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification:
            ChatGlobal.onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: websocketProvide.topage);
  }

  static Future initWhenlogin() async {
    String list = await SharedPreferenceUtil.getString("chatlist") ?? '[]';
    print(list);
    chatusers = json.decode(list);
    print(chatusers);
    Conversation.initMockConversations(chatusers);
    me.avatar = await SharedPreferenceUtil.getString("avatar");
    me.name = await SharedPreferenceUtil.getString("username");
    websocketProvide.createWebsocket(me.name);
  }

  // static Future initMe() async {
  //   me.avatar = await SharedPreferenceUtil.getString("avatar");
  //   me.name = await SharedPreferenceUtil.getString("username");
  // }

  static Future addUser(String username) {
    for (var userinfo in chatusers) {
      if (userinfo['nickname'] == username) {
        return null;
      }
    }
    Conversation.addMockConversations(username);
    chatusers.add({
      'avatar': ConstUrl.avatarimageurl + "/${username}/avatar.png",
      'nickname': username,
      'updateAt': '',
      'lastMsg': ''
    });
    print(chatusers);
    SharedPreferenceUtil.setString("chatlist", json.encode(chatusers));
  }
}
