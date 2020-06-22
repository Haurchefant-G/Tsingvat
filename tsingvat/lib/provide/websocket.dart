import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:tsingvat/model/msg.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import '../model/conversation.dart';
class WebSocketProvide with ChangeNotifier{
  var username = 'zxj';
  var nickname = '';
  List<String> users = [];  // 用户
  var groups =[];  // 群聊
  var historyMessage = [];//接收到的所有的历史消息
  List<List<Msg>> messageList = []; // 所有消息页面人员，包括groups和users
  var currentMessageList = [];//选择进入详情页的消息历史记录
  var connecting = false;//websocket连接状态
  IOWebSocketChannel channel;
  
  
  init() async {
    String usrname = await SharedPreferenceUtil.getString("username");
    if(usrname == null){
      username = "zxj";
      nickname = "zxj";
    }
    else {
      username = usrname;
      nickname = await SharedPreferenceUtil.getString("nickname");
    }
    return await createWebsocket();
    // monitorMessage();
  }
  createWebsocket() async {//创建连接并且发送鉴别身份信息
    channel = await new IOWebSocketChannel.connect('ws://121.199.66.17:8800/websocket/'+username);
    print("连接功");
    channel.stream.listen((data) => listenMessage(data),onError: onError,onDone: onDone);
  }
    
  listenMessage(data){
    connecting = true;
    var json = jsonDecode(data);
    print(data);
    int code = json["code"];
    String msg = json["msg"];
    List<Msg> msgs = [];
    for(var m in json["data"]){
      msgs.add(Msg.fromJson(m));
    }
    // 需要维护特定的conversition
    for(Msg msg in msgs){
      num i = users.indexOf(msg.receiver);
      if(i==-1){
        users.add(msg.receiver);
        List<Msg> ms = [];
        messageList.add(ms);
      }
      else {
        // 第i表示对应第i个接受者
        // messagelist[i]表示第i个接受者的所有信息
        messageList[i].add(msg);
      }
    }
    print(messageList);

    notifyListeners();
  }

  /**
   * index指定是哪个messageList
   * data是消息
   */
  sendMessage(receiver, msg, type){//发送消息
    var obj = {
      "sender": username,
      "receiver":receiver,
      "msg": msg,
      "type":type
    };
    String text = json.encode(obj).toString();
    print(text);
//    channel.sink.add(text);
  }
  onError(error){
    print('error------------>${error}');
  }

  void onDone() {
    print('websocket断开了');
    createWebsocket();
    print('websocket重连');
  }

  closeWebSocket(){//关闭链接
    channel.sink.close();
    print('关闭了websocket');
    notifyListeners();
  }
}