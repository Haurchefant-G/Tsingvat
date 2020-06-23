import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:tsingvat/const/const_url.dart';
import '../provide/websocket.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsingvat/style/style.dart';
import './chat_detail/chat_content_view.dart';
import '../model/conversation.dart';
import 'package:tsingvat/model/msg.dart';


class ChatDetailPage extends StatefulWidget {
  int type = 1;
  int index;
  String username;
  ChatDetailPage(this.username);
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState(username);
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  List<Map<String, Object>>list = [];
  List<String> uuids = [];
  ScrollController _scrollController;
  bool hasText = false;
  // 现在的情况只支持type=1，即type表示私聊，而非群聊
  int type = 1;
  int index;
  String username;// username指接收者的
  Conversation data;
  _ChatDetailPageState(this.username);
  
  final controller = TextEditingController();
  void _handleSubmitted(String text) {
      if (controller.text.length > 0) {
        print('发送${text}');
        Provide.value<WebSocketProvide>(context).sendMessage(username,text,1);
        setState(() {
          hasText = false;
          print("set");
          list.add({'type':1,'content':text,'avatar':"http://121.199.66.17:8800/images/account/zxj/avatar.png"});
        });
        controller.clear(); //清空输入框
        _jumpBottom();
      }
  }
  void _jumpBottom(){//滚动到底部
    _scrollController.animateTo(99999,curve: Curves.easeOut, duration: Duration(milliseconds: 200));
  }
  @override
  void initState(){
    super.initState();
    print("initstate");
    _scrollController = new ScrollController();
    // _jumpBottom();
  }
  @override
  Widget build(BuildContext context) {

    print('build is ${username}');
    List<String> users = Provide.value<WebSocketProvide>(context).users;
    print(users);
    String receiver;
    return Scaffold(
      appBar: AppBar(
        centerTitle:false,
        title: Text(username, style: TextStyle(fontSize: ScreenUtil().setSp(30.0),color: Color(AppColors.APPBarTextColor),),),
        iconTheme: IconThemeData(
          color: Color(AppColors.APPBarTextColor)
        ),
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          Container(
              child: IconButton(
                icon: Icon(Icons.menu,color: Color(AppColors.APPBarTextColor),),
                onPressed: (){
                  print('点击了聊天信息界面');
                },
              ),
            ),
        ]
      ),
      body: Container(
        color: Color(AppColors.ChatDetailBg),
        child: Column(
          children: <Widget>[
            Provide<WebSocketProvide>(
              builder: (context,child,websocket){
                list = [];
              var users = websocket.users;
              index = users.indexOf(username);
//                list.add({'type':0,'content':"hello",'nickname':"nick",'avatar':"http://121.199.66.17:8800/images/account/gac/avatar.png"});
//                list.add({'type':1,'content':"hi",'nickname':"nick",'avatar':"http://121.199.66.17:8800/images/account/zxj/avatar.png"});
                print("index ${index}, username ${username}");
                if(index != -1){
                  List<Msg> msgs = websocket.users_message_list[index];
                  for(Msg msg in msgs){
                    // 判断必然相等
                    if(msg.sender ==  username){
                      // 对方发出的消息
//                      if(uuids.indexOf(msg.uuid) == -1) {
                        String avatar = ConstUrl.avatarimageurl + "/" +
                            username + "/avatar.png";
                        list.add({
                          'type': 0,
                          'content': msg.content,
                          'nickname': username,
                          'avatar': avatar
                        });
//                        uuids.add(msg.uuid);
//                      }
                    }
                    else if(msg.receiver == username){
                      // 自己发出的消息
                      print("content: ${msg.content}  sender:${msg.sender}");
                        String avatar = ConstUrl.avatarimageurl + "/" + msg.sender +"/avatar.png";
                        list.add({'type':1,'content':msg.content,'nickname':msg.sender,'avatar':avatar});
                    }
                  }
                }
                return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
//                    physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return ChatContentView(type:list[index]['type'], content:list[index]['content'], avatar:list[index]['avatar'] , isNetwork: true, sender:list[index]['nickname'], userType:0);
                  },
                  itemCount: list.length
                  )
                );
            }),
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(2.0), bottom:ScreenUtil().setHeight(2.0),left: 0,right: 0),
              color: Color(0xFFF7F7F7),
              child: Row(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(60.0),
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(20.0)),
                    child:  IconButton(
                      icon: Icon(Icons.keyboard_voice),
                      onPressed: () {
                        print('切换到语音');
                      } 
                    ), 
                  ),
                  Expanded(
                    child: Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(10), bottom: ScreenUtil().setHeight(10)),
                    height: ScreenUtil().setHeight(60.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.white
                    ),
                    child: TextField(
                      scrollPadding: EdgeInsets.only(top: ScreenUtil().setHeight(0), bottom: ScreenUtil().setHeight(60)),
                      controller: controller,
                      decoration: InputDecoration.collapsed(hintText: null),
                      maxLines: 1,
                      autocorrect: true,
                      autofocus: false,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).primaryTextTheme.headline6,
                      //cursorColor: Colors.green,
                      onChanged: (text) {
                        setState(() {
                            hasText = text.length > 0 ?  true : false; 
                        });
                        print('change=================== $text');
                      },
                      onSubmitted:_handleSubmitted,
                      enabled: true, //是否禁用
                    ),
                  )),
                  Container(
                    width: ScreenUtil().setWidth(60.0),
                    child:  IconButton(
                      icon: Icon(Icons.face), //发送按钮图标
                      onPressed: () {
                        print('打开表情面板');
                      } 
                    ), 
                  ),
                  Container(
                    width: ScreenUtil().setWidth(60.0),
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(20.0)),
                    child:  IconButton(
                      //发送按钮或者+按钮
                      icon: hasText ? Icon(Icons.send) :Icon(Icons.add), //发送按钮图标
                      onPressed: () {
                        if(!hasText){
                          print('打开功能面板');
                        }else{
                          _handleSubmitted(controller.text);
                        }
                      } 
                    ), 
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

