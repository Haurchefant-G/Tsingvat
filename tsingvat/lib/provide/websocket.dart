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
  var nickname = 'LittleHealth';
  List<String> users = [];  // 用户
  var groups =[];  // 群聊
  var historyMessage = [];//接收到的所有的历史消息
  List<List<Msg>> messageList = []; // 所有消息页面人员，包括groups和users
  var currentMessageList = [];//选择进入详情页的消息历史记录
  Msg currentMessage;
  var connecting = false;//websocket连接状态
  IOWebSocketChannel channel;

  WebSocketProvide(){
    init();
  }

  
  init() async {
    print("init websocket");
//    String usrname = await SharedPreferenceUtil.getString("username");
//    if(usrname == null){
//      username = "zxj";
//      nickname = "zxj";
//    }
//    else {
//      username = usrname;
//    }
    print("username${username}  nickname:${nickname}");
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
    print("data${data}");
    int code = json["code"];
    String msg = json["msg"];
    print("before list");
    List<Msg> msgs = [];
    print("after list");
    var mss = json["data"];
    if(mss is List){
      for(var m in mss) {
        print("m is ${m}");
        msgs.add(Msg.fromJson(m));
      }
    }else {
      Msg _msg = Msg.fromJson(mss);
      msgs.add(_msg);
    }
    print("mss ${mss}");

    // 需要维护特定的conversition
    for(Msg msg in msgs){
      num i = users.indexOf(msg.sender);
      print("i is ${i}");
      if(i==-1){
        users.add(msg.sender);
        List<Msg> ms = [];
        ms.add(msg);
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
  sendMessage(receiver, content, type){//发送消息
    var obj = {
      "sender": username,
      "receiver":receiver,
      "content": content,
      "type":type
    };
    
    String text = json.encode(obj).toString();
    print("sendMsg ${text}");
    num index = users.indexOf(receiver);
    if(index == -1){
      users.add(receiver);
      messageList.add([]);
    }
    index = users.indexOf(receiver);
    Msg msg = new Msg();
    msg.sender = username;
    msg.receiver = receiver;
    msg.content = content;
    msg.type = type;
    messageList[index].add(msg);
//    currentMessage = msg;
    channel.sink.add(text);
    notifyListeners();
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