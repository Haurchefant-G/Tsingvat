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
        var messageList = Provide.value<WebSocketProvide>(context).messageList;
        var length = Conversation.mockConversations.length + 1 + messageList.length;
        print(length);
        return Container(
          child: ListView.builder(
            itemBuilder:  (BuildContext context, int index){
              if (index < Conversation.mockConversations.length + 1){
                return ConversationItem(Conversation.mockConversations[index - 1],index-1,0);
              }else {
                var inde = index - 1 - Conversation.mockConversations.length;
                return ConversationItem(messageList[inde],inde,1);
              }
            },
            itemCount: length ,
          )
        );
      }
    );
  }
}