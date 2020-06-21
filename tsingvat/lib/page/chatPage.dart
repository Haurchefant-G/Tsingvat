import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatPage extends StatefulWidget {
  String chatUsername;
  ChatPage(String username) {
    chatUsername = username;

  }
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String name;
  double price;
  String detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Center(child: Text(widget.chatUsername??"username")), automaticallyImplyLeading: false,),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border.all(
            
            color: Colors.blueAccent,
            width: 3
          ),
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: CircleAvatar(child: Image.network(''),radius: 30,)),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              CachedNetworkImage(imageUrl: 'img'),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
