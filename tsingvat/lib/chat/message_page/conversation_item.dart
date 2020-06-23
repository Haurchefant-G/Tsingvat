import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsingvat/style/style.dart' show AppColors,Constants,ICons;
import 'package:tsingvat/model/conversation.dart';
import 'package:tsingvat/routers/application.dart';

import '../chat_detail_page.dart';
class ConversationItem extends StatelessWidget {

  ConversationItem(this.conversationItemData,this.username,this.chat_type)
  :assert(conversationItemData != null);
  String username;
  int chat_type;
  final Conversation conversationItemData;
  var tapPos;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(AppColors.ConversationItemBg),
      child: InkWell(
        onTap: (){
          print('打开会话:${conversationItemData.nickname}');
//          Application.router.navigateTo(context, '/chatdetail?index=${username}');
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context){
                print('username:${username}');
                return ChatDetailPage(username);
              })
          );
        },
        onTapDown: (TapDownDetails details) {
          tapPos = details.globalPosition;
        },
        onLongPress: (){
          _showMenu(context,tapPos);
          print('弹出会话菜单:${conversationItemData.nickname}');
        },
        child: Container(
          height: ScreenUtil().setHeight(120),
          child: Row(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: <Widget>[
              avatarContainer(conversationItemData),
              Content(),
            ],
          ),
        ),
      ),
    ); 
  }
  _showMenu(BuildContext context,Offset tapPos){
    final RenderBox overlay =Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromLTRB(
      tapPos.dx, tapPos.dy,
      overlay.size.width - tapPos.dx,
      overlay.size.height - tapPos.dy
    );
    showMenu<String>(
      context: context,
      position: position,
      items: <PopupMenuItem<String>>[
        PopupMenuItem(
          child: Text(Constants.MENU_MARK_AS_UNREAD_VALUE),
          value: Constants.MENU_MARK_AS_UNREAD,
        ),
        PopupMenuItem(
          child: Text(Constants.MENU_PIN_TO_TOP_VALUE),
          value: Constants.MENU_PIN_TO_TOP,
        ),
        PopupMenuItem(
          child: Text(Constants.MENU_DELETE_CONVERSATION_VALUE),
          value: Constants.MENU_DELETE_CONVERSATION,
        ),
      ]
    ).then<String>((String selected) {
      switch(selected){
        default:
          print('当前选中的是：$selected');
      }
    });
  }

  Widget Content(){
    return Expanded(
      child: Container(
        height: ScreenUtil().setHeight(120),
        margin: EdgeInsets.only(left:ScreenUtil().setWidth(20.0)),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5,color: Color(AppColors.DividerColor),)
          )
        ),
        child: Row(
          children: <Widget>[
            Title(conversationItemData),
            Tip(conversationItemData)
          ],
        ),
      ),
    );
  }
  Widget ClipRRectImg(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: conversationItemData.isAvatarFromNet() ?  Image.network(conversationItemData.avatar,scale: 1.0, fit: BoxFit.cover,) : Image.asset(conversationItemData.avatar, fit: BoxFit.cover,),
    );
  } 

  Widget Avatar(conversationItemData){
    return Container(
      margin: EdgeInsets.only(left:ScreenUtil().setWidth(20.0)),
      child: ClipRRectImg(),
      width: ScreenUtil().setWidth(100),
      height: ScreenUtil().setWidth(100)
    );
  }

  Widget Title(conversationItemData){
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            conversationItemData.nickname,
            style: TextStyle(fontSize: ScreenUtil().setSp(30.0),color: Color(AppColors.TitleColor),fontWeight:FontWeight.w400),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: ScreenUtil().setHeight(15.0),),
          Text(
            conversationItemData.lastMsg,
            style: TextStyle(fontSize: ScreenUtil().setSp(24.0),color: Color(AppColors.DesTextColor)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

 
  Widget Tip(conversationItemData){  
    var _rightArea =<Widget>[
      Text(conversationItemData.updateAt,style:TextStyle(fontSize: ScreenUtil().setSp(24.0),color: Color(AppColors.DesTextColor))),
      SizedBox(height: ScreenUtil().setHeight(15.0),)
    ];
    if(conversationItemData.isMute){
      _rightArea.add(new Icon(Icons.volume_mute,color: Color(AppColors.ConversationMuteIcon),size: ScreenUtil().setSp(30),));
    }else{
      _rightArea.add(new Icon(Icons.volume_mute,color: Colors.transparent,size: ScreenUtil().setSp(30),));
    }
    return Container(
      width:ScreenUtil().setWidth(80),
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(10.0)),
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: _rightArea
      ),
    );
  }

  Widget avatarContainer(conversationItemData){
    if(conversationItemData.unreadMsgCount > 0){
      return Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Avatar(conversationItemData),
        ],
      );
    }else{
      return Avatar(conversationItemData);
    }
  }

  Widget muteIcon(){
    return Icon(Icons.volume_mute);
  }
}