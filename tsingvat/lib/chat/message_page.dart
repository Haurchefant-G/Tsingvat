import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import './message_page/conversation_item.dart';
import '../model/conversation.dart';
import '../provide/websocket.dart';

class MessagePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provide<WebSocketProvide>(
      builder: (context,child,val){
        //  参与聊天的用户
        var users = Provide.value<WebSocketProvide>(context).users;
        // 需要加入之前已存在的用户
        var length = Conversation.getMockConversations().length+1;
        print(length);
        return Scaffold(
          appBar: AppBar(title: Text("聊天")),
                  body: Container(
            child: ListView.builder(
              itemBuilder:  (BuildContext context, int index){
                if (index < Conversation.getMockConversations().length){
                  print("index is ${index}, length:${Conversation.mockConversations.length}");
                  return ConversationItem(Conversation.mockConversations[index],Conversation.mockConversations[index].nickname,0);
                }
              },
              itemCount: length ,
            )
          ),
        );
      }
    );
  }
}