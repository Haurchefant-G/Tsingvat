import 'package:tsingvat/const/const_url.dart';

import '../style/style.dart';

class Conversation {
  // Conversation表示主页面下的聊天框，点击后即可进入详细界面
  String avatar; // 头像
  String nickname; // 昵称
  int titleColor; // 昵称颜色，默认黑色
  String lastMsg;  // 在用户界面显示的最近一次聊天记录
  String updateAt; // 最近一次更新时间
  bool isMute;  //是否静音
  int unreadMsgCount; // 未读消息的数量
  String receiver;
  int type;

  bool isAvatarFromNet() {
    if(this.avatar.indexOf('http') == 0 || this.avatar.indexOf('https') == 0) {
      return true;
    }
    return false;
  }

  Conversation({
    this.avatar,
    this.nickname,
    this.titleColor : AppColors.TitleColor,
    this.lastMsg,
    this.updateAt,
    this.isMute : false,
    this.unreadMsgCount : 0, // 未读的消息数量
    this.receiver,
    this.type
  }) :  assert(avatar != null),
        assert(nickname != null),
        assert(updateAt != null);

  static List<Conversation> getMockConversations(){
    return mockConversations;
  }

  static List<Conversation> mockConversations  = [
    Conversation(
        avatar: ConstUrl.avatarimageurl+"/gac/avatar.png",
        nickname: 'zxj',
        lastMsg: '[模拟数据]',
        updateAt: '19:56',
        unreadMsgCount: 0,
        receiver:"000000",
        type: 1
    ),
    Conversation(
        avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
        nickname: '特朗普',
        lastMsg: '今晚要一起去china吗？',
        updateAt: '17:56',
        isMute: true,
        unreadMsgCount: 0,
        receiver:"000000",
        type: 1
    ),
    Conversation(
       avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
       nickname: 'Tina Morgan',
       lastMsg: '晚自习是什么来着？你知道吗，看到的话赶紧回复我',
       updateAt: '17:58',
       isMute: false,
       unreadMsgCount: 0,
       receiver:"000000",
       type: 1
     ),
     new Conversation(
       avatar: 'https://randomuser.me/api/portraits/women/57.jpg',
       nickname: 'Lily',
       lastMsg: '今天要去运动场锻炼吗？',
       updateAt: '昨天',
       isMute: false,
       unreadMsgCount: 0,
       receiver:"000000",
       type: 1
     ),
    Conversation(
       avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
       nickname: '汤姆丁',
       lastMsg: '今晚要一起去吃肯德基吗？',
       updateAt: '17:56',
       isMute: true,
       unreadMsgCount: 0,
     ),
  ];
}