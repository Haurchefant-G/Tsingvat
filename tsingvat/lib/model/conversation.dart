import 'package:tsingvat/const/const_url.dart';

import '../style/style.dart';

class Conversation {
  // Conversation表示主页面下的聊天框，点击后即可进入详细界面
  String avatar;
  String title;
  int titleColor;
  String des;
  String updateAt;
  bool isMute;
  int unreadMsgCount;
  bool displayDot;
  int groupId;
  String userId;
  int type;

  bool isAvatarFromNet() {
    if (this.avatar.indexOf('http') == 0 || this.avatar.indexOf('https') == 0) {
      return true;
    }
    return false;
  }

  Conversation(
      {this.avatar,
      this.title,
      this.titleColor: AppColors.TitleColor,
      this.des,
      this.updateAt,
      this.isMute: false,
      this.unreadMsgCount: 0,
      this.displayDot: false,
      this.groupId,
      this.userId,
      this.type})
      : assert(avatar != null),
        assert(title != null),
        assert(updateAt != null);

  static List<Conversation> getMockConversations() {
    return mockConversations;
  }

  static void initMockConversations(List chatlist) {
    mockConversations = [];
    for (var user in chatlist) {
      mockConversations.add(
        Conversation(
          avatar: ConstUrl.avatarimageurl + "/gac/avatar.png",
          title: user['username'],
          // des: '[模拟数据]',
          // updateAt: '19:56',
          // unreadMsgCount: 0,
          // displayDot: true,
          // groupId: 000000,
          // userId:"000000",
          // type: 1
        ),
      );
    }
  }

  static void MockConversationsAdd(String username) {
      mockConversations.add(
        Conversation(
          avatar: ConstUrl.avatarimageurl + "/${username}/avatar.png",
          title: user['username'],
          // des: '[模拟数据]',
          // updateAt: '19:56',
          // unreadMsgCount: 0,
          // displayDot: true,
          // groupId: 000000,
          // userId:"000000",
          // type: 1
        ),
      );
  }


  static List<Conversation> mockConversations;
  // = [
  //   Conversation(
  //     avatar: ConstUrl.avatarimageurl + "/gac/avatar.png",
  //     title: 'zxj',
  //     // des: '[模拟数据]',
  //     // updateAt: '19:56',
  //     // unreadMsgCount: 0,
  //     // displayDot: true,
  //     // groupId: 000000,
  //     // userId:"000000",
  //     // type: 1
  //   ),
  //   Conversation(
  //       avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
  //       title: '特朗普',
  //       des: '今晚要一起去china吗？',
  //       updateAt: '17:56',
  //       isMute: true,
  //       unreadMsgCount: 0,
  //       groupId: 000000,
  //       userId: "000000",
  //       type: 1),
  //   Conversation(
  //       avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
  //       title: 'Tina Morgan',
  //       des: '晚自习是什么来着？你知道吗，看到的话赶紧回复我',
  //       updateAt: '17:58',
  //       isMute: false,
  //       unreadMsgCount: 0,
  //       groupId: 000000,
  //       userId: "000000",
  //       type: 1),
  //   Conversation(
  //       avatar: 'https://randomuser.me/api/portraits/women/57.jpg',
  //       title: 'Lily',
  //       des: '今天要去运动场锻炼吗？',
  //       updateAt: '昨天',
  //       isMute: false,
  //       unreadMsgCount: 0,
  //       groupId: 000000,
  //       userId: "000000",
  //       type: 1),
  //   Conversation(
  //     avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
  //     title: '汤姆丁',
  //     des: '今晚要一起去吃肯德基吗？',
  //     updateAt: '17:56',
  //     isMute: true,
  //     unreadMsgCount: 0,
  //   ),
  // ];
}
