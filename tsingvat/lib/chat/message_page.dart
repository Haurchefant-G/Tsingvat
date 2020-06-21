import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:tsingvat/style/style.dart' show ICons,AppColors;
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
        var length = Conversation.mockConversations.length + 1;
        print(length);
        return Container(
          child: ListView.builder(
            itemBuilder:  (BuildContext context, int index){
              if (index < Conversation.mockConversations.length + 1){
                return ConversationItem(Conversation.mockConversations[index],Conversation.mockConversations[index].title,0);
              }
//              else {
//                var inde = index - 1 - Conversation.mockConversations.length;
//                return ConversationItem(,inde,1);
//              }
            },
            itemCount: length ,
          )
        );
      }
    );
  }
}