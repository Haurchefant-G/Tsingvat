import 'package:tsingvat/const/const_url.dart';

import '../style/style.dart';

class Conversation {
  // Conversation表示主页面下的聊天框，点击后即可进入详细界面
  String avatar; // 头像
  String nickname; // 昵称
  int titleColor; // 昵称颜色，默认黑色
  String lastMsg; // 在用户界面显示的最近一次聊天记录
  String updateAt; // 最近一次更新时间
  bool isMute; //是否静音
  int unreadMsgCount; // 未读消息的数量
  String receiver;
  int type;

  bool isAvatarFromNet() {
    if (this.avatar.indexOf('http') == 0 || this.avatar.indexOf('https') == 0) {
      return true;
    }
    return false;
  }

  Conversation(
      {this.avatar,
      this.nickname,
      this.titleColor: AppColors.TitleColor,
      this.lastMsg,
      this.updateAt,
      this.isMute: false,
      this.unreadMsgCount: 0, // 未读的消息数量
      this.receiver,
      this.type})
      : assert(avatar != null),
        assert(nickname != null),
        assert(updateAt != null);

  static List<Conversation> getMockConversations() {
    return mockConversations;
  }

  static void initMockConversations(List chatlist) {
    mockConversations = [];
    for (var user in chatlist) {
      mockConversations.add(
        Conversation(
          avatar: ConstUrl.avatarimageurl + "/${user['nickname']}/avatar.png",
          nickname: '${user['nickname']}',
          updateAt: "${user['updateAt']}"
        ),
      );
    }
  }

  static void addMockConversations(String username) {
    mockConversations.add(
      Conversation(
        avatar: ConstUrl.avatarimageurl + "/${username}/avatar.png",
        nickname: username,
        updateAt: '',
        lastMsg: '最近的一条消息'
      ),
    );
  }

  static List<Conversation> mockConversations = [];
}
