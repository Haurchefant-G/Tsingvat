import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import '../model/conversation.dart';
class WebSocketProvide with ChangeNotifier{
  var username = 'zxj';
  var nickname = '';
  var users = [];  // 用户
  var groups =[];  // 群聊
  var historyMessage = [];//接收到的所有的历史消息
  var messageList = []; // 所有消息页面人员，包括groups和users
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
    channel = await new IOWebSocketChannel.connect('ws://121.199.66.17:8080/websocket/'+username);
//    var obj = {
//      "username ": username ,
//      "type": 1,
//      "nickname": nickname,
//      "msg": "",
//      "bridge": [],
//      "groupId": ""
//    };
//    String text = json.encode(obj).toString();
//    channel.sink.add(text);
    //监听到服务器返回消息
    channel.stream.listen((data) => listenMessage(data),onError: onError,onDone: onDone);
  }
    
  listenMessage(data){
    connecting = true;
    var obj = jsonDecode(data);
    print(data);
//    if(obj['type'] == 1){ // 获取聊天室的人员与群列表
//      messageList = [];
//      print(obj['msg']);
//      users = obj['users'];
//      groups = obj['groups'];
//      for(var i = 0; i < groups.length; i++){
//        messageList.add(new Conversation(
//          avatar: 'assets/images/ic_group_chat.png',
//          title: groups[i]['name'],
//          des: '点击进入聊天',
//          updateAt: obj['date'].substring(11,16),
//          unreadMsgCount: 0,
//          displayDot: false,
//          groupId: groups[i]['id'],
//          type: 2
//        ));
//      }
//      for(var i = 0; i < users.length; i++){
//        if(users[i]['username '] != username ){
//          messageList.add(new Conversation(
//            avatar: 'assets/images/ic_group_chat.png',
//            title: users[i]['nickname'],
//            des: '点击进入聊天',
//            updateAt: obj['date'].substring(11,16),
//            unreadMsgCount: 0,
//            displayDot: false,
//            userId:users[i]['username '],
//            type: 1
//          ));
//        }
//      }
//    }else if (obj['type'] == 2){//接收到消息
//      historyMessage.add(obj);
//      print(historyMessage);
//      for(var i = 0; i < messageList.length; i++){
//        if(messageList[i].userId != null){
//          var count = 0;
//          for(var r = 0; r < historyMessage.length; r++){
//            if(historyMessage[r]['status']==1 &&  historyMessage[r]['bridge'].contains(messageList[i].userId) && historyMessage[r]['username '] != username ){
//              count++;
//            }
//          }
//          if(count > 0){
//            messageList[i].displayDot = true;
//            messageList[i].unreadMsgCount = count;
//          }
//        }
//        if(messageList[i].groupId != null){
//          var count = 0;
//          for(var r = 0; r < historyMessage.length; r++){
//            if(historyMessage[r]['status']==1 &&  historyMessage[r]['groupId']==messageList[i].groupId && historyMessage[r]['username '] != username ){
//              count++;
//            }
//          }
//          if(count > 0){
//            messageList[i].displayDot = true;
//            messageList[i].unreadMsgCount = count;
//          }
//        }
//      }
//    }
    notifyListeners();
  }

  /**
   * index指定是哪个messageList
   * data是消息
   */
  sendMessage(type,data,index){//发送消息
//    print(messageList[index].userId);
//    print(messageList[index].groupId);
//    var _bridge = [];
//    if(messageList[index].userId != null){
//      _bridge..add(messageList[index].userId)..add(username );
//    }
//    int _groupId;
//    if(messageList[index].groupId != null){
//      _groupId = messageList[index].groupId;
//    }
//    print(_bridge);
    var obj = {
      "sender": username ,
//      "type": 2,
      "receiver":"zxj",
      "nickname": nickname,
      "msg": data,
//      "bridge": _bridge ,
//      "groupId": _groupId
    };
    String text = json.encode(obj).toString();
    print(text);
    channel.sink.add(text);
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